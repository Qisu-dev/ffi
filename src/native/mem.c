#include <stdint.h>
#include <stdio.h>
#include <string.h>

void _moonbit_memcpy(void *dst, const void *src, size_t size) {
  memcpy(dst, src, size);
}

void _moonbit_memmove(void *dst, const void *src, size_t size) {
  memmove(dst, src, size);
}

void _moonbit_memset(void *ptr, int32_t value, size_t size) {
  memset(ptr, value, size);
}

int32_t _moonbit_memcmp(const void *a, const void *b, size_t size) {
  return memcmp(a, b, size);
}