#define _CRT_SECURE_NO_WARNINGS
#define _POSIX_C_SOURCE 200809L

#include <stdlib.h>

char* _moonbit_getenv(const char* name) {
    return getenv(name);
}

int _moonbit_setenv(const char* name, const char* value, int overwrite) {
#ifdef _WIN32
    // Windows 的 _putenv_s 没有 overwrite 参数，总是覆盖
    (void)overwrite;
    return _putenv_s(name, value);
#else
    return setenv(name, value, overwrite);
#endif
}

int _moonbit_unsetenv(const char* name) {
#ifdef _WIN32
    return _putenv_s(name, "");
#else
    return unsetenv(name);
#endif
}