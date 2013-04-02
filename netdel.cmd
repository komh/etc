/* delete ACLs from NET database */
parse arg sResource

if sResource \= '' then
    sResource = sResource '/tree'

address cmd '@echo off'

address cmd 'set 4os2test_env=%@eval[ 2 + 2 ]'

if value('4os2test_env',, 'OS2ENVIRONMENT') = 4 then
    address cmd 'setdos /X-12345678'

do while DeleteACL( sResource )
end

if value('4os2test_env',, 'OS2ENVIRONMENT') = 4 then
    address cmd 'setdos /X0'

exit

DeleteACL: procedure
    parse arg sAccessParam

    rqNew = rxqueue('Create')
    rqOld = rxqueue('Set', rqNew )

    address cmd 'net access' sAccessParam '| rxqueue' rqNew

    iRet = 0

    iLineCount = 0


    do while queued() > 0
        parse pull sLine
        if ( iLineCount = 2 ) & ( substr( sLine, 2, 1 ) = ':') then
        do
            sLine = strip( sLine )
            say 'Delete' '[' || sLine || ']'

            /* to prevent from escaping \" */
            if right( sLine, 1 ) = '\' then
                sLine = sLine || '\'

            address cmd 'net access' '"' || sLine || '"' '/delete'

            iRet = 1
        end

        if iLineCount = 2 then
            iLineCount = 0
        else
            iLineCount = iLineCount + 1
    end

    call rxqueue 'Delete', rqNew
    call rxqueue 'Set', rqOld

    return iRet
