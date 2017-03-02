#!/bin/bash

# output version
bash printinfo.sh

make clean > /dev/null

if [ -f check-source.pl ] ; then
  echo "checking white spaces..."
  perl check-source.pl || exit 1
fi

if [ -d .git ] ; then
  echo "checking makefiles..."
  ./updatemakes.sh
  outofdate="$(git diff --name-only HEAD)"
  if [ -n "$outofdate" ] ; then
    echo "FAIL: makefiles not updated"
    echo "$outofdate";
    exit 1
  else
     echo "PASS"
  fi
fi

exit 0

# $Source$
# $Revision$
# $Date$
