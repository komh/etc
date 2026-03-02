@echo off
set STATIC_LIBGCC=-static-libgcc
call gccenv.cmd g:\usr gcc1520 %STATIC_LIBGCC%
set STATIC_LIBGCC=
