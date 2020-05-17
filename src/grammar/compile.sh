#!/bin/sh

NAIG=$1
ASM=$2
SLOTMAP=$3

NAIC=`which naic`

echo -n "Compiling $NAIG to $ASM .. "

if [ "x" != "x$NAIC" ]; then
  naic -i $NAIG -o $ASM -m $SLOTMAP 2>/tmp/$NAIG.compile.log
else
  perl ../aux/bin/compiler.pl -i $NAIG -o $ASM -s $SLOTMAP
fi

echo "done"
