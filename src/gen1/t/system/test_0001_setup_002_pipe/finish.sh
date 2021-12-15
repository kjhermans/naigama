#!/bin/sh

perl $SYSTEMTESTROOT/bin/network.pl ./test.network off

SEP='

++++

'

echo $SEP

cat /tmp/test.xml; echo $SEP
cat /tmp/filterupload_1.result; echo $SEP
cat /tmp/error.log
