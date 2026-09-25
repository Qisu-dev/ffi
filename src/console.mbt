///|
/// 设置控制台输出代码页。65001 表示 UTF-8。
/// 必须在任何输出之前调用。
#cfg(platform="windows")
pub extern "C" fn set_console_cp(code : UInt) -> Unit = "_moonbit_set_console"

///|
/// 获取当前控制台输出代码页。
#cfg(platform="windows")
pub extern "C" fn get_console_cp() -> UInt = "_moonbit_get_console_cp"
