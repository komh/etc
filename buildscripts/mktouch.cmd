if exist aclocal.m4 touch aclocal.m4
if exist Makefile.in touch Makefile.in
if exist configure touch configure
if exist config.status touch config.status
if exist Makefile call gmake.cmd -t
