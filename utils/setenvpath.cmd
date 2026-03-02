/* setenvpath.cmd */

call rxfuncadd 'SysQueryExtLibPath', 'RexxUtil', 'SysQueryExtLibPath'
call rxfuncadd 'SysSetExtLibPath', 'RexxUtil', 'SysSetExtLibPath'

/* constants for modes */
MODE.Append = 0
MODE.Prepend = 1
MODE.Set = 2

/* default value */
sPathSep = ';'
sDirSep = '\'
nMode = MODE.Append

parse arg sArgs

do i = 1 to words( sArgs )
    sArg = word( sArgs, i )
    select
        when ( sArg == '-f') | ( sArg == '-fslash')  then
            sDirSep = '/'
        when ( sArg == '-p') | ( sArg == '-prepend') then
            nMode = MODE.Prepend
        when ( sArg == '-s') | ( sArg == '-set' ) then
            nMode = MODE.Set
    otherwise
        leave
    end
end

sEnvName = word( sArgs, i )
sPath = word( sArgs, i + 1 )

if sEnvName == '' then
   exit usage()

sPath = getabspath( sPath )
if sDirSep \== '\' then
    sPath = translate( sPath, sDirSep, '\')

sEnvVal = getenvval( sEnvName )
if nMode == MODE.Prepend then
    sEnvVal = sPath || sPathSep || sEnvVal
else if nMode == MODE.Append then
    sEnvVal = sEnvVal || sPathSep || sPath
else
    sEnvVal = sPath
sEnvVal = strip( sEnvVal,, sPathSep )

call setenvval sEnvName, sEnvVal
exit 0

usage: procedure
    say "Usage: setenvpath.cmd [-f[slash]] [-p[repend]] -[s[et]] ENV_NAME [PATH]"
    say "    -f[slash] : use '/' as a directory separator"
    say "    -p[repend] : prepend PATH to ENV_NAME"
    say "    -s[et] : set ENV_NAME to PATH"
    say "    PATH : PATH to add to ENV_NAME"
    say "    default: use '\' as directory separator and append CWD to ENV_NAME"
    return 1

getabspath: procedure
    parse arg sPath

    sCurDir = directory()

    if left( sPath, 1 ) == '\' then
    do
        /* A root path */
        sPath = left( sCurDir, 2 ) || sPath
    end
    else if ( substr( sPath, 2, 1 ) == ':') then
    do
        if substr( sPath, 3, 1 ) == '\' then
        do
            /* An absolute path */
            nop
        end
        else
        do
            /* A drive-relative path */
            sPath = concatpath( directory( left( sPath, 2 )), substr( sPath, 3 ))
            /* Restore CWD */
            call directory sCurDir
        end
    end
    else
    do
        /* Relative path */
        sPath = concatpath( sCurDir, sPath )
    end

    /* Remove '.' and '..' */
    i = 0
    do while sPath \== ''
        parse var sPath sComp '\' sPath

        if sComp == '.' then
            nop
        else if sComp == '..' then
        do
            /* Ignore 'x:\..' case */
            if i > 1 then
                i = i - 1
        end
        else
        do
            i = i + 1
            parts.i = sComp
        end
    end
    parts.0 = i

    sPath = parts.1
    do i = 2 to parts.0
        sPath = concatpath( sPath, parts.i )
    end
    if length( sPath ) < 3 then
    do
        /* 'x:' case */
        sPath = sPath || '\'
    end

    return sPath

concatpath: procedure
    parse arg sDir, sName, sDirSep

    if sDir == '' then
        sDir = '.'

    if sDirSep == '' then
        sDirSep = '\'

    return strip( sDir, 'T', sDirSep ) || sDirSep ||,
           strip( sName, 'L', sDirSep )

getenvval: procedure
    parse arg sEnvName

    sEnvName = translate( sEnvName )

    if ( sEnvName == 'BEGINLIBPATH') | ( sEnvName == 'ENDLIBPATH')  then
       return sysqueryextlibpath( left( sEnvName, 1 ))

    return value( sEnvName,, 'OS2ENVIRONMENT')

setenvval: procedure
    parse arg sEnvName, sEnvVal

    sEnvName = translate( sEnvName )

    if ( sEnvName == 'BEGINLIBPATH') | ( sEnvName == 'ENDLIBPATH') then
        return syssetextlibpath( sEnvVal, left( sEnvName, 1 ))

    return value( sEnvName, sEnvVal, 'OS2ENVIRONMENT')
