/* pack.cmd */
parse arg sDir sRev;

if sDir = '' then
do
    say 'Usage: pack directory [revision]';

    exit 1;
end

call setlocal;

/* set fRebuild to 1 if a package should be rebuild after clean,
 * otherwise set to 0
 */
fRebuild = 1;

/* set fMakeClean to 1 if using make for clean,
 * or set to 0 if doing clean manually
 */
fMakeClean = 1;

/* set fDist to 1 if dist-zip is supported, otherwise set to 0 */
fDist = 1;

/* get a version and a base name of package */
'cd' sDir;
sVer = getOutput('git describe --abbrev=0');
sPackageBase = delstr( sDir, pos('-os2.git', sDir ));
'cd ..';

/* get a package name */
sPackage = sPackageBase || '-' || sVer;
sPackageZip = sPackage || '.zip';
sPackageSrcZip = sPackage || sRev || '-src.zip';

if fRebuild | \fDist then
do
    /* get a temporary directory name for packaging */
    sDirPackBase = sDir || '.pack';
    sDirPack = sDirPackBase;
    if fDist \= 1 then
        sDirPack = sDirPack || '\' || sPackage;

    /* prepare a temporary directory for packaging */
    'md' sDirPackBase;
    'xcopy /s/e/v/h/t/r' sDir sDirPack || '\';
    'cd' sDirPack;

    if fRebuild then
    do
        /* create binary distribution */
        'call configure.cmd --enable-shared --enable-static';

        /* add -s to GCCOPT to remove symbols from release binaries */
        'set GCCOPT=%GCCOPT% -s';

        if fMakeClean then
        do
            /* clean generated files */
            'gmake clean';
        end
        else
        do
            /* clean objects and executables manually */
            'find . -name "*.o" -o -name "*.lo"',
                '-o -name "*.a" -o -name "*.dll" -o -name "*.la"',
                '-o -name "*.exe"',
                '| xargs rm -f';
        end
    end
end
else
    'cd' sDir;

/* install binaries */
'gmake install DESTDIR=/' || sPackage;

/* create source distribution */
if fDist then
do
    /* rename .git directory
     * to prevent local changes from being written into ChangeLog
     */
    'if exist .git ren .git .git.sav';

    /* create a source zip */
    'gmake dist-zip';

    /* add additional files to a source zip */
    'if exist autogen.cmd zip' sPackageZip 'autogen.cmd';
    'if exist bootstrap.cmd zip' sPackageZip 'bootstrap.cmd';
    'if exist configure.cmd zip' sPackageZip 'configure.cmd';

    /* move a source zip to a parent directory */
    'move' sPackageZip '..\' || sPackageSrcZip;

    /* restore .git directory */
    'if exist .git.sav ren .git.sav .git';
end
else
do
    /* clean all generated files */
    'gmake distclean';

    /* remove additional files not covered by distclean */
    'find . -name med.lru | xargs rm -f';
    'find . -name gmake.log | xargs rm -f';
    'find . -name "*~" | xargs rm -f';
    'find . -name "*.bak" | xargs rm -f';
    'find . -name autom4te.cache | xargs rm -rf';
    'rm -f .gitattributes .gitignore';
    'rm -rf .git';

    'cd ..';
    'zip -rpS ..\' || sPackageSrcZip sPackage;
end

'cd ..';

/* clean a temporary directory up */
if fRebuild | \fDist then
    'rm -rf' sDirPackBase;

/* create diffs in a parent directory */
'cd' sDir;
'git diff' sVer 'HEAD > ..\os2.diff';
'cd ..';

/* prepare hobbes upload template */
'sed s/@VER@/' || sVer|| sRev || '/g' sPackageBase || '.txt >',
     sPackage || sRev || '.txt';

/* copy hobbes upload template to a dir for packaging */
'copy' sPackage || sRev || '.txt',
       '\' || sPackage || '\' || sPackage || sRev || '.txt';

/* copy a source zip file to a dir for packaging */
'move' sPackageSrcZip '\' || sPackage;

/* copy additional files to a dir for packaging */
'copy donation.txt \' || sPackage;
'move os2.diff \' || sPackage;

/* create a package */
'zip -rpSm' sPackage || sRev || '.zip /' || sPackage;

call endlocal;

exit 0;

getOutput: procedure
    parse arg sCmd;

    nl = x2c('d') || x2c('a');

    rqNew = rxqueue('create');
    rqOld = rxqueue('set', rqNew );

    address cmd sCmd '| rxqueue' rqNew;

    sResult = '';
    do while queued() > 0
        parse pull sLine;
        sResult = sResult || sLine || nl;
    end

    call rxqueue 'Delete', rqNew;
    call rxqueue 'Set', rqOld;

    /* remove empty lines at end */
    do while right( sResult, length( nl )) = nl
        sResult = delstr( sResult, length( sResult ) - length( nl ) + 1 );
    end

    return sResult;
