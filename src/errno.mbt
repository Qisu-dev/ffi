///|
/// 获取当前线程的 errno 值。
/// 
/// 系统调用失败后立即读取，得到具体错误码。
pub extern "C" fn get_errno() -> Int = "_moonbit_get_errno"

///|
/// 设置当前线程的 errno 值。
/// 
/// 用于清除（设为 0）或在错误后恢复。
pub extern "C" fn set_errno(value : Int) -> Unit = "_moonbit_set_errno"

///|
/// 将 errno 转为人类可读的字符串。
/// 
/// 返回的指针指向静态缓冲区，**不要 free**，也不要长期持有。
pub extern "C" fn strerror(errnum : Int) -> FFIPtr = "_moonbit_strerror"

///|
/// EPERM (1) — 操作不允许。
/// 
/// 调用者没有执行该操作所需的权限。
pub extern "C" fn eperm() -> Int = "_moonbit_errno_EPERM"

///|
/// ENOENT (2) — 文件或目录不存在。
pub extern "C" fn enoent() -> Int = "_moonbit_errno_ENOENT"

///|
/// ESRCH (3) — 无此进程。
/// 
/// 找不到指定的进程 ID。
pub extern "C" fn esrch() -> Int = "_moonbit_errno_ESRCH"

///|
/// EINTR (4) — 系统调用被信号中断。
/// 
/// 通常需要重试。
pub extern "C" fn eintr() -> Int = "_moonbit_errno_EINTR"

///|
/// EIO (5) — I/O 错误。
/// 
/// 底层硬件或驱动错误。
pub extern "C" fn eio() -> Int = "_moonbit_errno_EIO"

///|
/// ENXIO (6) — 无此设备或地址。
pub extern "C" fn enxio() -> Int = "_moonbit_errno_ENXIO"

///|
/// E2BIG (7) — 参数列表过长。
pub extern "C" fn e2big() -> Int = "_moonbit_errno_E2BIG"

///|
/// ENOEXEC (8) — 执行格式错误。
/// 
/// 文件不是有效的可执行格式。
pub extern "C" fn enoexec() -> Int = "_moonbit_errno_ENOEXEC"

///|
/// EBADF (9) — 错误的文件描述符。
/// 
/// fd 无效或未打开。
pub extern "C" fn ebadf() -> Int = "_moonbit_errno_EBADF"

///|
/// ECHILD (10) — 无子进程。
pub extern "C" fn echild() -> Int = "_moonbit_errno_ECHILD"

///|
/// EAGAIN (11) — 资源暂时不可用。
/// 
/// 非阻塞 I/O 时数据未就绪，需重试。
pub extern "C" fn eagain() -> Int = "_moonbit_errno_EAGAIN"

///|
/// ENOMEM (12) — 内存不足。
/// 
/// malloc 失败时常见。
pub extern "C" fn enomem() -> Int = "_moonbit_errno_ENOMEM"

///|
/// EACCES (13) — 权限不足。
/// 
/// 文件存在但无访问权限。
pub extern "C" fn eacces() -> Int = "_moonbit_errno_EACCES"

///|
/// EFAULT (14) — 地址错误。
/// 
/// 传入了无效的内存地址。
pub extern "C" fn efault() -> Int = "_moonbit_errno_EFAULT"

///|
/// EBUSY (16) — 资源忙。
/// 
/// 设备或文件被占用。
pub extern "C" fn ebusy() -> Int = "_moonbit_errno_EBUSY"

///|
/// EEXIST (17) — 文件已存在。
/// 
/// O_CREAT | O_EXCL 时常见。
pub extern "C" fn eexist() -> Int = "_moonbit_errno_EEXIST"

///|
/// EXDEV (18) — 跨设备链接。
/// 
/// 试图在不同文件系统间创建硬链接。
pub extern "C" fn exdev() -> Int = "_moonbit_errno_EXDEV"

///|
/// ENODEV (19) — 无此设备。
pub extern "C" fn enodev() -> Int = "_moonbit_errno_ENODEV"

///|
/// ENOTDIR (20) — 非目录。
/// 
/// 路径中某一段不是目录。
pub extern "C" fn enotdir() -> Int = "_moonbit_errno_ENOTDIR"

///|
/// EISDIR (21) — 是目录。
/// 
/// 试图以文件方式打开目录。
pub extern "C" fn eisdir() -> Int = "_moonbit_errno_EISDIR"

///|
/// EINVAL (22) — 参数非法。
pub extern "C" fn einval() -> Int = "_moonbit_errno_EINVAL"

///|
/// ENFILE (23) — 系统打开文件过多。
/// 
/// 达到系统级 fd 上限。
pub extern "C" fn enfile() -> Int = "_moonbit_errno_ENFILE"

///|
/// EMFILE (24) — 进程打开文件过多。
/// 
/// 达到进程级 fd 上限。
pub extern "C" fn emfile() -> Int = "_moonbit_errno_EMFILE"

///|
/// ENOTTY (25) — 非法 I/O 控制操作。
/// 
/// ioctl 不适用于该设备。
pub extern "C" fn enotty() -> Int = "_moonbit_errno_ENOTTY"

///|
/// EFBIG (27) — 文件过大。
/// 
/// 超过文件系统或进程允许的最大文件大小。
pub extern "C" fn efbig() -> Int = "_moonbit_errno_EFBIG"

///|
/// ENOSPC (28) — 磁盘空间不足。
pub extern "C" fn enospc() -> Int = "_moonbit_errno_ENOSPC"

///|
/// ESPIPE (29) — 非法 seek。
/// 
/// 对管道、socket 等不可定位的流调用 lseek。
pub extern "C" fn espipe() -> Int = "_moonbit_errno_ESPIPE"

///|
/// EROFS (30) — 只读文件系统。
pub extern "C" fn erofs() -> Int = "_moonbit_errno_EROFS"

///|
/// EMLINK (31) — 链接过多。
/// 
/// 超过文件系统的硬链接数上限。
pub extern "C" fn emlink() -> Int = "_moonbit_errno_EMLINK"

///|
/// EPIPE (32) — 管道破裂。
/// 
/// 向已关闭读端的管道写入。
pub extern "C" fn epipe() -> Int = "_moonbit_errno_EPIPE"

///|
/// EDOM (33) — 数学参数超出定义域。
pub extern "C" fn edom() -> Int = "_moonbit_errno_EDOM"

///|
/// ERANGE (34) — 结果超出范围。
/// 
/// 数学函数结果超出可表示范围。
pub extern "C" fn erange() -> Int = "_moonbit_errno_ERANGE"

///|
/// EDEADLK (36) — 资源死锁。
/// 
/// 避免死锁时可能发生。
pub extern "C" fn edeadlk() -> Int = "_moonbit_errno_EDEADLK"

///|
/// ENAMETOOLONG (38) — 文件名过长。
pub extern "C" fn enametoolong() -> Int = "_moonbit_errno_ENAMETOOLONG"

///|
/// ENOLCK (39) — 无可用锁。
/// 
/// 系统锁表已满。
pub extern "C" fn enolck() -> Int = "_moonbit_errno_ENOLCK"

///|
/// ENOSYS (40) — 功能未实现。
/// 
/// 系统调用未实现。
pub extern "C" fn enosys() -> Int = "_moonbit_errno_ENOSYS"

///|
/// ENOTEMPTY (41) — 目录非空。
pub extern "C" fn enotempty() -> Int = "_moonbit_errno_ENOTEMPTY"

///|
/// EILSEQ (42) — 非法字节序列。
/// 
/// 字符编码转换时遇到无效字节。
pub extern "C" fn eilseq() -> Int = "_moonbit_errno_EILSEQ"

///|
/// STRUNCATE (80) — 字符串被截断。
/// 
/// MSVC Secure CRT 特有。
pub extern "C" fn struncate() -> Int = "_moonbit_errno_STRUNCATE"

///|
/// EADDRINUSE (100) — 地址已使用。
/// 
/// 绑定的端口已被占用。
pub extern "C" fn eaddrinuse() -> Int = "_moonbit_errno_EADDRINUSE"

///|
/// EADDRNOTAVAIL (101) — 地址不可用。
pub extern "C" fn eaddrnotavail() -> Int = "_moonbit_errno_EADDRNOTAVAIL"

///|
/// EAFNOSUPPORT (102) — 地址族不支持。
pub extern "C" fn eafnosupport() -> Int = "_moonbit_errno_EAFNOSUPPORT"

///|
/// EALREADY (103) — 操作已在进行。
pub extern "C" fn ealready() -> Int = "_moonbit_errno_EALREADY"

///|
/// EBADMSG (104) — 错误消息。
pub extern "C" fn ebadmsg() -> Int = "_moonbit_errno_EBADMSG"

///|
/// ECANCELED (105) — 操作已取消。
pub extern "C" fn ecanceled() -> Int = "_moonbit_errno_ECANCELED"

///|
/// ECONNABORTED (106) — 连接中止。
pub extern "C" fn econnaborted() -> Int = "_moonbit_errno_ECONNABORTED"

///|
/// ECONNREFUSED (107) — 连接被拒绝。
/// 
/// 目标端口无监听。
pub extern "C" fn econnrefused() -> Int = "_moonbit_errno_ECONNREFUSED"

///|
/// ECONNRESET (108) — 连接被重置。
pub extern "C" fn econnreset() -> Int = "_moonbit_errno_ECONNRESET"

///|
/// EDESTADDRREQ (109) — 需要目标地址。
pub extern "C" fn edestaddrreq() -> Int = "_moonbit_errno_EDESTADDRREQ"

///|
/// EHOSTUNREACH (110) — 主机不可达。
pub extern "C" fn ehostunreach() -> Int = "_moonbit_errno_EHOSTUNREACH"

///|
/// EIDRM (111) — 标识符已移除。
pub extern "C" fn eidrm() -> Int = "_moonbit_errno_EIDRM"

///|
/// EINPROGRESS (112) — 操作在进行中。
/// 
/// 非阻塞 connect 尚未完成。
pub extern "C" fn einprogress() -> Int = "_moonbit_errno_EINPROGRESS"

///|
/// EISCONN (113) — 已连接。
pub extern "C" fn eisconn() -> Int = "_moonbit_errno_EISCONN"

///|
/// ELOOP (114) — 符号链接层数过多。
pub extern "C" fn eloop() -> Int = "_moonbit_errno_ELOOP"

///|
/// EMSGSIZE (115) — 消息过长。
pub extern "C" fn emsgsize() -> Int = "_moonbit_errno_EMSGSIZE"

///|
/// ENETDOWN (116) — 网络已关闭。
pub extern "C" fn enetdown() -> Int = "_moonbit_errno_ENETDOWN"

///|
/// ENETRESET (117) — 网络连接被重置。
pub extern "C" fn enetreset() -> Int = "_moonbit_errno_ENETRESET"

///|
/// ENETUNREACH (118) — 网络不可达。
pub extern "C" fn enetunreach() -> Int = "_moonbit_errno_ENETUNREACH"

///|
/// ENOBUFS (119) — 缓冲区空间不足。
pub extern "C" fn enobufs() -> Int = "_moonbit_errno_ENOBUFS"

///|
/// ENODATA (120) — 无数据。
pub extern "C" fn enodata() -> Int = "_moonbit_errno_ENODATA"

///|
/// ENOLINK (121) — 链接已断开。
pub extern "C" fn enolink() -> Int = "_moonbit_errno_ENOLINK"

///|
/// ENOMSG (122) — 无消息。
pub extern "C" fn enomsg() -> Int = "_moonbit_errno_ENOMSG"

///|
/// ENOPROTOOPT (123) — 协议选项不可用。
pub extern "C" fn enoprotoopt() -> Int = "_moonbit_errno_ENOPROTOOPT"

///|
/// ENOSR (124) — 流资源不足。
pub extern "C" fn enosr() -> Int = "_moonbit_errno_ENOSR"

///|
/// ENOSTR (125) — 非流。
pub extern "C" fn enostr() -> Int = "_moonbit_errno_ENOSTR"

///|
/// ENOTCONN (126) — 未连接。
pub extern "C" fn enotconn() -> Int = "_moonbit_errno_ENOTCONN"

///|
/// ENOTRECOVERABLE (127) — 状态不可恢复。
pub extern "C" fn enotrecoverable() -> Int = "_moonbit_errno_ENOTRECOVERABLE"

///|
/// ENOTSOCK (128) — 非套接字。
/// 
/// 对非 socket fd 调用 socket 操作。
pub extern "C" fn enotsock() -> Int = "_moonbit_errno_ENOTSOCK"

///|
/// ENOTSUP (129) — 不支持。
pub extern "C" fn enotsup() -> Int = "_moonbit_errno_ENOTSUP"

///|
/// EOPNOTSUPP (130) — 操作不支持。
pub extern "C" fn eopnotsupp() -> Int = "_moonbit_errno_EOPNOTSUPP"

///|
/// EOTHER (131) — 其他错误（MSVC 特有）。
pub extern "C" fn eother() -> Int = "_moonbit_errno_EOTHER"

///|
/// EOVERFLOW (132) — 值过大。
/// 
/// 超出目标类型可表示范围。
pub extern "C" fn eoverflow() -> Int = "_moonbit_errno_EOVERFLOW"

///|
/// EOWNERDEAD (133) — 所有者已死。
pub extern "C" fn eownerdead() -> Int = "_moonbit_errno_EOWNERDEAD"

///|
/// EPROTO (134) — 协议错误。
pub extern "C" fn eproto() -> Int = "_moonbit_errno_EPROTO"

///|
/// EPROTONOSUPPORT (135) — 协议不支持。
pub extern "C" fn eprotonosupport() -> Int = "_moonbit_errno_EPROTONOSUPPORT"

///|
/// EPROTOTYPE (136) — 协议类型错误。
pub extern "C" fn eprototype() -> Int = "_moonbit_errno_EPROTOTYPE"

///|
/// ETIME (137) — 定时器过期。
pub extern "C" fn etime() -> Int = "_moonbit_errno_ETIME"

///|
/// ETIMEDOUT (138) — 超时。
pub extern "C" fn etimedout() -> Int = "_moonbit_errno_ETIMEDOUT"

///|
/// ETXTBSY (139) — 文本文件忙。
/// 
/// 试图修改正在执行的可执行文件。
pub extern "C" fn etxtbsy() -> Int = "_moonbit_errno_ETXTBSY"

///|
/// EWOULDBLOCK (140) — 操作会阻塞。
/// 
/// 某些系统上等同于 EAGAIN。
pub extern "C" fn ewouldblock() -> Int = "_moonbit_errno_EWOULDBLOCK"