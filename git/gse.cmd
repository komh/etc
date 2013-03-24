/* gse.cmd */
parse arg argall
'@echo off'
'setlocal'
'set PATH=f:\lang\perl5\bin;%PATH%'
'set OLD_BEGINLIBPATH=%BEGINLIBPATH%'
'set BEGINLIBPATH=f:\lang\perl5\bin;%BEGINLIBPATH%'
'set PERLLIB_PREFIX=/perl5/lib;f:/lang/perl5/lib'
'set PERL_SH_DIR=f:/bin'
'git se ' argall
'set BEGINLIBPATH=%OLD_BEGINLIBPATH'
'endlocal'
