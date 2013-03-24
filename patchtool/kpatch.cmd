/* kpatch.cmd */
parse arg sDiffFileName sOpts;

if sDiffFileName = '' then
do
    say 'Usage: kpatch patch-file [options]';
    exit;
end

/* open diffFile and reset to first line */
call linein sDiffFileName, 1, 0;

do while lines( sDiffFileName ) = 1
    sLine = linein( sDiffFileName,, 1 );
    if substr( sLine, 1, 4 ) = '--- ' then
    do
        sLine = linein( sDiffFileName,, 1 );
        if substr( sLine, 1, 4 ) = '+++ ' then
        do
            parse value sLine with '+++ ' sDestFileName '	';
            sDestFileName = translate( sDestFileName, '\', '/');
            if stream( sDestFileName, 'c', 'query exists' ) = '' then
                address cmd '@copy nul' sDestFileName;

            address cmd '@copy ' sDestFileName ' ' sDestFileName || '.org';
        end
    end
end

/* close sDiffFileName */
call lineout sDiffFileName;

address cmd '@gpatch -p0 -i' sDiffFileName sOpts;
