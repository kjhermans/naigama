#!/bin/sh

FILES=`ls xml/*`
for FILE in $FILES; do
  echo $FILE
  $SYSTEMTESTROOT/bin/naie -t -S -c /tmp/test.byc -i $FILE
done
