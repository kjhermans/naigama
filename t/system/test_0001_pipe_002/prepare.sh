#!/bin/sh

set -e

echo "
<message>
<classification>Secret</classification>
<payload>
  <personalrecord>
    <surname>Hermans</surname>
    <name>Kees-Jan</name>
  </personalrecord>
</payload>
</message>
" > /tmp/test.xml

perl $SYSTEMTESTROOT/bin/network.pl ./test.network off

sleep 1

perl $SYSTEMTESTROOT/bin/network.pl ./test.network on
