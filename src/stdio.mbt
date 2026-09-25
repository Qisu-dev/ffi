///|
/// 获取 stdout 的 FILE*。
pub extern "C" fn get_stdout() -> FFIPtr = "_moonbit_get_stdout"

///|
/// 获取 stderr 的 FILE*。
pub extern "C" fn get_stderr() -> FFIPtr = "_moonbit_get_stderr"

///|
/// 获取 stdin 的 FILE*。
pub extern "C" fn get_stdin() -> FFIPtr = "_moonbit_get_stdin"

///|
/// 打开文件流。
/// 
/// - `path`：文件路径（C 字符串）
/// - `mode`：打开模式（`"r"`、`"w"`、`"a"`、`"rb"`、`"wb"` 等）
/// 
/// 成功返回 FILE*，失败返回 NULL（errno 记录原因）。
pub extern "C" fn fopen(path : FFIPtr, mode : FFIPtr) -> FFIPtr = "_moonbit_fopen"

///|
/// 关闭文件流，自动刷新缓冲区。
/// 
/// 成功返回 0，失败返回 -1。
pub extern "C" fn fclose(stream : FFIPtr) -> Int = "_moonbit_fclose"

///|
/// 从流读取 `count` 个元素，每个 `size` 字节。
/// 
/// 返回实际读取的**元素个数**（不是字节数）。
/// 
/// ⚠️ 返回值可能是 `count`，也可能更少。配合 `feof`/`ferror` 判断原因。
/// 常用 `size=1` 让返回值直接等于字节数。
#borrow(buf)
pub extern "C" fn fread(
  buf : FFIPtr,
  size : SizeT,
  count : SizeT,
  stream : FFIPtr,
) -> SizeT = "_moonbit_fread"

///|
/// 向流写入 `count` 个元素，每个 `size` 字节。
/// 
/// 返回实际写入的**元素个数**。
/// 
/// ⚠️ 返回值 < `count` 表示写入不完整或出错。
/// 常用 `size=1` 让返回值直接等于字节数。
#borrow(buf)
pub extern "C" fn fwrite(
  buf : FFIPtr,
  size : SizeT,
  count : SizeT,
  stream : FFIPtr,
) -> SizeT = "_moonbit_fwrite"

///|
/// 强制刷新缓冲区，把数据写到内核。
/// 
/// 成功返回 0，失败返回 -1。
/// 
/// 用途：实时输出、崩溃前保留日志、交互式程序。
pub extern "C" fn fflush(stream : FFIPtr) -> Int = "_moonbit_fflush"

///|
/// 移动文件读写位置。
/// 
/// - `offset`：相对 `whence` 的偏移量（字节）
/// - `whence`：基准位置（`seek_set()`/`seek_cur()`/`seek_end()`）
/// 
/// 成功返回 0，失败返回非 0。
/// 
/// ⚠️ 不支持管道、socket、终端等不可定位的流。
pub extern "C" fn fseek(stream : FFIPtr, offset : Int64, whence : Int) -> Int = "_moonbit_fseek"

///|
/// 获取当前读写位置（相对文件开头）。
/// 
/// 返回字节偏移，失败返回 -1。
pub extern "C" fn ftell(stream : FFIPtr) -> Int64 = "_moonbit_ftell"

///|
/// 把位置移到文件开头，并清除错误标志。
pub extern "C" fn rewind(stream : FFIPtr) -> Unit = "_moonbit_rewind"

///|
/// 判断是否到达文件末尾。
/// 
/// 返回非 0 表示 EOF，0 表示未到。
/// 
/// ⚠️ EOF 标志是"粘性"的——只有 `clearerr` 或 `rewind` 能清除。
/// 判断前先读取，读完后才能判断。
pub extern "C" fn feof(stream : FFIPtr) -> Int = "_moonbit_feof"

///|
/// 判断流是否发生了错误。
/// 
/// 返回非 0 表示有错误，0 表示无。
pub extern "C" fn ferror(stream : FFIPtr) -> Int = "_moonbit_ferror"

///|
/// 清除 EOF 标志和错误标志。
pub extern "C" fn clearerr(stream : FFIPtr) -> Unit = "_moonbit_clearerr"

///|
/// 从 FILE* 提取底层 fd。
/// 
/// 失败返回 -1。
/// 
/// ⚠️ 不要混用 `fread`/`fwrite`（缓冲）和 `read`/`write`（无缓冲）——
/// 缓冲会导致数据错位。
pub extern "C" fn fileno(stream : FFIPtr) -> Int = "_moonbit_fileno"

///|
/// 用已有的 fd 创建 FILE*。
/// 
/// - `fd`：已打开的文件描述符
/// - `mode`：模式字符串（同 `fopen`）
/// 
/// 成功返回 FILE*，失败返回 NULL。
/// 
/// ⚠️ `fdopen` 之后 `FILE*` 接管 `fd`，不要再直接用 `fd`。
/// `fclose` 会关闭底层的 `fd`。
pub extern "C" fn fdopen(fd : Int, mode : FFIPtr) -> FFIPtr = "_moonbit_fdopen"
