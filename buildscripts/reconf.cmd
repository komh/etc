extproc sh

export MAKESHELL=sh.exe

autoreconf -fvi "$@" 2>&1 | tee reconf.log
exit ${PIPESTATUS[0]}
