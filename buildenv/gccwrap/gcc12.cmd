@echo off
rem set STATIC_LIBGCC=-static-libgcc
call gccenv.cmd g:\usr gcc1240 %STATIC_LIBGCC%
set STATIC_LIBGCC=
