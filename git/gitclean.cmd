@find . -maxdepth 1 -not ( -name . -o -name .. -o -name .git -o -name .gitignore -o -name .gitattributes -o -name med.lru -o -name patches -o -name *.cmd ) -exec rm -rf {} ;
