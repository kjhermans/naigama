#!/bin/sh

TESTFILES=`ls ../../../t/multi_*.tst`

for TESTFILE in $TESTFILES; do
  perl ../../../bin/multitest.pl \
    $TESTFILE \
    "../naigama/target/release/naic -i GRAMMAR -o ASM" \
    "../naigama/target/release/naia -i ASM -o BYTECODE" \
    "../naigama/target/release/naie -c BYTECODE -i INPUT -D"
done
