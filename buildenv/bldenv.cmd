@echo off

if not "x%KO_BLD_ENV%" == "x" goto end

SET KO_BLD_ENV=1

SET BEGINLIBPATH=f:\apps;f:\usr\lib;f:\usr\dll;f:\lang\emx\dll;f:\lang\Perl\lib;f:\lang\python27;f:\lang\qt4\bin;f:\lang\os2tk45\samples\mm\dll;f:\lang\os2tk45\som\common\dll;f:\lang\os2tk45\som\lib;f:\lang\os2tk45\dll;f:\lang\IBMCPP\DLL;f:\lang\bcos2\bin;%BEGINLIBPATH%
SET PATH=f:\apps;f:\usr\bin;f:\usr\sbin;f:\lang\emx\bin;f:\lang\Perl\bin;f:\lang\python27;f:\lang\os2tk45\som\common;f:\lang\os2tk45\som\bin;f:\lang\os2tk45\bin;f:\lang\IBMCPP\BIN;f:\lang\IBMCPP\HELP;f:\lang\IBMCPP\SMARTS\SCRIPTS;%PATH%
SET DPATH=f:\lang\os2tk45\som\common\system;f:\lang\os2tk45\som\msg;f:\lang\os2tk45\msg;f:\lang\os2tk45\book;f:\lang\emx\book;g:\books;%DPATH%
SET BOOKSHELF=f:\lang\emx\book;f:\lang\os2tk45\book;f:\lang\ddk\docs;g:\books;f:\usr\book;%BOOKSHELF%

REM ----- OS2UNIX Environment -----
SET HOME=f:/home/komh
SET USER=komh
SET EDITOR=f:\apps\q.exe
SET UNIXROOT=f:
SET INFOPATH=.;f:/usr/info;f:/usr/share/info;f:/lang/emx/info;F:/apps/octave/doc;
SET TERMINFO=f:/usr/share/terminfo
SET GNULOCALEDIR=f:/usr/share/locale
rem SET LANGUAGE=ko
SET CONFIG_SITE=f:/usr/etc/config.site

REM ----- settings for pkg-config -----
SET PKG_CONFIG_PATH=f:/usr/lib/pkgconfig
rem SET PKG_CONFIG_ALLOW_SYSTEM_CFLAGS=1
rem SET PKG_CONFIG_ALLOW_SYSTEM_LIBS=1

REM ----- settings for OpenSSL -----
SET OPENSSL_CONF=f:\usr\ssl\openssl.cnf

REM ----- settings for EMX -----
SET EMX=f:/lang/emx
SET EMXOPT=-c -h2048
SET C_INCLUDE_PATH=.;f:/usr/include;f:/lang/emx/include;f:/lang/os2tk45/speech/h;f:/lang/os2tk45/som/include;f:/lang/os2tk45/inc;f:/lang/os2tk45/h/gl;f:/lang/os2tk45/h;f:/lang/os2tk45/h/libc
SET LIBRARY_PATH=f:/usr/lib;f:/usr/dll;f:/lang/emx/lib;f:/lang/os2tk45/speech/lib;f:/lang/os2tk45/samples/mm/lib;f:/lang/os2tk45/lib;f:/lang/os2tk45/som/lib
SET CPLUS_INCLUDE_PATH=.;f:/usr/include;f:/lang/emx/include/cpp-old;f:/lang/emx/include;f:/lang/os2tk45/speech/h;f:/lang/os2tk45/som/include;f:/lang/os2tk45/inc;f:/lang/os2tk45/h/gl;f:/lang/os2tk45/h;f:/lang/os2tk45/h/libc
SET PROTODIR=f:/lang/emx/include/cpp-old/gen
SET OBJC_INCLUDE_PATH=.;f:/usr/include;f:/lang/emx/include;f:/lang/os2tk45/speech/h;f:/lang/os2tk45/som/include;f:/lang/os2tk45/inc;f:/lang/os2tk45/h/gl;f:/lang/os2tk45/h;f:/lang/os2tk45/h/libc
SET GCCLOAD=5
SET GCCOPT=-pipe
SET TERMCAP=f:/lang/emx/etc/termcap.dat
SET TERM=ansi
rem SET INFOPATH=f:/lang/emx/info
SET EMXBOOK=emxdev.inf+emxlib.inf+emxgnu.inf+emxbsd.inf
SET HELPNDX=EPMKWHLP.NDX+emxbook.ndx+tcppr.ndx+CPP.NDX+CPPBRS.NDX

REM ----- settings for network -----
SET USERNAME=komh

REM ----- Perl 5.10.0 Settings -----
rem SET PERLLIB_PREFIX=/perl5/lib;f:/lang/perl5/lib
rem SET PERL_SH_DIR=f:/bin

REM ----- Perl 5.8.0 Settings -----
SET PERLLIB_PREFIX=L:/Perl/lib;f:\lang\Perl\lib
SET PERL_LIBPATH=L:/Perl/lib;f:\lang\Perl\lib;
SET PERL_BADFREE=0
SET PERL_BADLANG=0
SET PERL_SH_DIR=f:\bin

REM ----- DMAKE -----
SET MAKESTARTUP=f:\apps\dmake.ini

REM ----- Free Pascal -----
SET PPC_EXEC_PATH=f:\lang\fpc\bin\os2

REM ----- Settings for DDK -----
SET CL=/B1c1l.exe /B2c2l.exe /B3c3l.exe
SET DDK=f:\lang\ddk
SET DDKTOOLS=f:\lang\ddktools

REM ----- Settings for VACPP v3.0 -----
SET VACPP_SHARED=FALSE
SET CPPHELP_INI=E:\OS2\SYSTEM
SET CPPLOCAL=f:\lang\IBMCPP
SET CPPMAIN=f:\lang\IBMCPP
SET CPPWORK=f:\lang\IBMCPP
SET IWFHELP=IWFHDI.INF
SET IWFOPT=f:\lang\IBMCPP
SET IWF.DEFAULT_PRJ=CPPDFTPRJ
SET IWF.SOLUTION_LANG_SUPPORT=CPPIBS30;ENG
SET THREADS=512
SET INCLUDE=f:\lang\os2tk45\speech\h;f:\lang\os2tk45\som\include;f:\lang\os2tk45\inc;f:\lang\os2tk45\h\gl;f:\lang\os2tk45\h;f:\lang\os2tk45\h\libc;f:\lang\IBMCPP\INCLUDE;f:\lang\IBMCPP\INCLUDE\SOM;.
SET SMINCLUDE=f:\lang\os2tk45\h;f:\lang\os2tk45\idl;.;f:\lang\os2tk45\som\include;f:\lang\IBMCPP\INCLUDE;f:\lang\IBMCPP\INCLUDE\SOM
SET VBPATH=.;f:\lang\IBMCPP\DDE4VB
SET TMPDIR=P:\tmp
SET LXEVFREF=EVFELREF.INF+LPXCREF.INF
SET LXEVFHDI=EVFELHDI.INF+LPEXHDI.INF
SET LPATH=f:\lang\IBMCPP\MACROS
SET CODELPATH=f:\lang\IBMCPP\CODE\MACROS;f:\lang\IBMCPP\MACROS
SET CLREF=CPPCLRF.INF+CPPDAT.INF+CPPAPP.INF+CPPWIN.INF+CPPCTL.INF+CPPADV.INF+CPP2DG.INF+CPPDDE.INF+CPPDM.INF+CPPMM.INF+CPPCLRB.INF
SET LIB=f:\lang\os2tk45\speech\lib;f:\lang\os2tk45\samples\mm\lib;f:\lang\os2tk45\lib;f:\lang\os2tk45\som\lib;f:\lang\IBMCPP\LIB

REM === BC 2.0 ===
SET IPFC=f:\lang\os2tk45\ipfc;F:\LANG\BCOS2\IPFC

REM ----- Settings for OS/2 ToolKit v4.5 -----
SET SOMBASE=f:\lang\os2tk45\som
SET SOMRUNTIME=f:\lang\os2tk45\som\common
SET CPREF=CP1.INF+CP2.INF+CP3.INF
SET GPIREF=GPI1.INF+GPI2.INF+GPI3.INF+GPI4.INF
SET MMREF=MMREF1.INF+MMREF2.INF+MMREF3.INF
SET PMREF=PM1.INF+PM2.INF+PM3.INF+PM4.INF+PM5.INF
SET WPSREF=WPS1.INF+WPS2.INF+WPS3.INF
SET SMADDSTAR=1
SET SMEMIT=h;ih;c
SET SMTMP=P:\tmp
SET SMCLASSES=wptypes.idl

REM ----- settings for GIT -----
SET GIT_FIND=f:/usr/bin/find.exe
SET GIT_SORT=f:/usr/bin/sort.exe
SET EMAIL=komh@chollian.net
rem SET GITPERLLIB=f:/usr/lib/site_perl/5.10.0
rem SET GIT_EXEC_PATH=f:/usr/libexec/git-core
SET GIT_SSH=f:/apps/openssh/ssh.exe
SET GIT_SHELL=f:/bin/sh.exe

REM ----- settings for groff -----
SET GROFF_TMAC_PATH=f:/usr/share/groff/tmac
SET GROFF_FONT_PATH=f:/usr/share/groff/font
rem SET REFER=f:/usr/lib/groff/dict/papers/ind

REM ----- settings for man -----
SET MANPATH=f:/usr/man;f:/usr/share/man
rem SET MAN_CONF=f:/usr/etc/man.conf
rem SET MANPAGER=less

REM ----- settings for Python -----
SET PYTHONHOME=f:/lang/python27
SET PYTHONPATH=%PYTHONHOME%/Lib;%PYTHONHOME%/Lib/plat-os2knix;%PYTHONHOME%/Lib/lib-dynload;%PYTHONHOME%/Lib/site-packages

:end
