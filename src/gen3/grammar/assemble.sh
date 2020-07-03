#!/bin/sh

ASM=$1
BYC=$2

echo "Assembling $ASM to $BYC"
if $BUILDROOT/src/gen2/main/assembler/naia \
  -i $ASM -o $BYC -l $BYC.labelmap 2>/tmp/$ASM.assemble.log; then
  echo "done"
else
  echo "error"
  exit -1
fi

