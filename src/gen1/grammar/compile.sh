#!/bin/sh

NAIG=$1
ASM=$2
SLOTMAP=$3

perl $BUILDROOT/src/gen0/compiler.pl -i $NAIG -o $ASM -s $SLOTMAP

echo "done"
