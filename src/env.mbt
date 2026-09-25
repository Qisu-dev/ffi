///|
/// 获取环境变量的值。
/// 
/// **参数：**
/// - `name`：环境变量名（C 字符串）。
/// 
/// **返回：**
/// - 成功：指向变量值的指针（**不要 free**，由环境表管理）。
/// - 不存在：`NULL`（用 `is_null()` 判断）。
/// 
/// **注意：**
/// - 返回的指针在后续 `setenv`/`unsetenv` 后可能失效。
/// - 不要修改返回的字符串。
pub extern "C" fn getenv(name : FFIPtr) -> FFIPtr = "_moonbit_getenv"

///|
/// 设置环境变量。
/// 
/// **参数：**
/// - `name`：变量名。
/// - `value`：变量值。
/// - `overwrite`：非 0 则覆盖已存在的变量，0 则不覆盖。
/// 
/// **返回：**
/// - 成功：`0`。
/// - 失败：`-1`（errno 记录原因）。
/// 
/// **注意：** Windows 上 `overwrite` 参数被忽略，总是覆盖。
pub extern "C" fn setenv(name : FFIPtr, value : FFIPtr, overwrite : Int) -> Int = "_moonbit_setenv"

///|
/// 删除环境变量。
/// 
/// **返回：**
/// - 成功：`0`。
/// - 失败：`-1`。
pub extern "C" fn unsetenv(name : FFIPtr) -> Int = "_moonbit_unsetenv"