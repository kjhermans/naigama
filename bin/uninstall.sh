#!/bin/sh

set -e

USER=`whoami`
if [ "x$USER" != "xroot" ]; then
  echo "You need to be root to run this."
  exit -1
fi

rm -f /usr/local/bin/naic
rm -f /usr/local/bin/naia
rm -f /usr/local/bin/naie

rm -f /usr/local/lib/libnaic.a
rm -f /usr/local/lib/libnaia.a
rm -f /usr/local/lib/libnaie.a

rm -rf /usr/local/lib/naigama

rm -rf /usr/local/include/naigama
