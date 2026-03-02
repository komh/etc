@echo off

setlocal

set OLDB=%BEGINLIBPATH%

call setpl5env.cmd

%COMSPEC%

set BEGINLIBPATH=%OLDB%

endlocal
