///|
pub extern "C" fn memcpy(dst : FFIPtr, src : FFIPtr, size : SizeT) -> Unit = "_moonbit_memcpy"

///|
pub extern "C" fn memmove(dst : FFIPtr, src : FFIPtr, size : SizeT) -> Unit = "_moonbit_memmove"

///|
pub extern "C" fn memset(ptr : FFIPtr, value : Int, size : SizeT) -> Unit = "_moonbit_memset"

///|
pub extern "C" fn memcmp(dst : FFIPtr, src : FFIPtr, size : SizeT) -> Int = "_moonbit_memcmp"