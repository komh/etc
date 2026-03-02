@ECHO OFF

setlocal

SET OLDB=%BEGINLIBPATH%

call setwenv.cmd

echo.
echo ****************************************************************
echo           Environment variables set up for Open Watcom
echo ****************************************************************

%COMSPEC%

echo.
echo ****************************************************************
echo                 Back to original configuration
echo ****************************************************************

SET BEGINLIBPATH=%OLDB%

endlocal
