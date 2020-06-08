#!/bin/sh

EXEC_SINGLE_TEST ()
{
  FILE=$1
  ../bin/singletest.pl \
    $FILE \
    '../src/parser/gen1/main/compiler/naic -i GRAMMAR -o ASM' \
    '../src/parser/gen1/main/assembler/naia -i ASM -o BYTECODE -l BYTECODE.labelmap' \
    '../src/parser/gen1/main/engine/naie -D -X -I -b BYTECODE -d INPUT -l BYTECODE.labelmap >/dev/null' \
    '../src/parser/gen1/main/engine/naie -D -X -I -r -b BYTECODE -d INPUT -l BYTECODE.labelmap >/dev/null'
}

EXEC_MULTI_TEST ()
{
  FILE=$1
  ../bin/multitest.pl \
    $FILE \
    '../src/parser/gen1/main/compiler/naic -i GRAMMAR -o ASM' \
    '../src/parser/gen1/main/assembler/naia -i ASM -o BYTECODE' \
    '../src/parser/gen1/main/engine/naie -D -X -I -b BYTECODE -d INPUT >/dev/null'
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
