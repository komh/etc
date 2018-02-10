extproc sh

export MAKESHELL=/bin/sh

autoreconf -fvi "$@" 2>&1 | tee reconf.log
