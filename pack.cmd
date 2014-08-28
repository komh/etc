if "%1" == "" goto error
xcopy /s/e/v/h/t/r %1 %1.pack\
cd %1.pack
sh ./configure --prefix=/usr --enable-shared --enable-static
gmake clean
gmake install DESTDIR=/%1
cd ..
rm -rf %1.pack
cd %1
gmake dist-zip
move %1.zip ..\%1%2-src.zip
kdi > ..\os2.diff
cd ..
copy %1.txt \%1\%1%2.txt
move %1%2-src.zip \%1
copy donation.txt \%1
move os2.diff \%1
zip -rpSm %1%2.zip /%1
goto end
:error
echo Usage: pack directory [suffix]
:end