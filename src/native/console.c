#ifdef _WIN32
#include <stdint.h>
#include <windows.h>

void _moonbit_set_console(uint32_t code) { SetConsoleOutputCP(code); }

uint32_t _moonbit_get_console_cp(void) { return GetConsoleOutputCP(); }

#endif