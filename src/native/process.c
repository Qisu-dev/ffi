#define _CRT_SECURE_NO_WARNINGS
#define _POSIX_C_SOURCE 200809L

#include <stddef.h>
#include <stdint.h>
#include <stdlib.h>

#ifdef _WIN32
  #include <process.h>
  #include <direct.h>
  #define SYS_getcwd _getcwd
  #define SYS_chdir  _chdir
  #define SYS_getpid _getpid
#else
  #include <unistd.h>
  #define SYS_getcwd getcwd
  #define SYS_chdir  chdir
  #define SYS_getpid getpid
#endif

void _moonbit_exit(int code) {
    exit(code);
}

void _moonbit_abort(void) {
    abort();
}

char* _moonbit_getcwd(char* buf, size_t size) {
    return SYS_getcwd(buf, size);
}

int _moonbit_chdir(const char* path) {
    return SYS_chdir(path);
}

int _moonbit_getpid(void) {
    return SYS_getpid();
}

#ifndef _WIN32

int _moonbit_getppid(void) {
    return getppid();
}

#endif