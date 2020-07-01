#!/bin/sh

ASM=$1
BYC=$2

perl $BUILDROOT/src/gen0/assembler.pl -i $ASM -o $BYC \
  -I $BUILDROOT/src/instructions.pl \
  -l $BYC.labelmap

echo "done"
