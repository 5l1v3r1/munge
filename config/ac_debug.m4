##*****************************************************************************
## $Id: ac_debug.m4,v 1.2 2003/05/07 17:02:44 dun Exp $
##*****************************************************************************
#  AUTHOR:
#    Chris Dunlap <cdunlap@llnl.gov>
#
#  SYNOPSIS:
#    AC_DEBUG
#
#  DESCRIPTION:
#    Adds support for the "--enable-debug" configure script option.
#    If CFLAGS are not passed to configure, they will be set based
#    on whether debugging has been enabled.  Also, the NDEBUG macro
#    (used by assert) will be set accordingly.
#
#  WARNINGS:
#    This macro must be placed after AC_PROG_CC or equivalent.
##*****************************************************************************

AC_DEFUN([AC_DEBUG],
[
  AC_MSG_CHECKING([whether debugging is enabled])
  AC_ARG_ENABLE([debug],
    AC_HELP_STRING([--enable-debug], [enable debugging code for development]),
    [ case "$enableval" in
        yes) ac_debug=yes ;;
        no)  ac_debug=no ;;
        *)   AC_MSG_RESULT([doh!])
             AC_MSG_ERROR([bad value "$enableval" for --enable-debug]) ;;
      esac
    ]
  )
  if test "$ac_debug" = yes; then
    if test -z "$ac_save_CFLAGS"; then
      test "$ac_cv_prog_cc_g" = yes && CFLAGS="-g"
      test "$GCC" = yes && CFLAGS="$CFLAGS -Wall -Werror"
    fi
  else
    if test -z "$ac_save_CFLAGS"; then
      test "$GCC" = yes && CFLAGS="-O2 -Wall" || CFLAGS="-O"
    fi
    AC_DEFINE([NDEBUG], [1],
      [Define to 1 if you are building a production release.])
  fi
  AC_MSG_RESULT([${ac_debug=no}])
])
