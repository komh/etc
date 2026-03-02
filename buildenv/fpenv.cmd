@echo off

setlocal

set OLDB=%BEGINLIBPATH%

call setfpenv.cmd

echo.
echo ****************************************************************
echo               Environment variables set up for Free Pascal
echo ****************************************************************

%COMSPEC%

echo.
echo ****************************************************************
echo                 Back to original configuration
echo ****************************************************************

set BEGINLIBPATH=%OLDB%

endlocal
