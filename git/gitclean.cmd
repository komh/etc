@echo off
find . -maxdepth 1 -not ( -regex \. -o -name .git -o -name .gitignore -o -name .gitattributes -o -name med.lru -o -name patches -o -name *.cmd ) | xargs rm -rf
