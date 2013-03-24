@ECHO OFF

setlocal
SET WATCOM=F:\lang\watcom

SET PATH=%WATCOM%\BINP;%WATCOM%\BINW;%PATH%
SET INCLUDE=%WATCOM%\H;%WATCOM%\H\OS2;f:\lang\os2tk45\speech\h;f:\lang\os2tk45\som\include;f:\lang\os2tk45\inc;f:\lang\os2tk45\h\gl;f:\lang\os2tk45\h;f:\lang\os2tk45\h\libc;%INCLUDE%
rem SET LIB=f:\lang\os2tk45\speech\lib;f:\lang\os2tk45\samples\mm\lib;f:\lang\os2tk45\lib;f:\lang\os2tk45\som\lib;%LIB%
SET EDPATH=%WATCOM%\EDDAT;%EDPATH%
SET WIPFC=%WATCOM%\WIPFC;%WIPFC%
SET HELP=%WATCOM%\BINP\HELP;%HELP%
SET BOOKSHELF=%WATCOM%\BINP\HELP;%BOOKSHELF%
SET OLD_BEGINLIBPATH=%BEGINLIBPATH%
SET BEGINLIBPATH=%WATCOM%\BINP\DLL;%BEGINLIBPATH%

echo.
echo ****************************************************************
echo           Environment variables set up for Open Watcom
echo ****************************************************************

%COMSPEC%

SET BEGINLIBPATH=%OLD_BEGINLIBPATH%

endlocal

echo.
echo ****************************************************************
echo                 Back to original configuration
echo ****************************************************************

