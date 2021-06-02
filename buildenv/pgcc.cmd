@echo off

rem ****************************************************************
rem
rem    This batch file will set up the environment for using GCC
rem    At the beginning of the script there are several variables
rem    that you can change to suit your needs
rem
rem ****************************************************************

setlocal

set EMX_PATH=f:\lang\emx
set EMX_PATH2=f:/lang/emx

set PATH=%EMX_PATH2%/bin.new;%PATH%
set C_INCLUDE_PATH=.;%EMX_PATH2%/include;f:\lang\os2tk45\speech\h;f:\lang\os2tk45\som\include;f:\lang\os2tk45\inc;f:\lang\os2tk45\h\gl;f:\lang\os2tk45\h;f:\lang\os2tk45\h\libc;%C_INCLUDE_PATH%
set LIBRARY_PATH=%EMX_PATH2%/lib.new;f:/usr/lib;f:/usr/dll;f:/lang/os2tk45/speech/lib;f:/lang/os2tk45/samples/mm/lib;f:/lang/os2tk45/lib;f:/lang/os2tk45/som/lib;%LIBRARY_PATH%
set CPLUS_INCLUDE_PATH=.;%EMX_PATH2%/include;f:\lang\os2tk45\speech\h;f:\lang\os2tk45\som\include;f:\lang\os2tk45\inc;f:\lang\os2tk45\h\gl;f:\lang\os2tk45\h;f:\lang\os2tk45\h\libc;%CPLUS_INCLUDE_PATH%
set OLD_BEGINLIBPATH=%BEGINLIBPATH%
set BEGINLIBPATH=%EMX_PATH2%/dll.new;%EMX_PATH2%/dll;%BEGINLIBPATH%

echo.
echo ****************************************************************
echo               Environment variables set up for PGCC
echo ****************************************************************

%COMSPEC%

set BEGINLIBPATH=%OLD_BEGINLIBPATH%

endlocal

echo.
echo ****************************************************************
echo                 Back to original EMX configuration
echo ****************************************************************
