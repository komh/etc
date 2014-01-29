/* backup.cmd : backup using rsync */

call RxFuncAdd 'SysLoadFuncs', 'RexxUtil', 'SysLoadFuncs'
call SysLoadFuncs

parse arg sFrom sTo sOptions

if sFrom = '' | sTo = '' then
do
    say 'Usage: backup source destination [options]'
    exit 1
end

sOptions = '-avz --dirs --no-recursive --delete --progress --xattrs',
           '--os2-perms --log-file=backup.log' sOptions

sFrom = translate(sFrom, '/', '\')

/*
   exclude the case specifying only a moudle name
   for examples, host::modulename
   any other cases, append '/'
*/

if (pos('/', sFrom) > 0) & (right( sFrom, 1 ) \= '/') then
    sFrom = sFrom || '/'

sTo = translate( sTo, '/', '\' )

if right( sTo, 1 ) \= '/' then
    sTo = sTo || '/'

sStartDate = date()
sStartTime = time()

call writeBackupList '----- Started:' sStartDate sStartTime

call time 'R'

call backup sFrom, sTo

sElapsedTime = time('E')

sFinishDate = date()
sFinishTime = time()

call writeBackupList '----- Finished:' sFinishDate sFinishTime

say 'Started:' sStartDate sStartTime
say 'Finished:' sFinishDate sFinishTime
say 'Elapsed time:' sElapsedTime '(s)'

exit 0

backup: procedure expose sOptions
    parse arg sFrom, sTo

    say 'backing up' sFrom

    address cmd 'rsync.exe' sOptions sFrom sTo
    say

    if rc \= 0 then
        return 1

    call writeBackupList sFrom

    if right( sFrom, 1 ) \= '/' then
        sFrom = sFrom || '/'

    sToBack = translate( sTo, '\', '/' )

    call SysFileTree sToBack || '*', stDirs, 'OD'

    do i = 1 to stDirs.0
        sDirName = substr( stDirs.i, lastpos( '\', stDirs.i ) + 1 ) || '/'

        if backup( sFrom || sDirName, sTo || sDirName ) \= 0 then
            return 1
    end

    /* to save a stack */

    drop sFrom
    drop sTo
    drop sToBack
    drop i
    drop stDirs.
    drop sDirName

    return 0

writeBackupList: procedure
    parse arg sMessage

    'echo' sMessage '>> backup.lst'

    return
