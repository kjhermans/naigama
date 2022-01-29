#!/bin/sh

TESTFILES=`ls ../../../t/multi_*.tst`

for TESTFILE in $TESTFILES; do
  perl ../../../bin/multitest.pl \
    $TESTFILE \
    "../src/jnaic -D -i GRAMMAR -o ASM" \
    "../src/jnaia -D -i ASM -o BYTECODE" \
    "../src/jnaie -D -c BYTECODE -i INPUT -D"
done
