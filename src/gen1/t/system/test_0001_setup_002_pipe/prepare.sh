#!/bin/sh

set -e

echo "
<message>
<classification>Unclassified</classification>
<payload>
  <personalrecord>
    <surname>Hermans</surname>
    <name>Kees-Jan</name>
  </personalrecord>
</payload>
</message>
" > /tmp/test.xml

export PATH=$PATH:$SYSTEMTESTROOT/bin

naic -i filter.naig -o /tmp/filter.byc -a /tmp/filter.asm

mkdir -p /tmp/leftspool/in

cp $SYSTEMTESTROOT/bin/filterpush.sh /tmp/leftspool/handler

perl $SYSTEMTESTROOT/bin/network.pl ./test.network off

sleep 1

perl $SYSTEMTESTROOT/bin/network.pl ./test.network on
