///|
pub extern "C" fn malloc(size : SizeT) -> FFIPtr = "_moonbit_malloc"

///|
pub extern "C" fn realloc(ptr : FFIPtr, size : SizeT) -> FFIPtr = "_moonbit_realloc"

///|
pub extern "C" fn calloc(count : SizeT, size : SizeT) -> FFIPtr = "_moonbit_calloc"

///|
pub extern "C" fn free(size : FFIPtr) -> Unit = "_moonbit_free"
