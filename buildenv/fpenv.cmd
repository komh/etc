@echo off

setlocal

set FPDIR=f:\lang\fpc
set PATH=%FPDIR%\bin\os2;%PATH%
set OLDB=%BEGINLIBPATH%
set BEGINLIBPATH=%FPDIR%\dll;%BEGINLIBPATH%

echo.
echo ****************************************************************
echo               Environment variables set up for Free Pascal
echo ****************************************************************

%COMSPEC%

set BEGINLIBPATH=%OLDB%

endlocal

echo.
echo ****************************************************************
echo                 Back to original configuration
echo ****************************************************************
