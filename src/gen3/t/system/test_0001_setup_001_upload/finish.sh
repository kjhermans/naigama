#!/bin/sh

perl $SYSTEMTESTROOT/bin/network.pl ./test.network off

SEP='

++++

'

echo $SEP

cat /tmp/sample.txt; echo $SEP
cat /tmp/uploadedfile; echo $SEP
