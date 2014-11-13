/* pack.cmd */
parse arg sDir sRev;

if sDir = '' then
do
    say 'Usage: pack directory [revision]';

    exit 1;
end

call setlocal;

/***** start of configuration block *****/

/* set fRebuild to 1 if a package should be rebuild after clean,
 * otherwise set to 0
 */
fRebuild = 1;

/* set fMakeClean to 1 if using make for clean,
 * or set to 0 if doing clean manually
 */
fMakeClean = 1;

/* set fInstall to 1 if binaries should be installed, otherwise set to 0 */
fInstall = 1;

/* set fDist to 1 if dist-zip is supported, otherwise set to 0 */
fDist = 1;

/***** end of configuration block *****/

/* get a version and a base name of package */
'cd' sDir;
sVer = getOutput('git describe --abbrev=0');
sPackageBase = delstr( sDir, pos('-os2.git', sDir ));
'cd ..';

/* get a package name */
sPackage = sPackageBase || '-' || sVer;
sPackageZip = sPackage || '.zip';
sPackageSrcZip = sPackage || sRev || '-src.zip';
sDestDir = '\' || sPackage;

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
            call findRm '"*.o"',
                        '"*.lo"',
                        '"*.a"',
                        '"*.dll"',
                        '"*.la"',
                        '"*.exe"';
        end
    end
end
else
    'cd' sDir;

if fInstall then
do
    /* install binaries */
    'gmake install DESTDIR=' || translate( sDestDir, '/', '\');
end
else
do
    /* create a dir for packaging */
    'md' sDestDir;
end

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
    'if exist gmake.cmd zip' sPackageZip 'gmake.cmd';

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
    call findRm 'med.lru',
                'gmake.log',
                '"*~"',
                '"*.bak"',
                'autom4te.cache',
                '.gitattributes',
                '.gitignore',
                '.git',
                'patches';

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

/* copy hobbes upload template to a dest dir */
'copy' sPackage || sRev || '.txt' sDestDir;

/* copy a source zip file to a dest dir */
'move' sPackageSrcZip sDestDir;

/* copy additional files to a dest dir */
'copy donation.txt' sDestDir;
'move os2.diff' sDestDir;
'if exist readme.txt copy readme.txt' sDestDir;

/* create a package */
'zip -rpSm' sPackage || sRev || '.zip' sDestDir;

call endlocal;

exit 0;

findRm: procedure
    /* a file list is separated by a space */
    parse arg sFileList;

    /* max characters for arguments */
    nMaxChars = 16384;

    sCmd = 'find .';

    do while length( sFileList ) > 0
        parse value sFileList with sFile sFileList;

        sCmd = sCmd '-name' sFile;

        if length( sFileList ) > 0 then
            sCmd = sCmd '-o';
    end

    sCmd '| xargs -s' nMaxChars 'rm -rf';

    return;

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
