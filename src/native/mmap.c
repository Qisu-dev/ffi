#define _CRT_SECURE_NO_WARNINGS
#define _POSIX_C_SOURCE 200809L

#include <stddef.h>
#include <stdint.h>

#ifndef _WIN32
#include <sys/mman.h>

void* _moonbit_mmap(void* addr, size_t len, int prot, int flags, int fd, int64_t offset) {
    return mmap(addr, len, prot, flags, fd, (off_t)offset);
}

int _moonbit_munmap(void* addr, size_t len) {
    return munmap(addr, len);
}

void* _moonbit_map_failed(void) {
    return MAP_FAILED;
}

int _moonbit_prot_read(void)   { return PROT_READ; }
int _moonbit_prot_write(void)  { return PROT_WRITE; }
int _moonbit_prot_exec(void)   { return PROT_EXEC; }
int _moonbit_prot_none(void)   { return PROT_NONE; }

int _moonbit_map_private(void)   { return MAP_PRIVATE; }
int _moonbit_map_shared(void)    { return MAP_SHARED; }
int _moonbit_map_anonymous(void) { return MAP_ANONYMOUS; }

#else
#include <windows.h>
#include <io.h>
#include <stdint.h>

void* _moonbit_create_file_mapping(void* hFile, uint32_t protect, uint32_t size_high, uint32_t size_low) {
    HANDLE h = CreateFileMapping(
        (HANDLE)hFile, NULL, (DWORD)protect,
        (DWORD)size_high, (DWORD)size_low, NULL
    );
    return (void*)h;
}

void* _moonbit_map_view_of_file(void* hMapping, uint32_t access, uint32_t offset_high, uint32_t offset_low, size_t len) {
    return MapViewOfFile((HANDLE)hMapping, (DWORD)access,
                         (DWORD)offset_high, (DWORD)offset_low, len);
}

int _moonbit_unmap_view_of_file(void* addr) {
    return UnmapViewOfFile(addr) ? 0 : -1;
}

int _moonbit_close_handle(void* h) {
    return CloseHandle((HANDLE)h) ? 0 : -1;
}

uint32_t _moonbit_page_readonly(void)  { return PAGE_READONLY; }
uint32_t _moonbit_page_readwrite(void) { return PAGE_READWRITE; }
uint32_t _moonbit_page_writecopy(void) { return PAGE_WRITECOPY; }
uint32_t _moonbit_page_execute_read(void)    { return PAGE_EXECUTE_READ; }
uint32_t _moonbit_page_execute_readwrite(void) { return PAGE_EXECUTE_READWRITE; }
uint32_t _moonbit_page_execute_writecopy(void) { return PAGE_EXECUTE_WRITECOPY; }

uint32_t _moonbit_file_map_read(void)  { return FILE_MAP_READ; }
uint32_t _moonbit_file_map_write(void) { return FILE_MAP_WRITE; }
uint32_t _moonbit_file_map_copy(void)  { return FILE_MAP_COPY; }
uint32_t _moonbit_file_map_execute(void) { return FILE_MAP_EXECUTE; }

void* _moonbit_fd_to_handle(int fd) {
    intptr_t h = _get_osfhandle(fd);
    if (h == -1) return NULL;
    return (void*)h;
}

int _moonbit_handle_to_fd(void* h, int flags) {
    return _open_osfhandle((intptr_t)h, flags);
}

void* _moonbit_invalid_handle_value(void) {
    return (void*)INVALID_HANDLE_VALUE;
}

#endif