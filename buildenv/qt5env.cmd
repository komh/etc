@echo off

set GCCENVCMD=%1

if "%GCCENVCMD%" == "" set GCCENVCMD=gccr

call %GCCENVCMD%.cmd

rem set QTDIR=g:\usr
rem set QTDIR2=g:/usr

rem set PATH=%QTDIR%\bin;%PATH%
rem set BEGINLIBPATH=%QTDIR%\lib;%BEGINLIBPATH%
rem set CPLUS_INCLUDE_PATH=.;%CPLUS_INCLUDE_PATH%
rem set PKG_CONFIG_PATH=%QTDIR2%/lib/pkgconfig;%PKG_CONFIG_PATH%

set GCCENVCMD=
set QTDIR=
set QTDIR2=
