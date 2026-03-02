@echo off

rem UNIXROOT settings
set UNIXROOT=g:

rem ----- Set temporary envs -----
set PREFIX=%UNIXROOT%\usr
set PREFIX2=%UNIXROOT%/usr
set OS2TK45_PREFIX=f:/lang/os2tk45

rem ----- PATH settings -----
set PATH=%PREFIX%\sbin;%PREFIX%\bin;%PREFIX%\libexec\bin;%PATH%
set DPATH=%PREFIX%\share\os2\lang;%DPATH%
set HELP=%PREFIX%\share\os2\lang;%HELP%
set BOOKSHELF=%PREFIX%\share\os2\book;%BOOKSHELF%
set BEGINLIBPATH=%PREFIX%\lib;%BEGINLIBPATH%
set LIBPATHSTRICT=T

rem ----- gcc settings -----
set C_INCLUDE_PATH=%PREFIX2%/include;%OS2TK45_PREFIX%/speech/h;%OS2TK45_PREFIX%/som/include;%OS2TK45_PREFIX%/inc;%OS2TK45_PREFIX%/h/gl;%OS2TK45_PREFIX%/h;%OS2TK45_PREFIX%/h/libc
SET CPLUS_INCLUDE_PATH=%PREFIX2%/include;%OS2TK45_PREFIX%/speech/h;%OS2TK45_PREFIX%/som/include;%OS2TK45_PREFIX%/inc;%OS2TK45_PREFIX%/h/gl;%OS2TK45_PREFIX%/h;%OS2TK45_PREFIX%/h/libc
set LIBRARY_PATH=%PREFIX2%/lib;%OS2TK45_PREFIX%/speech/lib;%OS2TK45_PREFIX%/samples/mm/lib;%OS2TK45_PREFIX%/lib;%OS2TK45_PREFIX%/som/lib
set GCCLOAD=5
set GCCOPT=-pipe
set EMXOMFLD_TYPE=WLINK
set EMXOMFLD_LINKER=wl.exe
set EMXOMFLD_RC_TYPE=WRC
set EMXOMFLD_RC=wrc.exe

REM [ Default shell values ]
SET SHELL=g:/usr/bin/sh.exe
SET EMXSHELL=g:/usr/bin/sh.exe
SET CONFIG_SHELL=g:/usr/bin/sh.exe
SET MAKESHELL=g:/usr/bin/sh.exe
SET EXECSHELL=g:/usr/bin/sh.exe

rem Clear ACLOCAL envs
set ACLOCAL_PATH=g:/usr/share/aclocal;

rem Clear temporary envs
set OS2TK45_PREFIX=
set PREFIX2=
set PREFIX=

rem Clear Python envs
set PYTHONHOME=
set PYTHONPATH=

rem Clear Perl envs
set PERLLIB_PREFIX=
set PERL_SH_DIR=
