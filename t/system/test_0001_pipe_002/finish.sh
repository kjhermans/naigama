#!/bin/sh

perl $SYSTEMTESTROOT/bin/network.pl ./test.network off

SEP='

++++

'

cat /tmp/test.xml; echo $SEP
cat /tmp/leftspool/in/msg_00000000.xml; echo $SEP
