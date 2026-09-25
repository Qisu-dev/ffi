#include <stdint.h>
#include <stddef.h>

int32_t _moonbit_is_null(void* ptr) {
    return ptr == NULL;
}

void* _moonbit_null_ptr(void) {
    return NULL;
}

void* _moonbit_ptr_add(void* ptr, ptrdiff_t offset) {
    return (uint8_t*)ptr + offset;
}

void* _moonbit_bytes_as_ptr(const uint8_t* data) {
    return (void*)data;
}

void* _moonbit_fixed_array_as_ptr(uint8_t* data) {
    return (void*)data;
}