extproc sh

# convert backslashes of PATH to slashes
export PATH=$(expr "$PATH" | tr '\\' /)

export ac_executable_extensions=".exe"

test -f ./configure. || { echo "\`./configure' not found !!!"; exit 1; }
./configure "$@" 2>&1 | tee configure.log
