#!/bin/bash -u

if [ $# -lt 2 ]
then
  echo "$0 <source> <version>
Need at least two input arguments:
- the <source> can be CSR, GFZ or JPL
- the <version> can be (the 'RL' part is added internally), as of 11/2015:
  - CSR: 05, 05_mean_field, 06
  - GFZ: 05, 05_WEEKLY, 06
  - JPL: 05, 05.1, 06"
  exit 3
fi

#data characteristics
SOURCE=$1
VERSION=$2

if [ $# -lt 3 ]
then
  case $SOURCE in
  CSR)
    GLOB="GSM-2*_0060_*"
  ;;
  GFZ)
    GLOB="GSM-2*"
  ;;
  JPL)
    GLOB="GSM-2*"
  ;;
  *)
    echo "$0: ERROR: unknown source '$SOURCE'."
    exit 3
  esac
fi

LOCALDIR=$(cd $(dirname $BASH_SOURCE); pwd)/L2/$SOURCE/RL$VERSION/

#check if sink directory exists
if [ ! -d $LOCALDIR ]
then
  echo "ERROR: cannot find directory $LOCALDIR"
  exit 3
fi

for i in $(find $LOCALDIR -name \*.gz)
do
  if [ ! -e ${i%.gz}.gsm ]
  then
    gunzip -kfv $i && mv -v ${i%.gz} ${i%.gz}.gsm
  fi
done





