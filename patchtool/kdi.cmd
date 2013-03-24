/* kdi.cmd */
CALL RxFuncAdd 'SysLoadFuncs', 'RexxUtil', 'SysLoadFuncs'
CALL SysLoadFuncs

PARSE ARG argall

CALL SysFileTree '*.org', 'file', 'SO'

curdir = DIRECTORY()

DO i = 1 TO file.0
	orgfile = TRANSLATE( SUBSTR( file.i, LENGTH( curdir ) + 1 ), '/', '\')
	if SUBSTR( orgfile, 1, 1 ) = '/' then
		orgfile = SUBSTR( orgfile, 2 )
	myfile = SUBSTR( orgfile, 1, LASTPOS('.org', orgfile ) - 1 );
    /*diffcmd = 'diff -EbwuNr --strip-trailing-cr ' || orgfile || ' ' || myfile*/
    diffcmd = 'diff -uNr ' || argall || ' ' || orgfile || ' ' || myfile
	SAY diffcmd
	diffcmd
END

