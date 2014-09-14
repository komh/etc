/* git import wrapper */
parse arg '"' sImportMsg '"' sGitIgnore

sImportMsg = strip(sImportMsg)
sGitIgnore = strip(sGitIgnore)

if sImportMsg = '' then
do
    say 'Specify a commit message for a import'
    exit 1
end

if sGitIgnore = '' then
do
    sCurDir = directory()

    iPos = lastpos('-', sCurDir)
    if iPos > 0 then
    do
        sGitIgnore = substr(sCurDir, 1, iPos - 1) || '.git\.gitignore'
        if stream(sGitIgnore, 'c', 'query exists') = '' then
            sGitIgnore = 'g:\myetc\.gitignore'
    end
end

'copy' sGitIgnore .

'git init .'
'git add .'
'git ci -m ' '"' || sImportMsg || '"'
'git tag origin head'

exit 0
