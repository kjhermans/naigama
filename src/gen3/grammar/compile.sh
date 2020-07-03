#!/bin/sh

NAIG=$1
ASM=$2
SLOTMAP=$3

echo "Compiling $NAIG to $ASM"
$BUILDROOT/src/gen2/main/compiler/naic \
  -i $NAIG -o $ASM -m $SLOTMAP 2>/tmp/$NAIG.compile.log

echo "done"
