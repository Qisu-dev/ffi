#define _CRT_SECURE_NO_WARNINGS

#include <string.h>
#include <errno.h>

int  _moonbit_errno_get(void)      { return errno; }
void _moonbit_errno_set(int value) { errno = value; }
const char* _moonbit_strerror(int e) { return strerror(e); }

#define DEFINE_ERRNO(name) \
    int _moonbit_errno_##name(void) { return name; }

DEFINE_ERRNO(EPERM)          // 1  操作不允许
DEFINE_ERRNO(ENOENT)         // 2  文件或目录不存在
DEFINE_ERRNO(ESRCH)          // 3  无此进程
DEFINE_ERRNO(EINTR)          // 4  系统调用被中断
DEFINE_ERRNO(EIO)            // 5  I/O 错误
DEFINE_ERRNO(ENXIO)          // 6  无此设备或地址
DEFINE_ERRNO(E2BIG)          // 7  参数列表过长
DEFINE_ERRNO(ENOEXEC)        // 8  执行格式错误
DEFINE_ERRNO(EBADF)          // 9  错误文件描述符
DEFINE_ERRNO(ECHILD)         // 10 无子进程
DEFINE_ERRNO(EAGAIN)         // 11 资源暂时不可用
DEFINE_ERRNO(ENOMEM)         // 12 内存不足
DEFINE_ERRNO(EACCES)         // 13 权限不足
DEFINE_ERRNO(EFAULT)         // 14 地址错误
DEFINE_ERRNO(EBUSY)          // 16 资源忙
DEFINE_ERRNO(EEXIST)         // 17 文件已存在
DEFINE_ERRNO(EXDEV)          // 18 跨设备链接
DEFINE_ERRNO(ENODEV)         // 19 无此设备
DEFINE_ERRNO(ENOTDIR)        // 20 非目录
DEFINE_ERRNO(EISDIR)         // 21 是目录
DEFINE_ERRNO(EINVAL)         // 22 参数非法
DEFINE_ERRNO(ENFILE)         // 23 系统打开文件过多
DEFINE_ERRNO(EMFILE)         // 24 进程打开文件过多
DEFINE_ERRNO(ENOTTY)         // 25  inappropriate I/O control operation
DEFINE_ERRNO(EFBIG)          // 27 文件过大
DEFINE_ERRNO(ENOSPC)         // 28 磁盘空间不足
DEFINE_ERRNO(ESPIPE)         // 29 非法 seek
DEFINE_ERRNO(EROFS)          // 30 只读文件系统
DEFINE_ERRNO(EMLINK)         // 31 链接过多
DEFINE_ERRNO(EPIPE)          // 32 管道破裂
DEFINE_ERRNO(EDOM)           // 33 数学参数超出定义域
DEFINE_ERRNO(ERANGE)         // 34 结果超出范围
DEFINE_ERRNO(EDEADLK)        // 36 资源死锁
DEFINE_ERRNO(ENAMETOOLONG)   // 38 文件名过长
DEFINE_ERRNO(ENOLCK)         // 39 无可用锁
DEFINE_ERRNO(ENOSYS)         // 40 功能未实现
DEFINE_ERRNO(ENOTEMPTY)      // 41 目录非空
DEFINE_ERRNO(EILSEQ)         // 42 非法字节序列
DEFINE_ERRNO(STRUNCATE)      // 80 字符串被截断
DEFINE_ERRNO(EADDRINUSE)     // 100 地址已使用
DEFINE_ERRNO(EADDRNOTAVAIL)  // 101 地址不可用
DEFINE_ERRNO(EAFNOSUPPORT)   // 102 地址族不支持
DEFINE_ERRNO(EALREADY)       // 103 操作已在进行
DEFINE_ERRNO(EBADMSG)        // 104 错误消息
DEFINE_ERRNO(ECANCELED)      // 105 操作已取消
DEFINE_ERRNO(ECONNABORTED)   // 106 连接中止
DEFINE_ERRNO(ECONNREFUSED)   // 107 连接被拒绝
DEFINE_ERRNO(ECONNRESET)     // 108 连接被重置
DEFINE_ERRNO(EDESTADDRREQ)   // 109 需要目标地址
DEFINE_ERRNO(EHOSTUNREACH)   // 110 主机不可达
DEFINE_ERRNO(EIDRM)          // 111 标识符已移除
DEFINE_ERRNO(EINPROGRESS)    // 112 操作在进行中
DEFINE_ERRNO(EISCONN)        // 113 已连接
DEFINE_ERRNO(ELOOP)          // 114 符号链接层数过多
DEFINE_ERRNO(EMSGSIZE)       // 115 消息过长
DEFINE_ERRNO(ENETDOWN)       // 116 网络已关闭
DEFINE_ERRNO(ENETRESET)      // 117 网络连接被重置
DEFINE_ERRNO(ENETUNREACH)    // 118 网络不可达
DEFINE_ERRNO(ENOBUFS)        // 119 缓冲区空间不足
DEFINE_ERRNO(ENODATA)        // 120 无数据
DEFINE_ERRNO(ENOLINK)        // 121 链接已断开
DEFINE_ERRNO(ENOMSG)         // 122 无消息
DEFINE_ERRNO(ENOPROTOOPT)    // 123 协议选项不可用
DEFINE_ERRNO(ENOSR)          // 124 流资源不足
DEFINE_ERRNO(ENOSTR)         // 125 非流
DEFINE_ERRNO(ENOTCONN)       // 126 未连接
DEFINE_ERRNO(ENOTRECOVERABLE)// 127 状态不可恢复
DEFINE_ERRNO(ENOTSOCK)       // 128 非套接字
DEFINE_ERRNO(ENOTSUP)        // 129 不支持
DEFINE_ERRNO(EOPNOTSUPP)     // 130 操作不支持
DEFINE_ERRNO(EOTHER)         // 131 其他错误（MSVC 特有）
DEFINE_ERRNO(EOVERFLOW)      // 132 值过大
DEFINE_ERRNO(EOWNERDEAD)     // 133 所有者已死
DEFINE_ERRNO(EPROTO)         // 134 协议错误
DEFINE_ERRNO(EPROTONOSUPPORT)// 135 协议不支持
DEFINE_ERRNO(EPROTOTYPE)     // 136 协议类型错误
DEFINE_ERRNO(ETIME)          // 137 定时器过期
DEFINE_ERRNO(ETIMEDOUT)      // 138 超时
DEFINE_ERRNO(ETXTBSY)        // 139 文本文件忙
DEFINE_ERRNO(EWOULDBLOCK)    // 140 操作会阻塞

#undef DEFINE_ERRNO