/* gmake.cmd */
parse arg argall
'@echo off'
'setlocal'
'set LANG=C'
'if "%MAKESHELL%" == "" set MAKESHELL=sh.exe'
'make.exe -j2' argall '2>&1 | tee gmake.log'
ec = rc
'endlocal'
exit ec
