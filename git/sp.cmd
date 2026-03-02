@echo off
setlocal
set MAIL_LIST_ADDR=
call f:\apps\gitse.cmd --to %MAIL_LIST_ADDR% %1 %2 %3 %4 %5 %6 %7 %8 %9
call bw.cmd
endlocal
