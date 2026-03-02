@ECHO OFF

SET WATCOM=F:\lang\watcom

SET BEGINLIBPATH=%WATCOM%\BINP\DLL;%BEGINLIBPATH%
SET PATH=%WATCOM%\BINP;%WATCOM%\BINW;%PATH%
SET INCLUDE=%WATCOM%\H\OS2;%WATCOM%\H;f:\lang\os2tk45\speech\h;f:\lang\os2tk45\som\include;f:\lang\os2tk45\inc;f:\lang\os2tk45\h\gl;f:\lang\os2tk45\h;f:\lang\os2tk45\h\libc;%INCLUDE%
rem SET LIB=f:\lang\os2tk45\speech\lib;f:\lang\os2tk45\samples\mm\lib;f:\lang\os2tk45\lib;f:\lang\os2tk45\som\lib;%LIB%
SET EDPATH=%WATCOM%\EDDAT;%EDPATH%
SET WIPFC=%WATCOM%\WIPFC;%WIPFC%
SET HELP=%WATCOM%\BINP\HELP;%HELP%
SET BOOKSHELF=%WATCOM%\BINP\HELP;%BOOKSHELF%
