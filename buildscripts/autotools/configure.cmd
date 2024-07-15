extproc sh

d=$(dirname "$0" | tr '\\' /)

n=configure
test -f "$d/$n." || { echo "\`$d/$n' not found !!!"; exit 1; }

# convert backslashes of PATH to slashes
export PATH=$(expr "$PATH" | tr '\\' /)

export ac_executable_extensions=".exe"

export LDFLAGS=-Zhigh-mem

opts=""
"$d/$n" $opts "$@" 2>&1 | tee "$n.log"
