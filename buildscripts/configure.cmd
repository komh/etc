extproc sh

./configure. --disable-shared --enable-static "$@" 2>&1 | tee configure.log
