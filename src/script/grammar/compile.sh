#!/bin/sh

NAIG=$1
ASM=$2
SLOTMAP=$3

NAIC=`which naic`
if [ "x" = "x$NAIC" ]; then
  if [ -f ../../parser/gen2/main/compiler/naic ]; then
    NAIC='../../parser/gen2/main/compiler/naic'
  elif [ -f ../../parser/gen1/main/compiler/naic ]; then
    NAIC='../../parser/gen1/main/compiler/naic'
  fi
fi

echo -n "Compiling $NAIG to $ASM .. "

if [ "x" != "x$NAIC" ]; then
  $NAIC -i $NAIG -o $ASM -m $SLOTMAP 2>/tmp/$NAIG.compile.log
else
  if [ "$NAIG" != "optimizer.naig" ]; then
    perl ../../parser/gen0/compiler.pl -i $NAIG -o $ASM -s $SLOTMAP
  fi
fi

echo "done"
