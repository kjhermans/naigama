#!/bin/sh

ASM=$1
BYC=$2

NAIA=`which naia`

echo -n "Assembling $ASM to $BYC .. "

if [ "x" != "x$NAIA" ]; then
  naia -i $ASM -o $BYC -l $BYC.labelmap 2>/tmp/$ASM.assemble.log
else
  perl -I ../aux/lib ../aux/main/ipeg_assemble $ASM $BYC
fi

echo "done"
