#include <stdlib.h>

void *_moonbit_malloc(size_t size) { return malloc(size); }

void *_moonbit_realloc(void *ptr, size_t size) { return realloc(ptr, size); }

void *_moonbit_calloc(size_t count, size_t size) { return calloc(count, size); }

void _moonbit_free(void *ptr) { free(ptr); }