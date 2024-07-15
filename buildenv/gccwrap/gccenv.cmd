/* gccenv.cmd */
parse arg sUsrDir sToolId sOptExtra;

if sUsrDir = '' then sUsrDir = 'f:\lang\gcc\usr';
if sToolId = '' then sToolId = 'gcc910';

sEnvCmd = 'gcclocalrpmenv';
if sToolId = 'gcc335' then sEnvCmd = 'gccenv';
if sToolId = 'gcc910' then sEnvCmd = 'gcclocalenv';
if sToolId = 'gccrpm' then sEnvCmd = 'gccrpmenv';

call putEnv 'EMXOMFOPT', '-q';
call putEnv 'GCCOPT', strip('-pipe -s' sOptExtra );

'call' sUsrDir || '\bin\' || sEnvCmd || '.cmd' sUsrDir 'WLINK' sToolId;

call putEnv 'EMXOMFLD_RC_TYPE', 'WRC';
call putEnv 'EMXOMFLD_RC', 'wrc.exe';

call putEnvFront 'C_INCLUDE_PATH', '.;f:/usr/local/include;f:/usr/include;';
call putEnvFront 'CPLUS_INCLUDE_PATH', '.;f:/usr/local/include;f:/usr/include;';
call putEnvFront 'LIBRARY_PATH', 'f:/usr/local/lib;f:/usr/lib;f:/usr/dll;';

exit 0;

getEnv: procedure
    parse arg sName;

    return value( sName,, 'OS2ENVIRONMENT');

putEnv: procedure
    parse arg sName, sVal;

    call value sName, sVal, 'OS2ENVIRONMENT';

    return;

putEnvFront: procedure
    parse arg sName, sFrontVal;

    sVal = getEnv( sName );

    iPos = pos( sFrontVal, sVal );
    if iPos > 0 then
        sVal = delstr( sVal, iPos, length( sFrontVal ));
    sVal = sFrontVal || sVal;

    call putEnv sName, sVal;

    return;
