///|
/// 打开文件，返回文件描述符（失败返回 -1）。
pub extern "C" fn open(path : FFIPtr, flags : Int, mode : Int) -> Int = "_moonbit_open"

///|
/// 关闭文件描述符。
pub extern "C" fn close(fd : Int) -> Int = "_moonbit_close"

///|
/// 从文件描述符读取。返回读取字节数（0 = EOF，-1 = 错误）。
pub extern "C" fn read(fd : Int, buf : FFIPtr, count : SizeT) -> Int64 = "_moonbit_read"

///|
/// 向文件描述符写入。返回写入字节数（-1 = 错误）。
pub extern "C" fn write(fd : Int, buf : FFIPtr, count : SizeT) -> Int64 = "_moonbit_write"

///|
/// 移动文件偏移量。返回新偏移（-1 = 错误）。
pub extern "C" fn lseek(fd : Int, offset : Int64, whence : Int) -> Int64 = "_moonbit_lseek"

///|
/// 获取已打开文件的元数据。
/// 
/// 内部 `malloc` 一个 `struct stat` 并调用 `fstat` 填充。
/// 
/// **返回：**
/// - 成功：指向 `struct stat` 的指针。
/// - 失败：`NULL`（用 `is_null` 判断，errno 记录原因）。
/// 
/// ⚠️ 用完必须 `stat_free` 释放。
pub extern "C" fn fstat(fd : Int) -> FFIPtr = "_moonbit_fstat"

///|
/// 文件大小（字节）。
pub extern "C" fn fstat_size(st : FFIPtr) -> Int64 = "_moonbit_fstat_size"

///|
/// 最后修改时间（Unix 时间戳，秒）。
pub extern "C" fn fstat_mtime(st : FFIPtr) -> Int64 = "_moonbit_fstat_mtime"

///|
/// 最后访问时间（Unix 时间戳，秒）。
pub extern "C" fn fstat_atime(st : FFIPtr) -> Int64 = "_moonbit_fstat_atime"

///|
/// 状态改变时间（Unix 时间戳，秒）。
pub extern "C" fn fstat_ctime(st : FFIPtr) -> Int64 = "_moonbit_fstat_ctime"

///|
/// 权限位（POSIX mode）。
pub extern "C" fn fstat_mode(st : FFIPtr) -> Int = "_moonbit_fstat_mode"

///|
/// 是否目录。返回 1 是，0 否。
pub extern "C" fn fstat_is_dir(st : FFIPtr) -> Int = "_moonbit_fstat_is_dir"

///|
/// 是否普通文件。返回 1 是，0 否。
pub extern "C" fn fstat_is_regular(st : FFIPtr) -> Int = "_moonbit_fstat_is_regular"

///|
/// 创建管道（POSIX）。fds 长度为 2，fds[0] 读端，fds[1] 写端。
#cfg(not(platform="windows"))
#borrow(fds)
pub extern "C" fn pipe(fds : FixedArray[Int]) -> Int = "_moonbit_pipe"

///|
/// 创建管道（Windows）。size 是建议缓冲区大小，mode 是 _O_BINARY/_O_TEXT。
#cfg(platform="windows")
#borrow(fds)
pub extern "C" fn pipe_ex(
  fds : FixedArray[Int],
  size : UInt,
  mode : Int,
) -> Int = "_moonbit_pipe"

///|
/// Windows 二进制模式标志。
#cfg(platform="windows")
pub extern "C" fn o_binary() -> Int = "_moonbit_o_binary"

///|
/// Windows 文本模式标志。
#cfg(platform="windows")
pub extern "C" fn o_text() -> Int = "_moonbit_o_text"

///|
/// 复制文件描述符（POSIX）。
#cfg(not(platform="windows"))
pub extern "C" fn dup(fd : Int) -> Int = "_moonbit_dup"

///|
/// 复制到指定文件描述符（POSIX）。
#cfg(not(platform="windows"))
pub extern "C" fn dup2(oldfd : Int, newfd : Int) -> Int = "_moonbit_dup2"

///|
/// O_NONBLOCK 标志（POSIX）。
#cfg(not(platform="windows"))
pub extern "C" fn o_nonblock() -> Int = "_moonbit_o_nonblock"

///|
/// O_RDONLY — 只读打开
pub extern "C" fn o_rdonly() -> Int = "_moonbit_o_rdonly"

///|
/// O_WRONLY — 只写打开
pub extern "C" fn o_wronly() -> Int = "_moonbit_o_wronly"

///|
/// O_RDWR — 读写打开
pub extern "C" fn o_rdwr() -> Int = "_moonbit_o_rdwr"

///|
/// O_CREAT — 文件不存在时创建
pub extern "C" fn o_creat() -> Int = "_moonbit_o_creat"

///|
/// O_TRUNC — 截断为 0 长度
pub extern "C" fn o_trunc() -> Int = "_moonbit_o_trunc"

///|
/// O_APPEND — 追加模式
pub extern "C" fn o_append() -> Int = "_moonbit_o_append"

///|
/// O_EXCL — 与 O_CREAT 配合，文件已存在则失败
pub extern "C" fn o_excl() -> Int = "_moonbit_o_excl"

///|
/// SEEK_SET — 从文件开头偏移
pub extern "C" fn seek_set() -> Int = "_moonbit_seek_set"

///|
/// SEEK_CUR — 从当前位置偏移
pub extern "C" fn seek_cur() -> Int = "_moonbit_seek_cur"

///|
/// SEEK_END — 从文件末尾偏移
pub extern "C" fn seek_end() -> Int = "_moonbit_seek_end"

///|
/// 标准输入 fd（0）
pub extern "C" fn stdin_fd() -> Int = "_moonbit_stdin_fd"

///|
/// 标准输出 fd（1）
pub extern "C" fn stdout_fd() -> Int = "_moonbit_stdout_fd"

///|
/// 标准错误 fd（2）
pub extern "C" fn stderr_fd() -> Int = "_moonbit_stderr_fd"
