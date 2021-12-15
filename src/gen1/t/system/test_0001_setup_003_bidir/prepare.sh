#!/bin/sh

set -e

rm -rf /tmp/left /tmp/leftspool /tmp/right /tmp/rightspool
mkdir -p /tmp/left /tmp/leftspool /tmp/right /tmp/rightspool

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
cp $SYSTEMTESTROOT/bin/fetcher.pl /tmp/leftspool/fetcher

perl $SYSTEMTESTROOT/bin/network.pl ./test.network off

sleep 1

perl $SYSTEMTESTROOT/bin/network.pl ./test.network on
