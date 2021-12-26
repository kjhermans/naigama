#!/bin/sh

TESTFILES=`ls ../../../t/multi_*.tst`

for TESTFILE in $TESTFILES; do
  perl ../../../bin/multitest.pl \
    $TESTFILE \
    "../src/jnaic -i GRAMMAR -o ASM" \
    "../src/jnaia -i ASM -o BYTECODE" \
    "../src/jnaie -c BYTECODE -i INPUT -D"
done
