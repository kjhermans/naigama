#!/bin/sh

GRAMMAR=$1
INPUT=$2

rm -rf /tmp/movie*

cp $GRAMMAR /tmp/movie.naig
cp $INPUT /tmp/movie.txt

./src/gen3/main/compiler/naic -i $GRAMMAR -o /tmp/movie.asm -m /tmp/movie.slotmap
./src/gen3/main/assembler/naia -i /tmp/movie.asm -o /tmp/movie.byc -l /tmp/movie.labelmap
./src/gen3/main/engine/naie -i /tmp/movie.txt -c /tmp/movie.byc -l /tmp/movie.labelmap -m /tmp/movie.slotmap -V >/tmp/movie.log 

cat /tmp/movie.log | perl ./src/gen3/bin/makemovie.pl /tmp/movie.naig /tmp/movie.asm /tmp/movie.txt

