@echo off
rem set STATIC_LIBGCC=-static-libgcc
call gccenv.cmd f:\lang\gcc\usr gcc910 %STATIC_LIBGCC%
set STATIC_LIBGCC=
