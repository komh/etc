/* makedesc.cmd: print a description string for BLDLEVEL to stdout
 * Based on makedesc.cmd of Project Odin
 *
 * Fills in default values; like build time and host.
 *
 */

call RxFuncAdd 'SysLoadFuncs', 'RexxUtil', 'SysLoadFuncs';
call SysLoadFuncs;

/*
 * Set default parameter values.
 */
sASDFeatureId   = '';
sCountryCode    = '';
sDateTime       = left(' 'date()' 'time(), 26);
sDescription    = '';
sFixPakVer      = '';
sHostname       = strip(substr(VALUE('HOSTNAME',,'OS2ENVIRONMENT'), 1, 11));
sLanguageCode   = '';
sMiniVer        = '';
sVendor         = '';
sVersion        = '';


/*
 * Parse parameters.
 */
parse arg  sArgs

do while (sArgs <> '')
    sArgs = strip(sArgs);
    if (substr(sArgs, 1, 1) = '-' | substr(sArgs, 1, 1) = '/') then
    do  /*
         * Option.
         */
        ch = translate(substr(sArgs, 2, 1));
        if (pos(ch, 'ACDHLMNPRTV') < 1) then
        do
            say 'invalid option:' substr(sArgs, 1, 2);
            call syntax;
            exit(2);
        end

        /* get value and advance sArgs to next or to end. */
        if (substr(sArgs, 3, 1) = '"') then
        do
            iNext = pos('"', sArgs, 4);
            fQuote = 1;
        end
        else
        do
            iNext = pos(' ', sArgs, 3);
            if (iNext <= 0) then
                iNext = length(sArgs) + 1;
            fQuote = 0;
        end

        if (iNext > 3 | ch = 'R') then
        do
            sValue = substr(sArgs, 3 + fQuote, iNext - 3 - fQuote);
            sArgs = strip(substr(sArgs, iNext+1));
            /*say 'iNext:' iNext  'sValue:' sValue  'sArgs:' sArgs; */

            /* check if we're gonna search for something in an file. */
            if (sValue <> '' & pos('#define=', sValue) > 0) then
                sValue = LookupDefine(sValue);
        end
        else
        do
            say 'syntax error near' substr(sArgs, 1, 2)'.';
            call syntax;
            exit(3);
        end


        /* set value */
        select
            when (ch = 'A') then /* ASD Feature Id */
                sASDFeatureId   = sValue;

            when (ch = 'C') then /* Country code */
                sCountryCode    = sValue;

            when (ch = 'D') then /* Description */
                sDescription    = sValue;

            when (ch = 'H') then /* Hostname */
                sHostname       = sValue;

            when (ch = 'L') then /* Language code */
                sLanguageCode   = sValue;

            when (ch = 'M') then /* MiniVer */
                sMiniVer        = sValue;

            when (ch = 'N') then /* Vendor */
                sVendor         = sValue;

            when (ch = 'R') then /* Vendor */
                sDescription    = ReadDescription(sValue, sDefFile);

            when (ch = 'P') then /* Fixpak version */
                sFixPakVer      = sValue;

            when (ch = 'T') then /* Date Time */
                sDateTime       = sValue;

            when (ch = 'V') then /* Version */
                sVersion        = sValue;

            /* Otherwise it's an illegal option */
            otherwise:
                say 'invalid option:' substr(sArgs, 1, 2);
                call syntax;
                exit(2);
        end /* select */
    end
    else
    do  /*
         * Defition file...
         */
        say 'invalid option:' substr(sArgs, 1, 2);
        call syntax;
        exit(2);
    end
end


/* check that a description was specified. */
if (sDescription = '') then
do
  say 'Syntax error: Will have to specify a description.';
  call syntax;
  exit(5);
end


/*
 * Trim strings to correct lengths.
 */
sVendor         = strip(substr(sVendor, 1, 31));
if (substr(sDateTime, 1, 1) <> ' ') then
    sDateTime = ' ' || sDateTime;
sDateTime       = left(sDateTime, 26);
sHostname       = strip(substr(sHostname, 1, 11));
sMiniVer        = strip(substr(sMiniVer, 1, 11));
sDescription    = strip(substr(sDescription, 1, 80));
sCountryCode    = strip(substr(sCountryCode, 1, 4));
sLanguageCode   = strip(substr(sLanguageCode, 1, 4));
sASDFeatureId   = strip(substr(sASDFeatureId, 1, 11));
sFixPakVer      = strip(substr(sFixPakVer, 1, 11));


/*
 * Signature
 */
sEnhSign = '##1##'

/*
 * Build description string.
 */
sDescription =  '@#'sVendor':'sVersion'#@'sEnhSign||,
                sDateTime||sHostname||,
                ':'sASDFeatureId':'sLanguageCode':'sCountryCode':'sMiniVer||,
                '::'sFixPakVer'@@'sDescription;

/*
 * Write description string.
 */
say sDescription;
exit(0);


/**
 * Display script syntax.
 */
syntax: procedure
    say 'Syntax: MakeDesc.cmd [options] [options]'
    say 'Options:'
    say '   -A<string>  ASD Feature Id.'
    say '   -C<string>  Country code.'
    say '   -D<string>  Description.'
    say '   -R[deffile] Read description from .def file.'
    say '   -H<string>  Hostname.'
    say '   -L<string>  Language code.'
    say '   -M<string>  MiniVer.'
    say '   -N<string>  Vendor.'
    say '   -P<string>  Fixpak version.'
    say '   -T<string>  Date Time.'
    say '   -V<string>  Version.'
    say '<string> could be a double qoute qouted string or a single word.'
    say '       You could also reference #defines in C/C++ include files.'
    say '       The string should then have this form:'
    say '           "#define=<DEFINE_NAME>,<includefile.h>"'
    say '';

    return;


/**
 * Search for a #define in an C/C++ header or source file.
 *
 * @returns String containing the defined value
 *          found for the define in the header file.
 *          Quits on fatal errors.
 * @param   A string on the form: "#define=DEFINETOFIND,includefile.h"
 * @remark  Write only code... - let's hope it works.
 */
LookupDefine: procedure
    parse arg '#'sDefine'='sMacro','sIncludeFile

    /*
     * Validate parameters.
     */
    sMacro = strip(sMacro);
    sIncludeFile = strip(sIncludeFile);
    if (sMacro = '') then
    do
        say 'syntax error: #define=<DEFINE_NAME>,<includefile.h>.';
        say '    <DEFINE_NAME> was empty.';
        exit(-20);
    end
    if (sIncludeFile = '') then
    do
        say 'syntax error: #define=<DEFINE_NAME>,<includefile.h>.';
        say '    <includefile.h> was empty.';
        exit(-20);
    end


    sIllegal = translate(translate(sMacro),,
                         '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!',,
                         'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_');

    if (strip(translate(sIllegal, ' ', '!')) <> '') then
    do
        say 'syntax error: #define=<DEFINE_NAME>,<includefile.h>.';
        say '    <DEFINE_NAME> contains illegal charater(s).'
        say '        'sMacro;
        say '        'translate(sIllegal, ' ', '!');
        exit(-20);
    end

    /*
     * Open include file.
     */
    sRc = stream(sIncludeFile, 'c', 'open read');
    if (pos('READY', sRc) <> 1) then
    do  /* search INCLUDE variable */
        sFile = SysSearchPath('INCLUDE', sIncludeFile);
        if (sFile = '') then
        do
            say 'Can''t find include file 'sIncludeFile'.';
            exit(-20);
        end
        sIncludeFile = sFile;

        sRc = stream(sIncludeFile, 'c', 'open read');
        if (pos('READY', sRc) <> 1) then
        do
            say 'Failed to open include file' sIncludeFile'.';
            exit(-20);
        end
    end

    /*
     * Search the file line by line.
     *  We'll check for lines starting with a hash (#) char.
     *  Then check that the word after the hash is 'define'.
     *  Then match the next word with the macro name.
     *  Then then get the next rest of the line to comment or continuation char.
     *      (continuation is not supported)
     *  Finally strip quotes.
     */
    sValue = '';
    do while (lines(sIncludeFile) > 0)
        sLine = strip(linein(sIncludeFile));
        if (sLine = '') then
            iterate;
        if (substr(sLine, 1, 1) <> '#') then
            iterate;
        sLine = substr(sLine, 2);
        if (word(sLine, 1) <> 'define') then
            iterate;
        sLine = strip(substr(sLine, wordpos(sLine, 1) + length('define')+1));
        if (  substr(sLine, 1, length(sMacro)) <> sMacro,
            | substr(sLine, length(sMacro)+1, 1) <> ' ') then
            iterate;
        sLine = strip(substr(sLine, length(sMacro) + 1));
        if (sLine = '') then
        do
            say 'error: #define' sMacro' is empty.';
            call stream sIncludeFile, 'c', 'close';
            exit(-20);
        end

        chQuote = substr(sLine, 1, 1);
        if (chQuote = '"' | chQuote = "'") then
        do  /* quoted string */
            iLastQuote = 0;
            do forever
                iLast = pos(chQuote, sLine, 2);
                if (iLast <= 0) then
                    leave;
                if (substr(sLine, iLast, 1) = '\') then
                    iterate;
                iLastQuote = iLast;
                leave;
            end

            if (iLastQuote <= 0) then
            do
                say 'C/C++ syntax error in 'sIncludefile': didn''t find end quote.';
                call stream sIncludeFile, 'c', 'close';
                exit(-20);
            end

            call stream sIncludeFile, 'c', 'close';
            sValue = substr(sLine, 2, iLastQuote - 2);
            say 'Found 'sMacro'='sValue;
            return sValue;
        end
        else
        do
            iCommentCPP = pos('//',sLine);
            iCommentC   = pos('/*',sLine);
            if (iCommentC > 0 & iCommentCPP > 0 & iCommentC > iCommentCPP) then
                iComment = iCommentCPP;
            else if (iCommentC > 0 & iCommentCPP > 0 & iCommentC < iCommentCPP) then
                iComment = iCommentC;
            else if (iCommentCPP > 0) then
                iComment = iCommentCPP;
            else if (iCommentC > 0) then
                iComment = iCommentC;
            else
                iComment = 0;

            if (iComment > 0) then
                sValue = strip(substr(sLine, 1, iComment-1));
            else
                sValue = strip(sLine);

            if (sValue <> '') then
            do
                if (substr(sValue, length(sValue)) = '\') then
                do
                    say 'Found continuation char: Multiline definitions are not supported!\n';
                    call stream sIncludeFile, 'c', 'close';
                    exit(-20);
                end
            end

            if (sValue = '') then
                say 'warning: The #define has no value.';

            call stream sIncludeFile, 'c', 'close';
            say 'Found 'sMacro'='sValue;
            return sValue;
        end
    end

    call stream sIncludeFile, 'c', 'close';
    say 'error: didn''t find #define' sMacro'.';
    exit(-20);



/**
 * Reads the description line for a .def-file.
 * @returns The Description string, with quotes removed.
 *          Empty string is acceptable.
 *          On error we'll terminate the script.
 * @param   sDefFile    Filaname of .def-file to read the description from.
 * @param   sDefFile2   Used if sDefFile is empty.
 * @author  knut st. osmundsen (knut.stange.osmundsen@mynd.no)
 */
ReadDescription: procedure;
    parse arg sDefFile, sDefFile2

    /*
     * Validate parameters.
     */
    if (sDefFile = '') then
        sDefFile = sDefFile2;
    if (sDefFile = '') then
    do
        say 'error: no definition file to get description from.'
        exit(-1);
    end

    /*
     * Open file
     */
    rc = stream(sDefFile, 'c', 'open read');
    if (pos('READY', rc) <> 1) then
    do
        say 'error: failed to open deffile file.';
        exit(-1);
    end


    /*
     * Search for the 'DESCRIPTION' line.
     */
    do while (lines(sDefFile) > 0)
        sLine = strip(linein(sDefFile));
        if (sLine = '') then
            iterate;
        if (translate(word(sLine, 1)) <> 'DESCRIPTION') then
            iterate;
        sLine = strip(substr(sLine, wordpos(sLine, 1) + length('DESCRIPTION')+1));

        ch = substr(sLine, 1, 1);
        if (ch <> "'" & ch <> '"') then
        do
            say 'syntax error: description line in' sDefFile 'is misformed.';
            call stream sDefFile, 'c', 'close';
            exit(-10);
        end

        iEnd = pos(ch, sLine, 2);
        if (iEnd <= 0) then
        do
            say 'syntax error: description line in' sDefFile 'is misformed.';
            call stream sDefFile, 'c', 'close';
            exit(-10);
        end

        call stream sDefFile, 'c', 'close';
        sValue = substr(sLine, 2, iEnd - 2);
        say 'Found Description:' sValue;
        return sValue;
    end

    call stream sDefFile, 'c', 'close';
    say 'info: Didn''t find description line in' sDefFile'.';
    return '';
