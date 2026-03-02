@ECHO OFF

setlocal

SET OLDE=%ENDLIBPATH%

call seticcenv.cmd

echo.
echo ****************************************************************
echo           Environment variables set up for ICC
echo ****************************************************************

%COMSPEC%

echo.
echo ****************************************************************
echo                 Back to original configuration
echo ****************************************************************

SET ENDLIBPATH=%OLDE%

endlocal
