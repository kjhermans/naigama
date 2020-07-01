#!/bin/sh

ASM=$1
BYC=$2

NAIA=`which naia`

echo -n "Assembling $ASM to $BYC .. "

if [ "x" != "x$NAIA" ]; then
  naia -i $ASM -o $BYC -l $BYC.labelmap 2>/tmp/$ASM.assemble.log
else
  if [ "$ASM" != "optimizer.asm" ]; then
    perl $BUILDROOT/src/gen0/assembler.pl -i $ASM -o $BYC \
      -I $BUILDROOT/src/instructions.pl \
      -l $BYC.labelmap
  fi
fi

echo "done"
