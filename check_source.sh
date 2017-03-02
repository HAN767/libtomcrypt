#!/bin/bash

# output version
bash printinfo.sh

make clean > /dev/null

if [ -f check-source.pl ] ; then
  echo "checking white spaces..."
  perl check-source.pl || exit 1
fi

if [ -f ./updatemakes.sh ] ; then
  echo "checking makefiles..."
  beforeupdate=$(grep '' makefile*)
  ./updatemakes.sh
  afterupdate=$(grep '' makefile*)
  if [ "$afterupdate" = "$beforeupdate" ] ; then
    echo "PASS"
  else
    echo "FAIL: makefiles not updated"
    exit 1
  fi
fi

exit 0

# $Source$
# $Revision$
# $Date$
