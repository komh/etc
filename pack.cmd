/* pack.cmd */
parse arg sDir;

if sDir = '' then
do
    say 'Usage: pack directory [revision]';

    exit 1;
end

call setlocal;

/***** start of configuration block *****/

/* specify revision */
sRev = '';

/* specify postfix. For example, '-klibc' for kLIBC */
sPostFix = '';

/* set fRebuild to 1 if a package should be rebuild after clean,
 * otherwise set to 0
 */
fRebuild = 1;

/* specify options passed to configure.cmd */
sConfigureOpts = '--prefix=/usr --enable-shared --enable-static';

/* set fMakeClean to 1 if using make for clean,
 * or set to 0 if doing clean manually
 */
fMakeClean = 1;

/* set fInstall to 1 if binaries should be installed, otherwise set to 0 */
fInstall = 1;

/* set fIncludeSource to 1 if source archive should be included, otherwise
 * set to 0
 */
fIncludeSource = 1;

/* set fDist to 1 if source archiving is supported, otherwise set to 0 */
fDist = 1;

/* specify commands passed to make to archive sources */
sDistCmds = 'dist-zip'

/* set fDistExtZip to 1 if an extension of the archived source is .zip */
fDistExtZip = 1;

/* specify an extension of non-zip source archive */
sDistNonZipExt = '.tar.gz';

/* specify commands to convert non-zip archive to zip archive */
sDistExtractCmds = 'tar xvzf';

/* set fDistUseGit to 1 if use git when fDist is 0 */
fDistUseGit = 1;

/* specify a .diff name */
sDiffName = 'os2.diff';

/* specify extra dist files separated by a space. A series of
 * 'DIST_FILE1' 'INSTALL_DIR1' 'DIST_FILE2' 'INSTALL_DIR2' ...
 * For example,
 *      'readme.os2' '/',
 *      'os2.cfg' '/usr/etc'
 */
sExtraDistFiles = '' '';

/***** end of configuration block *****/

'echo on';

/* get a version and a base name of package */
'cd' sDir;
sVer = getOutput('git describe --abbrev=0');
sPackageBase = delstr( sDir, pos('-os2.git', sDir ));
'cd ..';

/* get a package name */
sPackage = sPackageBase || '-' || sVer;
sPackageZip = sPackage || '.zip';
sPackageSrcZip = sPackage || sRev || sPostFix || '-src.zip';
sDestDir = '\' || sPackage;

if fRebuild | (fIncludeSource & \fDist & \fDistUseGit) then
do
    /* get a temporary directory name for packaging */
    sDirPackBase = sDir || '.pack';
    sDirPack = sDirPackBase;
    if fIncludeSource & \fDist & \fDistUseGit then
        sDirPack = sDirPack || '\' || sPackage;

    /* prepare a temporary directory for packaging */
    'md' sDirPackBase;
    'xcopy /s/e/v/h/t/r' sDir sDirPack || '\';
    'cd' sDirPack;

    if fRebuild then
    do
        /* create binary distribution */
        'call configure.cmd' sConfigureOpts;

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
    /* build */
    'gmake'

    /* install binaries */
    'gmake install DESTDIR=' || translate( sDestDir, '/', '\');
end
else
do
    /* create a dir for packaging */
    'md' sDestDir;
end

/* create source distribution */
if \fIncludeSource then
do
/* nothing to do */
end
else if fDist then
do
    /* rename .git directory
     * to prevent local changes from being written into ChangeLog
     */
    'if exist .git ren .git .git.sav';

    /* create a source archive */
    'gmake' sDistCmds;

    if \fDistExtZip then
    do
        sDistExtractCmds sPackage || sDistNonZipExt;
        'zip -rpS' sPackageZip sPackage;
        'rm -f' sPackage || sDistNonZipExt;
        'rm -rf' sPackage;
    end

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
else if fDistUseGit then
do
    'git archive --format=zip HEAD --prefix=' || sPackage || '/',
        '> ..\' || sPackageSrcZip;
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
if fRebuild | (fIncludeSource & \fDist & \fDistUseGit) then
    'rm -rf' sDirPackBase;

/* create diffs in a parent directory */
'cd' sDir;
'git diff' sVer 'HEAD > ..\' || sDiffName;
'cd ..';

/* prepare hobbes upload template */
'sed s/@VER@/' || sVer|| sRev || '/g' sPackageBase || '.txt >',
     sPackage || sRev || sPostFix || '.txt';

/* copy hobbes upload template to a dest dir */
'copy' sPackage || sRev || sPostFix || '.txt' sDestDir;

/* copy a source zip file to a dest dir */
if fIncludeSource then
    'move' sPackageSrcZip sDestDir;

/* copy additional files to a dest dir */
'copy donation.txt' sDestDir;
if stream(sDiffName, 'c', 'query size') > 0 then
    'move' sDiffName sDestDir;
'if exist' sDiffName 'del' sDiffName;
'if exist readme.txt copy readme.txt' sDestDir;

/* copy extra dist files */
sExtraDistFiles = translate( sExtraDistFiles, '\', '/');
do while strip( sExtraDistFiles ) \= ''
    parse value strip( sExtraDistFiles ) with sExtraSrc sExtraDestDir sExtraDistFiles;

    sExtraDestDir = sDestDir || sExtraDestDir;
    call makeDir sExtraDestDir;

    sExtraDestName = substr( sExtraSrc, lastpos('\', sExtraSrc ) + 1 );

    'copy' sExtraSrc sExtraDestDir || '\' || sExtraDestName;
end

/* create a package */
'zip -rpSm' sPackage || sRev || sPostFix || '.zip' sDestDir;

call endlocal;

exit 0;

makeDir: procedure
    parse arg sDirPath;

    p = 0;
    if left( sDirPath, 1 ) = '\' then
        p = 1;

    p = pos('\', sDirPath, p + 1 );
    do while p > 0
        sDir = substr( sDirPath, 1, p - 1 );
        'if not exist' sDir 'md' sDir;

        p = pos('\', sDirPath, p + 1 );
    end
    'if not exist' sDirPath 'md' sDirPath;

    return;

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
