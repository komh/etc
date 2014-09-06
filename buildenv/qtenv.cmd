call gcc4.cmd WLINK
set MAKESHELL=e:\os2\cmd.exe
set qtdir=%1
if "%qtdir%" == "" set qtdir=f:\lang\qt4
set path=%qtdir%\bin;%PATH%
set beginlibpath=%qtdir%\bin;%BEGINLIBPATH%
set qtdir=
set CPLUS_INCLUDE_PATH=.;%CPLUS_INCLUDE_PATH%
