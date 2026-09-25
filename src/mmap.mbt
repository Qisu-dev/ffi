////|
/// 将文件或匿名内存映射到进程地址空间。
/// 
/// **参数：**
/// - `addr`：建议的映射起始地址。
///   - 传 `null_ptr()` → 由系统选择合适地址（推荐）。
///   - 传具体地址 → 系统尽量满足，但可能忽略。
/// - `len`：要映射的字节数。
///   - 匿名映射：分配的字节数。
///   - 文件映射：映射的文件区间长度。
/// - `prot`：内存保护属性，描述访问权限。
///   - `prot_read()`：可读。
///   - `prot_write()`：可写。
///   - `prot_exec()`：可执行。
///   - `prot_none()`：不可访问。
///   - 可用 `|` 组合，如 `prot_read() | prot_write()`。
/// - `flags`：映射标志，决定映射类型和行为。
///   - `map_shared()`：共享映射，写入影响原文件。
///   - `map_private()`：私有映射，写时复制（COW）。
///   - `map_anonymous()`：匿名映射，不关联文件（`fd` 传 `-1`）。
///   - 必须指定 `map_shared()` 或 `map_private()` 之一。
/// - `fd`：文件描述符。
///   - 文件映射：`open()` 返回的有效 `fd`。
///   - 匿名映射：传 `-1`（同时 `flags` 必须含 `map_anonymous()`）。
/// - `offset`：文件偏移量。
///   - 必须**页对齐**（通常是 4096 的倍数）。
///   - 匿名映射：传 `0`。
/// 
/// **返回：**
/// - 成功：映射区域的起始地址。
/// - 失败：`MAP_FAILED`（即 `(void*)-1`，用 `== map_failed()` 判断，**不是** `is_null()`）。
/// 
/// **注意：**
/// - 映射后可用指针直接读写文件内容，无需 `read`/`write`。
/// - 使用完毕必须调用 `munmap(addr, len)` 解除映射。
/// - `map_shared()` 的写入会同步到文件，`map_private()` 的写入不会。
#cfg(not(target="windows"))
pub extern "C" fn mmap(
  addr : FFIPtr,
  len : SizeT,
  prot : Int,
  flags : Int,
  fd : Int,
  offset : Int64,
) -> FFIPtr = "_moonbit_mmap"

///|
/// 解除内存映射。成功返回 0，失败返回 -1。
#cfg(not(target="windows"))
pub extern "C" fn munmap(addr : FFIPtr, len : SizeT) -> Int = "_moonbit_munmap"

///|
/// POSIX mmap 的失败返回值 MAP_FAILED，即 (void*)-1。
/// 
/// ⚠️ 这不是 NULL！判断 mmap 是否失败要用 `== map_failed()`，不能用 `is_null()`。
#cfg(not(target="windows"))
pub extern "C" fn map_failed() -> FFIPtr = "_moonbit_map_failed"

///|
/// PROT_READ — 页面可读。
#cfg(not(target="windows"))
pub extern "C" fn prot_read() -> Int = "_moonbit_prot_read"

///|
/// PROT_WRITE — 页面可写。
#cfg(not(target="windows"))
pub extern "C" fn prot_write() -> Int = "_moonbit_prot_write"

///|
/// PROT_EXEC — 页面可执行。
#cfg(not(target="windows"))
pub extern "C" fn prot_exec() -> Int = "_moonbit_prot_exec"

///|
/// PROT_NONE — 页面不可访问。
#cfg(not(target="windows"))
pub extern "C" fn prot_none() -> Int = "_moonbit_prot_none"

///|
/// MAP_PRIVATE — 私有映射（写时复制）。
#cfg(not(target="windows"))
pub extern "C" fn map_private() -> Int = "_moonbit_map_private"

///|
/// MAP_SHARED — 共享映射（写入影响原文件）。
#cfg(not(target="windows"))
pub extern "C" fn map_shared() -> Int = "_moonbit_map_shared"

///|
/// MAP_ANONYMOUS — 匿名映射（不关联文件，fd 传 -1）。
#cfg(not(target="windows"))
pub extern "C" fn map_anonymous() -> Int = "_moonbit_map_anonymous"

///|
/// 创建文件映射对象。
/// 
/// **参数：**
/// - `hFile`：要映射的文件的 HANDLE。
///   - 传文件句柄 → 映射文件。
///   - 传 `invalid_handle_value()` → 创建**匿名映射**（不关联文件，用于分配内存）。
/// - `protect`：页面保护属性，决定映射对象的读写权限。
///   - 常用值：`page_readonly()`、`page_readwrite()`、`page_writecopy()`。
///   - 可执行页面：`page_execute_read()`、`page_execute_readwrite()`。
/// - `size_high`：映射最大大小的高 32 位。
///   - 对于 ≤ 4GB 的映射，传 `0`。
///   - 与 `size_low` 组合成 64 位大小。
/// - `size_low`：映射最大大小的低 32 位。
///   - 传 `0` 且 `size_high` 也为 `0` → 使用文件的当前大小。
/// 
/// **返回：**
/// - 成功：映射对象 `HANDLE`。
/// - 失败：`NULL`（用 `is_null()` 判断）。
/// 
/// **注意：**
/// - 创建后的映射对象需要调用 `close_handle()` 释放。
/// - 大小不是页对齐的倍数时，实际映射大小会向上取整到系统页大小。
/// - `hFile` 的句柄在 `create_file_mapping` 之后可以被关闭（映射对象持有引用）。
#cfg(target="windows")
pub extern "C" fn create_file_mapping(
  hFile : FFIPtr,
  protect : UInt,
  size_high : UInt,
  size_low : UInt,
) -> FFIPtr = "_moonbit_create_file_mapping"

///|
/// 将映射对象映射到当前进程地址空间。
/// 
/// 成功返回映射地址，失败返回 NULL。
#cfg(target="windows")
pub extern "C" fn map_view_of_file(
  hMapping : FFIPtr,
  access : UInt,
  offset_high : UInt,
  offset_low : UInt,
  len : SizeT,
) -> FFIPtr = "_moonbit_map_view_of_file"

///|
/// 解除视图映射。成功返回 0，失败返回 -1。
#cfg(target="windows")
pub extern "C" fn unmap_view_of_file(addr : FFIPtr) -> Int = "_moonbit_unmap_view_of_file"

///|
/// 关闭 HANDLE。成功返回 0，失败返回 -1。
#cfg(target="windows")
pub extern "C" fn close_handle(h : FFIPtr) -> Int = "_moonbit_close_handle"

///|
/// PAGE_READONLY — 只读页面。
#cfg(target="windows")
pub extern "C" fn page_readonly() -> Int = "_moonbit_page_readonly"

///|
/// PAGE_READWRITE — 读写页面。
#cfg(target="windows")
pub extern "C" fn page_readwrite() -> Int = "_moonbit_page_readwrite"

///|
/// PAGE_WRITECOPY — 写时复制页面。
#cfg(target="windows")
pub extern "C" fn page_writecopy() -> Int = "_moonbit_page_writecopy"

///|
/// PAGE_EXECUTE_READ — 可执行只读页面。
#cfg(target="windows")
pub extern "C" fn page_execute_read() -> Int = "_moonbit_page_execute_read"

///|
/// PAGE_EXECUTE_READWRITE — 可执行读写页面。
#cfg(target="windows")
pub extern "C" fn page_execute_readwrite() -> Int = "_moonbit_page_execute_readwrite"

///|
/// PAGE_EXECUTE_WRITECOPY — 可执行写时复制页面。
#cfg(target="windows")
pub extern "C" fn page_execute_writecopy() -> Int = "_moonbit_page_execute_writecopy"

///|
/// FILE_MAP_READ — 视图可读。
#cfg(target="windows")
pub extern "C" fn file_map_read() -> Int = "_moonbit_file_map_read"

///|
/// FILE_MAP_WRITE — 视图可写。
#cfg(target="windows")
pub extern "C" fn file_map_write() -> Int = "_moonbit_file_map_write"

///|
/// FILE_MAP_COPY — 视图写时复制。
#cfg(target="windows")
pub extern "C" fn file_map_copy() -> Int = "_moonbit_file_map_copy"

///|
/// FILE_MAP_EXECUTE — 视图可执行。
#cfg(target="windows")
pub extern "C" fn file_map_execute() -> Int = "_moonbit_file_map_execute"

///|
/// fd → HANDLE 转换。失败返回 NULL。
/// 
/// ⚠️ 返回的 HANDLE 由 CRT 管理，不要用 `close_handle` 关闭它。
#cfg(target="windows")
pub extern "C" fn fd_to_handle(fd : Int) -> FFIPtr = "_moonbit_fd_to_handle"

///|
/// HANDLE → fd 转换。失败返回 -1。
#cfg(target="windows")
pub extern "C" fn handle_to_fd(h : FFIPtr, flags : Int) -> Int = "_moonbit_handle_to_fd"

///|
/// Windows 的 INVALID_HANDLE_VALUE，用于创建匿名内存映射。
/// 
/// ⚠️ 这不是 NULL！判断时要用 `== invalid_handle_value()`，不能用 `is_null()`。
#cfg(target="windows")
pub extern "C" fn invalid_handle_value() -> FFIPtr = "_moonbit_invalid_handle_value"
