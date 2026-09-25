#define _CRT_SECURE_NO_WARNINGS
#define _POSIX_C_SOURCE 200809L
#define _FILE_OFFSET_BITS 64

#include <fcntl.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <corecrt_io.h>
#include <stdlib.h>

#ifdef _WIN32
#include <io.h>
#include <sys/stat.h>
#define SYS_open _open
#define SYS_close _close
#define SYS_read _read
#define SYS_write _write
#define SYS_lseek _lseeki64
#define SYS_fstat _fstat64
typedef struct _stat64 stat_t;
#else
#include <unistd.h>
#define SYS_open open
#define SYS_close close
#define SYS_read read
#define SYS_write write
#define SYS_lseek lseek
#define SYS_fstat fstat
typedef struct stat stat_t;
#endif

int _moonbit_open(const char *path, int flags, int mode) {
  return SYS_open(path, flags, mode);
}

int _moonbit_close(int fd) { return SYS_close(fd); }

int64_t _moonbit_read(int fd, void *buf, size_t count) {
  return (int64_t)SYS_read(fd, buf, count);
}

int64_t _moonbit_write(int fd, const void *buf, size_t count) {
  return (int64_t)SYS_write(fd, buf, count);
}

int64_t _moonbit_lseek(int fd, int64_t offset, int whence) {
  return (int64_t)SYS_lseek(fd, offset, whence);
}

void *_moonbit_fstat(int fd) {
  stat_t *st = malloc(sizeof(stat_t));
  if (!st)
    return NULL;
  if (SYS_fstat(fd, st) != 0) {
    free(st);
    return NULL;
  }
  return st;
}

int64_t _moonbit_fstat_size(void *st) {
  return (int64_t)((stat_t *)st)->st_size;
}
int64_t _moonbit_fstat_mtime(void *st) {
  return (int64_t)((stat_t *)st)->st_mtime;
}
int64_t _moonbit_fstat_atime(void *st) {
  return (int64_t)((stat_t *)st)->st_atime;
}
int64_t _moonbit_fstat_ctime(void *st) {
  return (int64_t)((stat_t *)st)->st_ctime;
}
int32_t _moonbit_fstat_mode(void *st) {
  return (int32_t)((stat_t *)st)->st_mode;
}

int32_t _moonbit_fstat_is_dir(void *st) {
  int mode = ((stat_t *)st)->st_mode;
#ifdef _WIN32
  return (mode & _S_IFDIR) ? 1 : 0;
#else
  return S_ISDIR(mode) ? 1 : 0;
#endif
}

int32_t _moonbit_fstat_is_regular(void *st) {
  int mode = ((stat_t *)st)->st_mode;
#ifdef _WIN32
  return (mode & _S_IFREG) ? 1 : 0;
#else
  return S_ISREG(mode) ? 1 : 0;
#endif
}

#ifdef _WIN32

int _moonbit_pipe(int *fds, unsigned int size, int mode) {
  return _pipe(fds, size, mode);
}

int _moonbit_o_binary(void) { return _O_BINARY; }
int _moonbit_o_text(void) { return _O_TEXT; }

#else

int _moonbit_pipe(int *fds) { return pipe(fds); }

#endif

#ifndef _WIN32

int _moonbit_dup(int fd) { return dup(fd); }

int _moonbit_dup2(int oldfd, int newfd) { return dup2(oldfd, newfd); }

int _moonbit_o_nonblock(void) { return O_NONBLOCK; }

#endif

int _moonbit_o_rdonly(void) { return O_RDONLY; }
int _moonbit_o_wronly(void) { return O_WRONLY; }
int _moonbit_o_rdwr(void) { return O_RDWR; }
int _moonbit_o_creat(void) { return O_CREAT; }
int _moonbit_o_trunc(void) { return O_TRUNC; }
int _moonbit_o_append(void) { return O_APPEND; }
int _moonbit_o_excl(void) { return O_EXCL; }

int _moonbit_seek_set(void) { return SEEK_SET; }
int _moonbit_seek_cur(void) { return SEEK_CUR; }
int _moonbit_seek_end(void) { return SEEK_END; }

int _moonbit_stdin_fd(void) { return 0; }
int _moonbit_stdout_fd(void) { return 1; }
int _moonbit_stderr_fd(void) { return 2; }
