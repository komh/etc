/* cp437.cmd */

Parse Arg argall

rqNew = RxQueue('Create')
rqOld = RxQueue('Set', rqNew );

Address CMD 'chcp | rxqueue' rqNew

Parse Pull sLine
Parse Value Space(sLine) With ': ' cpActive
cpActive = Strip(cpActive)

Parse Pull sLine
Parse Value Space(sLine) With ': ' cpPrimary ' ' cpSecondary
cpPrimary = Strip(cpPrimary,, ',')
cpSecondary = Strip(cpSecondary)

Call RxQueue 'Delete', rqNew
Call RxQueue 'Set', rqOld

fRestoreCP = 0

if cpActive = 949 then
do
    fRestoreCP = 1

    if cpPrimary \= 949 then
        cpWant = cpPrimary
    else
        cpWant = cpSecondary

    Address CMD 'chcp' cpWant
end

Address CMD 'start /N /F ' argall

if fRestoreCP then
    Address CMD 'chcp 949'
