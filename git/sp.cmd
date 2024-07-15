@echo off
setlocal
set MAIL_LIST_ADDR=
f:\apps\gse.cmd --to %MAIL_LIST_ADDR% %1 %2 %3 %4 %5 %6 %7 %8 %9
bw
endlocal
