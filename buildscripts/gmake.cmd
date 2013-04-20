/* gmake.cmd */
parse arg argall
'@echo off'
'setlocal'
'set LANG=en_US'
'set COMSPEC=/bin/sh'
'rem make SHELL=/bin/sh' argall
'set MAKESHELL=/bin/sh'
'make' argall
ec = rc
'endlocal'
exit ec
