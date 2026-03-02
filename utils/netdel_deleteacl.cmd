/* backend for netdel.cmd */
parse arg sParam

address cmd '@echo off'

do while DeleteACL( sParam ) = 1
end

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
