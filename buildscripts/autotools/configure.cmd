extproc sh

# convert backslashes of PATH to slashes
export PATH=$(expr "$PATH" | tr '\\' /)

export ac_executable_extensions=".exe"

n=configure
test -f "./$n." || { echo "\`./$n' not found !!!"; exit 1; }
"./$n" "$@" 2>&1 | tee "$n.log"
