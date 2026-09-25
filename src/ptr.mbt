///|
pub extern "C" fn is_null(ptr : FFIPtr) -> Bool = "_moonbit_is_null"

///|
pub extern "C" fn null_ptr() -> FFIPtr = "_moonbit_null_ptr"

///|
pub extern "C" fn ptr_add(ptr : FFIPtr, offset : Int64) -> FFIPtr = "_moonbit_ptr_add"

///|
/// 注意, 这个指针在Bytes死亡后会悬空
#borrow(bytes)
pub extern "C" fn bytes_as_ptr(bytes : Bytes) -> FFIPtr = "_moonbit_bytes_as_ptr"

///|
/// 注意, 这个指针在fixed array死亡后会悬空
#borrow(array)
pub extern "C" fn fixed_array_as_ptr(array : FixedArray[Byte]) -> FFIPtr = "_moonbit_fixed_array_as_ptr"
