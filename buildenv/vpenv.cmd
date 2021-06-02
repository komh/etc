@echo off

setlocal

set VPDIR=f:\lang\vp21
set PATH=%VPDIR%\bin.os2;%PATH%
set OLDB=%BEGINLIBPATH%
set BEGINLIBPATH=%VPDIR%\bin.os2;%BEGINLIBPATH%

echo.
echo ****************************************************************
echo               Environment variables set up for Virtual Pascal
echo ****************************************************************

%COMSPEC%

set BEGINLIBPATH=%OLDB%

endlocal

echo.
echo ****************************************************************
echo                 Back to original configuration
echo ****************************************************************
