/* omflibs.cmd -- Create .lib files from .a files
   Copyright (c) 1994-1998 Eberhard Mattes

This file is part of emx.

emx is free software; you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2, or (at your option)
any later version.

emx is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with emx; see the file COPYING.  If not, write to
the Free Software Foundation, 59 Temple Place - Suite 330,
Boston, MA 02111-1307, USA.  */


call RxFuncAdd 'SysLoadFuncs', 'RexxUtil', 'SysLoadFuncs'
call SysLoadFuncs

call SysFileTree '*.a', 'files', 'FSO'
do i = 1 to files.0
   call check(left(files.i, length(files.i)-2))
end
exit


/* Build NAME.lib if NAME.lib does not exist or NAME.a is newer than
   NAME.lib. */

check: procedure
parse arg name
emxomf = '@f:\lang\gcc\usr\bin\emxomf.exe -s -l -q -p 256'
touch = '@f:\usr\bin\touch.exe -r'
src = name||'.a'
dst = name||'.lib'
s = stream(src, 'C', 'QUERY DATETIME')
if s \== '' then do
  d = stream(dst, 'C', 'QUERY DATETIME')
  if d == '' then do
    say 'Building '||dst
    emxomf src
    if rc = 0 then touch src dst
  end
  else if cdate(s) > cdate(d) then do
    say 'Updating '||dst
    emxomf src
    if rc = 0 then touch src dst
  end
end
return


/* Build a string suitable for comparing from a date/time string
   returned by stream(STREAM, 'C' , 'QUERY DATETIME). */

cdate: procedure
parse arg month'-'day'-'year hour':'min':'sec
if year < 50 then year = year + 2000
else year = year + 1900
return year||month||day||hour||min||sec
