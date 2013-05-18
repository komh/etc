if "%1" == "" goto error
git init .
git add .
git ci -m %1
git tag origin head
goto done
:error
echo Specify a commit message for a import
:done
