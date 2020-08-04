#!/bin/sh

EXEC_SINGLE_TEST ()
{
  FILE=$1
  $BUILDROOT/bin/singletest.pl \
    $FILE \
    "$BUILDROOT/src/gen3/main/compiler/naic -i GRAMMAR -o ASM" \
    "$BUILDROOT/src/gen3/main/assembler/naia -i ASM -o BYTECODE -l BYTECODE.labelmap" \
    "$BUILDROOT/src/gen3/main/engine/naie -v -x -I -c BYTECODE -i INPUT -l BYTECODE.labelmap >/dev/null" \
    "$BUILDROOT/src/gen3/main/engine/naie -v -x -I -r -c BYTECODE -i INPUT -l BYTECODE.labelmap >/dev/null"
}

EXEC_MULTI_TEST ()
{
  FILE=$1
  $BUILDROOT/bin/multitest.pl \
    $FILE \
    "$BUILDROOT/src/gen3/main/compiler/naic -i GRAMMAR -o ASM" \
    "$BUILDROOT/src/gen3/main/assembler/naia -i ASM -o BYTECODE" \
    "$BUILDROOT/src/gen3/main/engine/naie -v -x -I -c BYTECODE -i INPUT >/dev/null"
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
