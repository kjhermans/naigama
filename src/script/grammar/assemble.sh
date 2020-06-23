#!/bin/sh

ASM=$1
BYC=$2

NAIA=`which naia`

echo -n "Assembling $ASM to $BYC .. "
if [ "x" = "x$NAIA" ]; then
  if [ -f ../../parser/gen2/main/assembler/naia ]; then
    NAIA='../../parser/gen2/main/assembler/naia'
  elif [ -f ../../parser/gen1/main/assembler/naia ]; then
    NAIA='../../parser/gen1/main/assembler/naia'
  fi
fi

if [ "x" != "x$NAIA" ]; then
  $NAIA -i $ASM -o $BYC -l $BYC.labelmap 2>/tmp/$ASM.assemble.log
else
  if [ "$ASM" != "optimizer.asm" ]; then
    perl ../../parser/gen0/assembler.pl -i $ASM -o $BYC -I ../instructions.pl \
      -l $BYC.labelmap
  fi
fi

echo "done"
