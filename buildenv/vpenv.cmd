@echo off

setlocal

set OLDB=%BEGINLIBPATH%

call setvpenv.cmd

echo.
echo ****************************************************************
echo               Environment variables set up for Virtual Pascal
echo ****************************************************************

%COMSPEC%

echo.
echo ****************************************************************
echo                 Back to original configuration
echo ****************************************************************

set BEGINLIBPATH=%OLDB%

endlocal
