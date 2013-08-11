extproc sh

export COMSPEC=/bin/sh

# convert backslashes of PATH to slashes
IFS="\\"
TEMP_PATH=
for dir in $PATH; do
    if test -z "$TEMP_PATH"; then
        TEMP_PATH="$dir"
    else
        TEMP_PATH="$TEMP_PATH/$dir"
    fi
done
PATH="$TEMP_PATH"
export PATH
unset TEMP_PATH

export ac_executable_extensions=".exe"

make.exe SHELL=/bin/sh $*

