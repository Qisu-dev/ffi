///|
fn eprintln(message : String) -> Unit {
  let full = message + "\n"
  let cstr = @ffi.string_to_cstr(full)
  defer @ffi.free(cstr)
  let len = @ffi.strlen(cstr)
  let _ = @ffi.fwrite(cstr, 1, len, @ffi.get_stderr())
}

///|
/// 初始化控制台编码。
#cfg(platform="windows")
fn setup_console() -> Unit {
  @ffi.set_console_cp(65001)
}

///|
/// POSIX 版：无操作。
#cfg(not(platform="windows"))
fn setup_console() -> Unit {

}

///|
fn main {
  setup_console()

  let command = command()
  let argv = @env.args()
  let matches = command.parse(argv=argv[1:]) catch {
    e => {
      eprintln(e.to_string())
      @ffi.exit(1)
      panic()
    }
  }

  let files = matches.values["files"]

  for file in files {
    cat_file(file) catch {
      e => {
        eprintln(e.message())
        @ffi.exit(1)
      }
    }
  }
}

///|
/// cat 的错误类型。
suberror CatError {
  /// 文件不存在
  FileNonexistent(name~ : String)
  /// 权限不足
  PermissionDenied(name~ : String)
  /// 是目录
  IsDirectory(name~ : String)
  /// 打开失败（其他原因）
  OpenFailed(name~ : String, errno~ : Int)
  /// 读取失败
  ReadFailed(name~ : String, errno~ : Int)
  /// 写入失败（stdout）
  WriteFailed(errno~ : Int)
  /// 内存分配失败
  OutOfMemory
  StatFailed(name~ : String, errno~ : Int)
  MmapFailed(name~ : String, errno~ : Int)
} derive(Debug)

///|
fn CatError::message(self : CatError) -> String {
  match self {
    FileNonexistent(name~) =>
      "failed to open `\{name}`: No such file or directory (os error \{@ffi.enoent()})"
    PermissionDenied(name~) =>
      "failed to open `\{name}`: Permission denied (os error \{@ffi.eacces()})"
    IsDirectory(name~) =>
      "failed to read `\{name}`: Is a directory (os error \{@ffi.eisdir()})"
    OpenFailed(name~, errno~) =>
      "failed to open `\{name}`: \{errno_message(errno)} (os error \{errno})"
    ReadFailed(name~, errno~) =>
      "failed to read `\{name}`: \{errno_message(errno)} (os error \{errno})"
    WriteFailed(errno~) =>
      "failed to write: \{errno_message(errno)} (os error \{errno})"
    OutOfMemory => "failed to allocate memory"
    MmapFailed(name~, errno~) =>
      "failed to mmap `\{name}`: \{errno_message(errno)} (os error \{errno})"
    StatFailed(name~, errno~) =>
      "failed to get fstate `\{name}`: \{errno_message(errno)} (os error \{errno})"
  }
}

///|
fn errno_message(errno : Int) -> String {
  let cstr = @ffi.strerror(errno)
  if @ffi.is_null(cstr) {
    "unknown error (\{errno})"
  } else {
    @ffi.cstr_to_string(cstr)
  }
}

///|
#cfg(platform="windows")
fn open_flags() -> Int {
  @ffi.o_rdonly() | @ffi.o_binary()
}

///|
#cfg(not(platform="windows"))
fn open_flags() -> Int {
  @ffi.o_rdonly()
}

///|
const MMAP_THRESHOLD : Int64 = 65536 // 64KB

///|
fn cat_file(name : String) -> Unit raise CatError {
  let file_name = @ffi.string_to_cstr(name)
  defer @ffi.free(file_name)

  let fd = @ffi.open(file_name, open_flags(), 0)

  if fd < 0 {
    let errno = @ffi.get_errno()

    raise match errno {
      e if e == @ffi.enoent() => CatError::FileNonexistent(name~)
      e if e == @ffi.eacces() => CatError::PermissionDenied(name~)
      e if e == @ffi.eisdir() => CatError::IsDirectory(name~)
      _ => CatError::OpenFailed(name~, errno~)
    }
  }

  let fstate = @ffi.fstat(fd)
  if @ffi.is_null(fstate) {
    raise CatError::StatFailed(name~, errno=@ffi.get_errno())
  }
  defer @ffi.free(fstate)


  let size = @ffi.fstat_size(fstate)

  if size == 0 {
    return
  }

  if size < MMAP_THRESHOLD {
    cat_with_read(name, fd, size)
  } else {
    cat_with_mmap(name, fd, size)
  }
}

///|
#cfg(not(platform="windows"))
fn cat_with_mmap(name : String, fd : Int, size : Int64) -> Unit raise CatError {
  let size_u = size.reinterpret_as_uint64()

  let addr = @ffi.mmap(
    @ffi.null_ptr(),
    size_u,
    @ffi.prot_read(),
    @ffi.map_private(),
    fd,
    0,
  )

  // POSIX mmap 失败返回 MAP_FAILED（(void*)-1），不是 NULL
  if addr == @ffi.map_failed() {
    raise CatError::MmapFailed(name~, errno=@ffi.get_errno())
  }
  defer ignore(@ffi.munmap(addr, size_u))

  write_loop(addr, size)
}

///|
#cfg(platform="windows")
fn cat_with_mmap(name : String, fd : Int, size : Int64) -> Unit raise CatError {
  let size_u = size.reinterpret_as_uint64()

  let hFile = @ffi.fd_to_handle(fd)
  if @ffi.is_null(hFile) {
    raise CatError::MmapFailed(name~, errno=@ffi.get_errno())
  }

  let hMap = @ffi.create_file_mapping(hFile, @ffi.page_readonly(), 0, 0)
  if @ffi.is_null(hMap) {
    raise CatError::MmapFailed(name~, errno=@ffi.get_errno())
  }
  defer ignore(@ffi.close_handle(hMap))

  let addr = @ffi.map_view_of_file(hMap, @ffi.file_map_read(), 0, 0, size_u)
  if @ffi.is_null(addr) {
    raise CatError::MmapFailed(name~, errno=@ffi.get_errno())
  }
  defer ignore(@ffi.unmap_view_of_file(addr))

  write_loop(addr, size)
}

///|
fn cat_with_read(name : String, fd : Int, size : Int64) -> Unit raise CatError {
  if size == 0 {
    return
  }

  let size_u = size.reinterpret_as_uint64()
  let buf = @ffi.malloc(size_u)
  if @ffi.is_null(buf) {
    raise OutOfMemory
  }
  defer @ffi.free(buf)

  let mut total_read : Int64 = 0
  while total_read < size {
    let n = @ffi.read(
      fd,
      @ffi.ptr_add(buf, total_read),
      (size - total_read).reinterpret_as_uint64(),
    )
    if n < 0 {
      raise ReadFailed(name~, errno=@ffi.get_errno())
    }
    if n == 0 {
      break
    }
    total_read = total_read + n
  }

  write_loop(buf, size)
}

///|
/// 把 addr 开始的 size 字节循环写到 stdout。
#inline
fn write_loop(addr : @ffi.FFIPtr, size : Int64) -> Unit raise CatError {
  let mut written : Int64 = 0
  while written < size {
    let w = @ffi.write(
      @ffi.stdout_fd(),
      @ffi.ptr_add(addr, written),
      (size - written).reinterpret_as_uint64(),
    )
    if w < 0 {
      raise CatError::WriteFailed(errno=@ffi.get_errno())
    }
    written = written + w
  }
}

///|
pub fn command() -> @argparse.Command {
  @argparse.Command(
    "cat",
    about="打印文件到标准输出",
    positionals=[
      @argparse.PositionArg(
        "files",
        about="要拼接的文件（多个）",
        num_args=@argparse.ValueRange(lower=1),
      ),
    ],
  )
}
