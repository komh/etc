extproc sh

aclocal                              \
  && libtoolize -f                   \
  && autoheader                      \
  && autoconf                        \
  && automake -a    2>&1 | tee autogen.log

rc=${PIPESTATUS[0]}
test "$rc" = "0" && echo autogen succeeded. || echo autogen failed.
exit $rc
