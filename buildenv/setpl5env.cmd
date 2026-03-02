@echo off

set PERL5DIR=f:\lang\perl5
set PERL5DIR2=f:/lang/perl5

set BEGINLIBPATH=%PERL5DIR%\bin;%BEGINLIBPATH%

set PATH=%PERL5DIR%\bin;%PATH%
set PERLLIB_PREFIX=/perl5/lib;%PERL5DIR2%
set PERL_SH_DIR=f:/bin

set PERL5DIR=
set PERL5DIR2=
