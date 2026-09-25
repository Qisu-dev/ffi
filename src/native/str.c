#define _CRT_SECURE_NO_WARNINGS
#define _POSIX_C_SOURCE 200809L

#include <stddef.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#ifdef _WIN32
#define memccpy _memccpy
#define strdup _strdup

char *_moonbit_strndup(const char *s, size_t n) {
  size_t len = 0;
  while (len < n && s[len] != '\0')
    len++;
  char *p = (char *)malloc(len + 1);
  if (p) {
    memcpy(p, s, len);
    p[len] = '\0';
  }
  return p;
}

size_t _moonbit_strnlen(const char *s, size_t maxlen) {
  size_t len = 0;
  while (len < maxlen && s[len] != '\0')
    len++;
  return len;
}

char *_moonbit_strtok_s(char *str, const char *delim, char **saveptr) {
  return strtok_s(str, delim, saveptr);
}

#else
char *_moonbit_strndup(const char *s, size_t n) { return strndup(s, n); }
size_t _moonbit_strnlen(const char *s, size_t maxlen) {
  return strnlen(s, maxlen);
}
char *_moonbit_strtok_r(char *str, const char *delim, char **saveptr) {
  return strtok_r(str, delim, saveptr);
}
#endif

size_t _moonbit_strlen(const char *s) { return strlen(s); }

int32_t _moonbit_strcmp(const char *a, const char *b) { return strcmp(a, b); }
int32_t _moonbit_strncmp(const char *a, const char *b, size_t n) {
  return strncmp(a, b, n);
}

// ⚠️ 不安全：缓冲区溢出风险
void _moonbit_strcpy(char *dst, const char *src) {
  strcpy(dst, src);
}

void _moonbit_strncpy(char *dst, const char *src, size_t n) {
  strncpy(dst, src, n);
}

void *_moonbit_memccpy(void *dst, const void *src, int c, size_t n) {
  return memccpy(dst, src, c, n);
}

void _moonbit_strcat(char *dst, const char *src) {
  strcat(dst, src);
}

void _moonbit_strncat(char *dst, const char *src, size_t n) {
  strncat(dst, src, n);
}

char *_moonbit_strchr(const char *s, int c) { return strchr(s, c); }
char *_moonbit_strrchr(const char *s, int c) { return strrchr(s, c); }
char *_moonbit_strstr(const char *h, const char *n) { return strstr(h, n); }
size_t _moonbit_strspn(const char *s, const char *accept) {
  return strspn(s, accept);
}
size_t _moonbit_strcspn(const char *s, const char *reject) {
  return strcspn(s, reject);
}
char *_moonbit_strpbrk(const char *s, const char *accept) {
  return strpbrk(s, accept);
}

char *_moonbit_strtok(char *str, const char *delim) {
  return strtok(str, delim);
}

int32_t _moonbit_atoi(const char *s) { return atoi(s); }
int64_t _moonbit_atol(const char *s) { return atoll(s); }
double _moonbit_atof(const char *s) { return atof(s); }
int64_t _moonbit_strtol(const char *s, char **endptr, int base) {
  return strtoll(s, endptr, base);
}
double _moonbit_strtod(const char *s, char **endptr) {
  return strtod(s, endptr);
}

char *_moonbit_bytes_to_cstr(const uint8_t *data, size_t len) {
  char *s = malloc(len + 1);
  if (!s)
    return NULL;
  memcpy(s, data, len);
  s[len] = '\0';
  return s;
}

char *_moonbit_ptr_to_cstr(const void *data, size_t len) {
  return _moonbit_bytes_to_cstr(data, len);
}