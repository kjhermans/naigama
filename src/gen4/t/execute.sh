#!/bin/sh

EXEC_SINGLE_TEST ()
{
  FILE=$1
  ../bin/singletest.pl \
    $FILE \
    "$ROOT/main/compiler/naic -i GRAMMAR -o ASM" \
    "$ROOT/main/assembler/naia -i ASM -o BYTECODE -l BYTECODE.labelmap" \
    "$ROOT/main/engine/naie -v -x -I -c BYTECODE -i INPUT -l BYTECODE.labelmap >/dev/null" \
    "$ROOT/main/engine/naie -D -v -x -I -r -c BYTECODE -i INPUT -l BYTECODE.labelmap >/dev/null"
}

EXEC_MULTI_TEST ()
{
  FILE=$1
  $ROOT/bin/multitest.pl \
    $FILE \
    "$ROOT/main/compiler/naic -i GRAMMAR -o ASM" \
    "$ROOT/main/assembler/naia -i ASM -o BYTECODE" \
    "$ROOT/main/engine/naie -D -v -x -I -c BYTECODE -i INPUT >/dev/null"
}

EXEC_BITFAULT_TEST ()
{
  FILE=$1
  $ROOT/bin/bitfaulttest.pl \
    $FILE \
    "$ROOT/main/compiler/naic -i GRAMMAR -o ASM" \
    "$ROOT/main/assembler/naia -i ASM -o BYTECODE -l BYTECODE.labelmap" \
    "$ROOT/main/engine/naie -v -x -I -c BYTECODE -i INPUT -l BYTECODE.labelmap >/dev/null"
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

#  echo "Bitfault tests"
#  FILES=`ls bitfault_*.tst`
#  for FILE in $FILES; do
#    EXEC_BITFAULT_TEST $FILE
#  done
  
fi
