#!/bin/sh

perl $SYSTEMTESTROOT/bin/network.pl ./test.network off

sep ()
{
  echo
  echo
  echo '++++'
  echo
  echo
}

sep
cat /tmp/test.xml; echo $SEP
sep
cat /tmp/filterupload_1.result; sep
sep
cat /tmp/log1
sep
cat /tmp/log2
sep
cat /tmp/log3
sep
cat /tmp/log3a
sep
cat /tmp/log4
sep
cat /tmp/log5
sep
cat /tmp/log6
sep
cat /tmp/log7
sep
cat /tmp/log7a
sep
cat /tmp/log8
sep
cat /tmp/list
sep
