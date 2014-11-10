extproc sh

aclocal                              \
  && libtoolize -f                   \
  && autoheader                      \
  && autoconf                        \
  && automake -a                     \
  && echo autogen succeeded.         \
  || echo autogen failed.
