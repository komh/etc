@echo off

rem ****************************************************************
rem
rem    This batch file will set up the environment for using GCC
rem    At the beginning of the script there are several variables
rem    that you can change to suit your needs
rem
rem ****************************************************************

setlocal

SET OLDB=%BEGINLIBPATH%

call setemxenv.cmd

echo.
echo ****************************************************************
echo               Environment variables set up for EMX
echo ****************************************************************

%COMSPEC%

echo.
echo ****************************************************************
echo                 Back to original configuration
echo ****************************************************************

SET BEGINLIBPATH=%OLDB%

endlocal
