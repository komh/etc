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
set WORK_SHELL=%COMSPEC%
rem set WORK_SHELL=call fc

SET HELP=%EMXDIR%\HELP;%HELP%
SET BOOKSHELF=%EMXDIR%\BOOK;%BOOKSHELF%

SET C_INCLUDE_PATH=f:/lang/emx/include;
SET LIBRARY_PATH=f:/lang/emx/lib;
SET CPLUS_INCLUDE_PATH=f:/lang/emx/include;f:/lang/emx/include/cpp-old;
SET PROTODIR=f:/lang/emx/include/cpp-old/gen;
SET OBJC_INCLUDE_PATH=f:/lang/emx/include;
SET GCCLOAD=5
SET GCCOPT=-pipe
SET TERM=ansi
SET TERMCAP=f:\XFree86\lib\Termcap
SET INFOPATH=.;f:/lang/emx/info
SET EMXBOOK=emxdev.inf+emxlib.inf+emxgnu.inf+emxbsd.inf
SET HELPNDX=EPMKWHLP.NDX+emxbook.ndx+tcppr.ndx+CPP.NDX+CPPBRS.NDX

echo.
echo ****************************************************************
echo               Environment variables set up for EMX
echo ****************************************************************

%WORK_SHELL%

endlocal

echo.
echo ****************************************************************
echo                 Back to original EMX configuration
echo ****************************************************************

