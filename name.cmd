extproc sh

pack_name=${1%%-(v[0-9]|[0-9])*.*}
pack_ver=${1#*${pack_name}-}
pack_ver=${pack_ver#v}

sed s/@VER@/${pack_ver}/g ${pack_name}.txt > $1.txt
