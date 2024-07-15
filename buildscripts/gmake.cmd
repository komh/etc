/* gmake.cmd */
parse arg argall
'@echo off'
'setlocal'
'set LANG=C'
'set MAKESHELL=/bin/sh'
'make -j2' argall '2>&1 | tee gmake.log'
ec = rc
'endlocal'
exit ec
