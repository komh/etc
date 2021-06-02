@echo off

set GCCENVCMD=%1
set QTDIR=%2

if "%GCCENVCMD%" == "" set GCCENVCMD=gcc4
if "%QTDIR%" == "" set QTDIR=f:\lang\qt4

call %GCCENVCMD%.cmd

set MAKESHELL=e:\os2\cmd.exe

set PATH=%QTDIR%\bin;%PATH%
set BEGINLIBPATH=%QTDIR%\bin;%BEGINLIBPATH%
set CPLUS_INCLUDE_PATH=.;%CPLUS_INCLUDE_PATH%

set GCCENVCMD=
set QTDIR=
