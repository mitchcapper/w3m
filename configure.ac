AC_PREREQ([2.64])

dnl w3m autoconf
dnl Process this file with autoconf to produce a configure script.
AC_INIT([w3m],[0.5.5])
PACKAGE=w3m
VERSION=0.5.5
AC_DEFINE_UNQUOTED([PACKAGE], "$PACKAGE", [package name])
AC_DEFINE_UNQUOTED([VERSION], "$VERSION", [package version])

AC_SUBST(PACKAGE)
AC_SUBST(VERSION)

AC_SUBST(W3M)
W3M=w3m


AC_DEFINE([W3M], "w3m", [w3m])

AC_SUBST(W3M_LANG)
W3M_LANG=${LC_ALL:-$LANG}
dnl AM_INIT_AUTOMAKE(w3m, 0.4)
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_HEADERS([config.h:config.h.in orig_config.h:orig_config.h.in])
AC_USE_SYSTEM_EXTENSIONS
dnl Checks for programs.
AM_INIT_AUTOMAKE([-Wall -Werror foreign])

AC_PROG_CXX
AC_PROG_AWK
AC_PROG_CC
gl_EARLY
AC_PROG_CPP
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MAKE_SET
AC_PROG_RANLIB
m4_ifdef([AC_PROG_AR], [AC_PROG_AR])
m4_ifdef([AM_PROG_AR], [AM_PROG_AR])
AC_PATH_PROGS(PERL, perl, /usr/local/bin/perl)
AC_PATH_PROGS(NKF, nkf, /usr/local/bin/nkf)
AC_PATH_PROGS(MAN, man, /usr/bin/man)
AC_PATH_XTRA
AC_CANONICAL_HOST


AC_SUBST(KEYBIND_SRC)
AC_SUBST(KEYBIND_OBJ)
AC_DEFINE([KEYBIND_SRC], "keybind.c", [Keybind source file])
AC_DEFINE([KEYBIND_OBJ], "keybind.o", [Keybind object file])
AC_EXEEXT
AC_SUBST(EXEEXT)

gl_INIT

AUXBIN_TARGETS=

AC_SUBST(W3M_TARGET)
AC_SUBST(W3M_LIBS)
W3M_TARGET=$target
AC_DEFINE_UNQUOTED([W3M_TARGET], "$W3M_TARGET", [w3m target])

AC_W3M_M17N


NLSTARGET=""
if test x"$USE_NLS" = xyes; then
  NLSTARGET="po"
fi
AC_SUBST(INTLTARGET)
AC_SUBST(NLSTARGET)

AC_W3M_COLOR
AC_W3M_ANSI_COLOR
AC_W3M_BG_COLOR
AC_DEFINE([AUXBIN_TARGETS], [], [Description])
AC_W3M_IMAGE
if test x"$enable_image" != xno; then
 AUXBIN_TARGETS="$AUXBIN_TARGETS w3mimgdisplay\$(EXT)"
 AC_W3M_XFACE
fi
AM_CONDITIONAL([ENABLE_IMAGE], [test x"$enable_image" != xno])

AC_W3M_KEYMAP
AC_W3M_MENU
AC_W3M_MOUSE
AC_W3M_HISTORY
AC_W3M_ALARM

AC_W3M_COOKIE
AC_W3M_NNTP
AC_W3M_GOPHER

AC_W3M_DICT
AC_W3M_HELP_CGI
AC_W3M_EXTERNAL_URI_LOADER
AC_W3M_W3MMAILER
AC_W3M_MIGEMO
AC_W3M_EDITOR
AC_W3M_MAILER
AC_W3M_EXT_BROWSER

dnl Checks for ext libs
for lib in bsd BSD 44bsd socket nsl dld dl
do
 AC_W3M_EXTLIBS($lib)
done

AC_W3M_IPv6
AC_W3M_SSL_DIGEST_AUTH

dnl Checks for libraries.
AC_CHECK_FUNC(sqrt,,[AC_CHECK_LIB(m, sqrt)])
if test x"$enable_mouse" = xyes; then
 AC_SUBST(USE_W3M)
 AC_CHECK_LIB(gpm, Gpm_Open, [AC_DEFINE([USE_GPM], 1, [Use GPM mouse support])
   		W3M_LIBS="$W3M_LIBS -lgpm"])
 AC_SUBST(USE_SYSMOUSE)
 AC_COMPILE_IFELSE([AC_LANG_SOURCE([#include <sys/consio.h>
   int test = MOUSE_GETINFO;])], [AC_DEFINE([USE_SYSMOUSE], 1, [Use sysmouse])],
   [AC_COMPILE_IFELSE([AC_LANG_SOURCE([#include <machine/console.h>
      MOUSE_GETINFO], [AC_DEFINE([USE_SYSMOUSE], 1, [Use sysmouse])])])])
fi
AC_SUBST(AUXBIN_TARGETS)
AC_W3M_TERMLIB
AC_W3M_GC
AC_CHECK_LIB(z, zError, [AUXBIN_TARGETS="$AUXBIN_TARGETS inflate\$(EXT)"])

AC_CHECK_TYPE([socklen_t],
   [AC_DEFINE([HAVE_SOCKLEN_T], 1, [Have socklen_t])], ,
	 [#include <sys/types.h>
	  #include <sys/socket.h>])

AC_DEFINE_UNQUOTED(AUXBIN_TARGETS, "$AUXBIN_TARGETS", [AUXBIN TARGETS])

AC_SUBST(USE_BINMODE_STREAM)
case "$host_os" in
  *cygwin*|*os2-emx*|*mingw*)
    AC_DEFINE([USE_BINMODE_STREAM], 1, [Use binary mode for streams])
    ;;
esac

AC_HEADER_DIRENT
AC_HEADER_SYS_WAIT
AC_CHECK_HEADER(termios.h, [AC_DEFINE([HAVE_TERMIOS_H], 1, [Have termios.h])],
   [AC_CHECK_HEADER(termio.h, [AC_DEFINE([HAVE_TERMIO_H], 1, [Have termio.h])],
    [AC_CHECK_HEADER(sgtty.h, [AC_DEFINE([HAVE_SGTTY_H], 1, [Have sgtty.h])])])])
AC_CHECK_HEADER([float.h], [AC_DEFINE([HAVE_FLOAT_H], 1, [Have float.h])])
AC_CHECK_HEADER([sys/select.h], [AC_DEFINE([HAVE_SYS_SELECT_H], 1, [Have sys/select.h])])
AC_CHECK_HEADER([locale.h], [AC_DEFINE([HAVE_LOCALE_H], 1, [Have locale.h])])
AC_CHECK_HEADER([stdint.h], [AC_DEFINE([HAVE_STDINT_H], 1, [Have stdint.h])])
AC_CHECK_HEADER([inttypes.h], [AC_DEFINE([HAVE_INTTYPES_H], 1, [Have inttypes.h])])

dnl Checks for library functions.
AC_CHECK_FUNCS(strcasecmp strcasestr strchr memcpy strerror setpgrp chdir mkdtemp faccessat getcwd getwd readlink setenv putenv strtoll stroq atoll atoq symlink readlink lstat srand48 srandom getpassphrase waitpid setlocale)
AC_FUNC_STRFTIME
AC_FUNC_SETPGRP
AC_W3M_SIGSETJMP

AC_SUBST(HELP_DIR)
HELP_DIR="$datadir/$PACKAGE"
AC_DEFINE([HELP_DIR], "$HELP_DIR", [Help directory])
AC_SUBST(RC_DIR)
RC_DIR="~/.$PACKAGE"
AC_DEFINE([RC_DIR], "$RC_DIR", [RC directory])
AC_SUBST(DOCDIRS)
DOCDIRS="doc:en_English doc-jp:ja_Japanese doc-de:de_German"
AC_DEFINE_UNQUOTED([DOCDIRS], "$DOCDIRS", [Documentation directories])




AC_CONFIG_FILES([Makefile posubst po/Makefile.in \
m4/Makefile lib/Makefile \
scripts/Makefile scripts/dirlist.cgi \
scripts/w3mhelp.cgi \
scripts/w3mmail.cgi scripts/xface2xpm \
scripts/multipart/Makefile scripts/multipart/multipart.cgi \
scripts/w3mman/Makefile scripts/w3mman/w3mman \
scripts/w3mman/w3mman.1 scripts/w3mman/w3mman.de.1 \
scripts/w3mman/w3mman2html.cgi \
libwc/Makefile \
w3mimg/Makefile w3mimg/fb/Makefile w3mimg/x11/Makefile w3mimg/win/Makefile \
w3mhelp-w3m_en.html w3mhelp-w3m_ja.html \
w3mhelp-lynx_en.html w3mhelp-lynx_ja.html])
AC_OUTPUT

chmod +x posubst
