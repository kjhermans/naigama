#!/bin/sh

NAIG=$1
ASM=$2
SLOTMAP=$3

NAIC=`which naic`

echo -n "Compiling $NAIG to $ASM .. "

if [ "x" != "x$NAIC" ]; then
  naic -i $NAIG -o $ASM -m $SLOTMAP 2>/tmp/$NAIG.compile.log
else
  perl -I ../aux/lib ../aux/main/ipeg_compile -s $NAIG $ASM
fi

echo "done"
