@echo off

rem ****************************************************************
rem
rem    This batch file will set up the environment for using GCC
rem    At the beginning of the script there are several variables
rem    that you can change to suit your needs
rem
rem ****************************************************************

setlocal

set EMXDIR=f:\lang\emx
set EMXDIR2=f:/lang/emx

SET OLDB=%BEGINLIBPATH%
SET BEGINLIBPATH=%EMXDIR%\dll;%BEGINLIBPATH%

SET PATH=%EMXDIR%\bin;%PATH%
SET DPATH=%EMXDIR%\book;%DPATH%

SET HELP=%EMXDIR%\HELP;%HELP%
SET BOOKSHELF=%EMXDIR%\BOOK;%BOOKSHELF%

SET C_INCLUDE_PATH=%EMXDIR2%/include;%C_INCLUDE_PATH%
SET LIBRARY_PATH=%EMXDIR2%/lib;%LIBRARY_PATH%
SET CPLUS_INCLUDE_PATH=%EMXDIR2%/include;%EMXDIR2%/include/cpp-old;%CPLUS_INCLUDE_PATH%
SET PROTODIR=%EMXDIR2%/include/cpp-old/gen;%PROTODIR%
SET OBJC_INCLUDE_PATH=%EMXDIR2%/include;%OBJC_INCLUDE_PATH%
SET GCCLOAD=5
SET GCCOPT=-pipe
SET TERM=ansi
SET TERMCAP=%EMXDIR2%/etc/termcap.dat
SET INFOPATH=%EMXDIR2%/info;%INFOPATH%
SET EMXBOOK=emxdev.inf+emxlib.inf+emxgnu.inf+emxbsd.inf
SET HELPNDX=EPMKWHLP.NDX+emxbook.ndx+tcppr.ndx+CPP.NDX+CPPBRS.NDX

echo.
echo ****************************************************************
echo               Environment variables set up for EMX
echo ****************************************************************

%COMSPEC%

SET BEGINLIBPATH=%OLDB%

endlocal

echo.
echo ****************************************************************
echo                 Back to original configuration
echo ****************************************************************
