@echo off

rem ****************************************************************
rem
rem    This batch file will set up the environment for using GCC
rem    At the beginning of the script there are several variables
rem    that you can change to suit your needs
rem
rem ****************************************************************

setlocal

set EMX_PATH=f:/lang/emx
set WORK_SHELL=%COMSPEC%
rem set WORK_SHELL=call fc

set PATH=%EMX_PATH%/bin.new;%PATH%
set LIBRARY_PATH=%EMX_PATH%/lib.new;f:/usr/local/lib;f:/usr/lib;f:/usr/dll;f:/lang/os2tk45/speech/lib;f:/lang/os2tk45/samples/mm/lib;f:/lang/os2tk45/lib;f:/lang/os2tk45/som/lib
set CPLUS_INCLUDE_PATH=.;f:/lang/emx/include;f:\lang\os2tk45\speech\h;f:\lang\os2tk45\som\include;f:\lang\os2tk45\inc;f:\lang\os2tk45\h\gl;f:\lang\os2tk45\h;f:\lang\os2tk45\h\libc;
set OLD_BEGINLIBPATH=%BEGINLIBPATH%
set BEGINLIBPATH=%EMX_PATH%/dll.new;%EMX_PATH%/dll;%BEGINLIBPATH%

echo.
echo ****************************************************************
echo               Environment variables set up for PGCC
echo ****************************************************************

%WORK_SHELL%

set BEGINLIBPATH=%OLD_BEGINLIBPATH%

endlocal

echo.
echo ****************************************************************
echo                 Back to original EMX configuration
echo ****************************************************************
