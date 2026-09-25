# moonbit-ffi

MoonBit 的底层 C FFI 绑定。纯声明，无抽象。

## 安装

```bash
moon add Qisu-dev/ffi
```

## 功能

| 模块 | 内容 |
| :--- | :--- |
| `memory` | `malloc` `calloc` `realloc` `free` |
| `mem` | `memcpy` `memmove` `memset` `memcmp` |
| `ptr` | `is_null` `null_ptr` `ptr_add` `bytes_as_ptr` `fixed_array_as_ptr` |
| `str` | `strlen` `strcmp` `strcpy` `strdup` `bytes_to_cstr` `cstr_to_string` |
| `errno` | `errno_get` `errno_set` `strerror` `enoent` `eacces` 等 |
| `file` | `open` `close` `read` `write` `lseek` `pipe` `dup` |
| `mmap` | `mmap` `munmap`（POSIX）、`create_file_mapping` `map_view_of_file` `unmap_view_of_file`（Windows） |

## 示例

### 内存与文件

```moonbit
fn main {
  // 分配内存
  let buf = @ffi.malloc(1024)
  if @ffi.is_null(buf) { return }
  defer @ffi.free(buf)

  // 写文件
  let cpath = @ffi.string_to_cstr("out.txt")
  defer @ffi.free(cpath)
  let fd = @ffi.open(cpath, @ffi.o_wronly() | @ffi.o_creat(), 0o644)
  defer { @ffi.close(fd); () }
  @ffi.write(fd, @ffi.bytes_as_ptr(b"hello"), 5)

  // 错误处理
  if fd < 0 {
    let err = @ffi.errno_get()
    println(@ffi.cstr_to_string(@ffi.strerror(err)))
  }
}
```

### 内存映射读文件

```moonbit
#cfg(not(platform="windows"))
fn mmap_read(name : String) -> Unit raise {
  let cpath = @ffi.string_to_cstr(name)
  defer @ffi.free(cpath)

  let fd = @ffi.open(cpath, @ffi.o_rdonly(), 0)
  if fd < 0 { raise Failure("open failed") }
  defer { @ffi.close(fd); () }

  let fstate = @ffi.fstat(fd)
  if @ffi.is_null(fstate) { raise Failure("fstat failed") }
  defer @ffi.free(fstate)

  let size = @ffi.fstat_size(fstate).reinterpret_as_uint64()
  if size == 0 { return }

  let addr = @ffi.mmap(
    @ffi.null_ptr(), size,
    @ffi.prot_read(), @ffi.map_private(),
    fd, 0,
  )
  if addr == @ffi.map_failed() {
    raise Failure("mmap failed")
  }
  defer ignore(@ffi.munmap(addr, size))

  // addr 是只读的连续内存，可直接处理
  ignore(addr)
}
```

## 注意

- `mmap` 失败返回 `MAP_FAILED`，用 `== @ffi.map_failed()` 判断，**不是** `is_null`
- Windows 下 `map_view_of_file` 失败返回 `NULL`，用 `is_null` 判断
- `bytes_as_ptr` 返回的指针在 `Bytes` 释放后悬垂
- 指针偏移后不能 `free`，只能 `free` 原始指针
- 仅支持 `native` 后端（Windows / Linux / macOS）

| 平台 | 状态 |
| :--- | :--- |
| Windows | ✅ 已验证, 可以使用 |
| Linux   | ⚠️ 代码已写，未在真实环境验证 |
| macOS   | ⚠️ 代码已写，未在真实环境验证 |

## License

Apache-2.0