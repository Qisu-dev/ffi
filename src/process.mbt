///|
/// 终止当前进程，退出码为 `code`。
/// 
/// 会执行以下清理：
/// - 调用 `atexit` 注册的函数
/// - 刷新所有 `FILE*` 流的缓冲区
/// - 关闭所有打开的流
/// 
/// 退出码约定：`0` 表示成功，非 `0` 表示失败。
pub extern "C" fn exit(code : Int) -> Unit = "_moonbit_exit"

///|
/// 异常终止当前进程。
/// 
/// **不会**执行任何清理：
/// - 不调用 `atexit`
/// - 不刷新 `FILE*` 缓冲
/// - 触发 `SIGABRT`，可能产生 core dump
/// 
/// 用于不可恢复的错误。
pub extern "C" fn abort() -> Unit = "_moonbit_abort"

// ═══════════════════════════════════════════
// 工作目录
// ═══════════════════════════════════════════

///|
/// 获取当前工作目录。
/// 
/// **参数：**
/// - `buf`：接收路径的缓冲区（至少 `size` 字节）。
/// - `size`：缓冲区大小。
/// 
/// **返回：**
/// - 成功：`buf`（指向填充好的缓冲区）。
/// - 失败：`NULL`（用 `is_null()` 判断，errno 记录原因）。
/// 
/// **注意：**
/// - 如果路径长度 ≥ `size`，返回 `NULL` 并设置 `errno = ERANGE`。
/// - 建议缓冲区至少 4096 字节（PATH_MAX 的常见值）。
/// - 返回的路径不带尾部斜杠（根目录除外）。
pub extern "C" fn getcwd(buf : FFIPtr, size : SizeT) -> FFIPtr = "_moonbit_getcwd"

///|
/// 切换当前工作目录到 `path`。
/// 
/// **参数：**
/// - `path`：目标目录路径（C 字符串）。
/// 
/// **返回：**
/// - 成功：`0`。
/// - 失败：`-1`（errno 记录原因，如 ENOENT、EACCES）。
/// 
/// **注意：**
/// - 影响后续所有相对路径的解析。
/// - 只改变当前进程的工作目录，不影响其他进程。
pub extern "C" fn chdir(path : FFIPtr) -> Int = "_moonbit_chdir"

///|
/// 获取当前进程 ID。
/// 
/// **返回：** 当前进程的 PID（正整数）。
pub extern "C" fn getpid() -> Int = "_moonbit_getpid"

// ═══════════════════════════════════════════
// 仅 POSIX
// ═══════════════════════════════════════════

///|
/// 获取父进程 ID（仅 POSIX）。
/// 
/// **返回：** 父进程的 PID。
/// 
/// **注意：** Windows 没有此函数。Windows 用户调用会编译错误。
#cfg(not(platform="windows"))
pub extern "C" fn getppid() -> Int = "_moonbit_getppid"
