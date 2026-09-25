///|
/// 计算 C 字符串长度（不含 \0）
#cfg(target="native")
pub extern "C" fn strlen(s : FFIPtr) -> SizeT = "_moonbit_strlen"

///|
/// 计算 C 字符串长度，最多检查 maxlen 个字节
#cfg(target="native")
pub extern "C" fn strnlen(s : FFIPtr, maxlen : SizeT) -> SizeT = "_moonbit_strnlen"

///|
/// 按字典序比较两个 C 字符串。返回 <0、=0、>0
#cfg(target="native")
pub extern "C" fn strcmp(a : FFIPtr, b : FFIPtr) -> Int = "_moonbit_strcmp"

///|
/// 比较前 n 个字符
#cfg(target="native")
pub extern "C" fn strncmp(a : FFIPtr, b : FFIPtr, n : SizeT) -> Int = "_moonbit_strncmp"

///|
/// ⚠️ 不安全：不检查 dst 大小，可能溢出
#cfg(target="native")
pub extern "C" fn strcpy(dst : FFIPtr, src : FFIPtr) -> Unit = "_moonbit_strcpy"

///|
/// ⚠️ 半安全：限制长度，但可能不补 \0 结尾。
/// 此函数并非不可使用而是极其易错
/// 如果你想继续使用
/// 如下示例
/// ```moonbit nocheck
/// let cstr_ptr = bytes_to_cstr(b"hello", 5)
/// defer free_cstr(cstr_ptr)
/// let dst = malloc(6)
/// defer free(dst)
/// strncpy(dst, cstr_ptr, 5)
/// memset(ptr_add(dst, 5), 0, 1)
/// ```
#cfg(target="native")
pub extern "C" fn strncpy(dst : FFIPtr, src : FFIPtr, n : SizeT) -> Unit = "_moonbit_strncpy"

///|
/// 拷贝直到遇到字符 c 或拷满 n 字节。返回指向 c 后一个字节的指针，或 NULL。
#cfg(target="native")
pub extern "C" fn memccpy(
  dst : FFIPtr,
  src : FFIPtr,
  c : Int,
  n : SizeT,
) -> FFIPtr = "_moonbit_memccpy"

///|
/// ⚠️ 不安全：不检查 dst 大小，可能溢出。
#cfg(target="native")
#deprecated("此函数并不安全, 不推荐使用")
pub extern "C" fn strcat(dst : FFIPtr, src : FFIPtr) -> Unit = "_moonbit_strcat"

///|
/// 拼接最多 n 个字符，保证 \0 结尾。
#cfg(target="native")
pub extern "C" fn strncat(dst : FFIPtr, src : FFIPtr, n : SizeT) -> Unit = "_moonbit_strncat"

///|
/// 查找第一个字符 c
#cfg(target="native")
pub extern "C" fn strchr(s : FFIPtr, c : Int) -> FFIPtr = "_moonbit_strchr"

///|
/// 查找最后一个字符 c
#cfg(target="native")
pub extern "C" fn strrchr(s : FFIPtr, c : Int) -> FFIPtr = "_moonbit_strrchr"

///|
/// 查找子串
#cfg(target="native")
pub extern "C" fn strstr(haystack : FFIPtr, needle : FFIPtr) -> FFIPtr = "_moonbit_strstr"

///|
/// 从开头算起，连续属于 accept 字符集的字符个数
#cfg(target="native")
pub extern "C" fn strspn(s : FFIPtr, accept : FFIPtr) -> SizeT = "_moonbit_strspn"

///|
/// 从开头算起，连续不属于 reject 字符集的字符个数
#cfg(target="native")
pub extern "C" fn strcspn(s : FFIPtr, reject : FFIPtr) -> SizeT = "_moonbit_strcspn"

///|
/// 查找 accept 中任意字符的首次出现
#cfg(target="native")
pub extern "C" fn strpbrk(s : FFIPtr, accept : FFIPtr) -> FFIPtr = "_moonbit_strpbrk"

///|
/// ⚠️ 会修改原字符串，且非线程安全。推荐用 strtok_r/strtok_s。
pub extern "C" fn strtok(str : FFIPtr, delim : FFIPtr) -> FFIPtr = "_moonbit_strtok"

///|
/// POSIX 可重入分词（Linux/macOS）
#cfg(not(target="windows"))
pub extern "C" fn strtok_r(
  str : FFIPtr,
  delim : FFIPtr,
  saveptr : FFIPtr,
) -> FFIPtr = "_moonbit_strtok_r"

///|
/// MSVC 可重入分词（Windows）。注意：参数非法时会崩溃。
#cfg(target="windows")
pub extern "C" fn strtok_s(
  str : FFIPtr,
  delim : FFIPtr,
  saveptr : FFIPtr,
) -> FFIPtr = "_moonbit_strtok_s"

///|
pub extern "C" fn strdup(s : FFIPtr) -> FFIPtr = "_moonbit_strdup"

///|
pub extern "C" fn strndup(s : FFIPtr, n : SizeT) -> FFIPtr = "_moonbit_strndup"

///|
/// ⚠️ 无错误检测。推荐用 strtol。
pub extern "C" fn atoi(s : FFIPtr) -> Int = "_moonbit_atoi"

///|
/// ⚠️ 无错误检测。推荐用 strtol。
pub extern "C" fn atol(s : FFIPtr) -> Int64 = "_moonbit_atol"

///|
/// ⚠️ 无错误检测。推荐用 strtod。
pub extern "C" fn atof(s : FFIPtr) -> Double = "_moonbit_atof"

///|
pub extern "C" fn strtol(s : FFIPtr, endptr : FFIPtr, base : Int) -> Int64 = "_moonbit_strtol"

///|
pub extern "C" fn strtod(s : FFIPtr, endptr : FFIPtr) -> Double = "_moonbit_strtod"

///|
#borrow(data)
pub extern "C" fn bytes_to_cstr(data : Bytes, len : SizeT) -> FFIPtr = "_moonbit_bytes_to_cstr"

///|
pub extern "C" fn ptr_to_cstr(data : FFIPtr, len : SizeT) -> FFIPtr = "_moonbit_ptr_to_cstr"

///|
pub extern "C" fn free_cstr(s : FFIPtr) -> Unit = "_moonbit_free_cstr"

///|
/// 
pub fn string_to_cstr(s : String) -> FFIPtr {
  let bytes = @utf8.encode(s)
  bytes_to_cstr(bytes, bytes.length().to_uint64())
}

///|
pub fn cstr_to_string(s : FFIPtr) -> String {
  let length = strlen(s).to_int()
  let array : FixedArray[Byte] = FixedArray::make(length, b'\x00')
  memcpy(fixed_array_as_ptr(array), s, length.to_uint64())
  array.unsafe_reinterpret_as_bytes().to_string()
}
