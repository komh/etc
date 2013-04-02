/* delete ACLs from NET database */
parse arg sResource

if sResource \= '' then
    sResource = sResource '/tree'

address cmd '@echo off'

address cmd 'cmd /c netdel_deleteacl.cmd' sResource

exit
