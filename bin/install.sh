#!/bin/sh

set -e

USER=`whoami`
if [ "x$USER" != "xroot" ]; then
  echo "You need to be root to run this."
  exit -1
fi

mkdir -p /usr/local/bin
cp ./src/gen3/main/compiler/naic   /usr/local/bin/
cp ./src/gen3/main/assembler/naia  /usr/local/bin/
cp ./src/gen3/main/engine/naie     /usr/local/bin/

mkdir -p /usr/local/lib/naigama
cp ./src/gen3/lib/compiler/libnaic.a   /usr/local/lib/naigama/
cp ./src/gen3/lib/assembler/libnaia.a  /usr/local/lib/naigama/
cp ./src/gen3/lib/engine/libnaie.a     /usr/local/lib/naigama/
cp ./src/gen3/lib/naigama/libnaigama.a /usr/local/lib/naigama/

ln -sf /usr/local/lib/naigama/libnaic.a /usr/local/lib/libnaic.a
ln -sf /usr/local/lib/naigama/libnaia.a /usr/local/lib/libnaia.a
ln -sf /usr/local/lib/naigama/libnaie.a /usr/local/lib/libnaie.a
ln -sf /usr/local/lib/naigama/libnaigama.a /usr/local/lib/libnaigama.a

mkdir -p /usr/local/include
cp -rfL ./src/gen3/include/naigama /usr/local/include/
