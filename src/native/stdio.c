#define _CRT_SECURE_NO_WARNINGS

#include <stddef.h>
#include <stdint.h>
#include <stdio.h>

void* _moonbit_get_stdout(void) { return stdout; }
void* _moonbit_get_stderr(void) { return stderr; }
void* _moonbit_get_stdin(void)  { return stdin; }

void* _moonbit_fopen(const char* path, const char* mode) { return fopen(path, mode); }
int   _moonbit_fclose(void* stream) { return fclose((FILE*)stream); }

size_t _moonbit_fread(void* buf, size_t size, size_t count, void* stream) {
    return fread(buf, size, count, (FILE*)stream);
}
size_t _moonbit_fwrite(const void* buf, size_t size, size_t count, void* stream) {
    return fwrite(buf, size, count, (FILE*)stream);
}

int _moonbit_fflush(void* stream) { return fflush((FILE*)stream); }

int _moonbit_fseek(void* stream, int64_t offset, int whence) {
#ifdef _WIN32
    return _fseeki64((FILE*)stream, offset, whence);
#else
    return fseeko((FILE*)stream, (off_t)offset, whence);
#endif
}

int64_t _moonbit_ftell(void* stream) {
#ifdef _WIN32
    return _ftelli64((FILE*)stream);
#else
    return (int64_t)ftello((FILE*)stream);
#endif
}
void _moonbit_rewind(void* stream) { rewind((FILE*)stream); }

int _moonbit_feof(void* stream)   { return feof((FILE*)stream); }
int _moonbit_ferror(void* stream) { return ferror((FILE*)stream); }
void _moonbit_clearerr(void* stream) { clearerr((FILE*)stream); }

int   _moonbit_fileno(void* stream) { return fileno((FILE*)stream); }
void* _moonbit_fdopen(int fd, const char* mode) { return fdopen(fd, mode); }
