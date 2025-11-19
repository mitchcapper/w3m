#pragma once
#define PDC_WIDE 1
//#define PDC_NCMOUSE 1
#define PDC_FORCE_UTF8 1
#include "../../final/include/term.h"

#include "../../final/include/curses.h"

// #define VT_MODE // internal define we should set if using VT instead of wincon to improve mouse events (but still broken in comparison)
//static int endwin_x64_4400() { return 0; }