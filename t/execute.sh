#!/bin/sh

EXEC_SINGLE_TEST ()
{
  FILE=$1
  ../bin/singletest.pl \
    $FILE \
    '../src/main/compiler/naic -i GRAMMAR -o ASM' \
    '../src/main/assembler/naia -i ASM -o BYTECODE -l BYTECODE.labelmap' \
    '../src/main/engine/naie -D -X -I -b BYTECODE -d INPUT -l BYTECODE.labelmap >/dev/null' \
    '../src/main/engine/naie -D -X -I -r -b BYTECODE -d INPUT -l BYTECODE.labelmap >/dev/null'
}

EXEC_MULTI_TEST ()
{
  FILE=$1
  ../bin/multitest.pl \
    $FILE \
    '../src/main/compiler/naic -i GRAMMAR -o ASM' \
    '../src/main/assembler/naia -i ASM -o BYTECODE' \
    '../src/main/engine/naie -D -X -I -b BYTECODE -d INPUT >/dev/null'
}

if [ "x$SINGLETEST" != "x" ]; then
  EXEC_SINGLE_TEST $SINGLETEST
elif [ "x$MULTITEST" != "x" ]; then
  EXEC_MULTI_TEST $MULITEST
else
  
  echo "Multi tests"
  FILES=`ls multi_*.tst`
  for FILE in $FILES; do
    EXEC_MULTI_TEST $FILE
  done
  
  echo "Single tests"
  FILES=`ls single_*.tst`
  for FILE in $FILES; do
    EXEC_SINGLE_TEST $FILE
  done
  
fi
