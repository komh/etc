extproc sh

# convert backslashes of PATH to slashes
export PATH=$(expr "$PATH" | tr '\\' /)

export ac_executable_extensions=".exe"

./configure "$@"
