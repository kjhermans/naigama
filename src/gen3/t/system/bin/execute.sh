#!/bin/sh

date

TOP='.';
DIRS='.'
if [ "x$SYSTEMTEST" != "x" ]; then
  DIRS=$SYSTEMTEST
else
  DIRS=`find $TOP -maxdepth 1 -type d | grep test | sort -n`
fi;

export SYSTEMTESTROOT=`pwd`
export PATH=$PATH:$SYSTEMTESTROOT/bin

for DIR in $DIRS; do
  if [ "$DIR" != "." ]; then
    if grep -q SKIP $DIR/README.txt 2>/dev/null; then
      /bin/echo "  [ST] $DIR; skipped."
    else
      RUN=yes
      if [ -x $DIR/requirements.sh ]; then
        if $DIR/requirements.sh 2>&1 >/dev/null; then
          true
        else
          RUN=
        fi
      fi
      if [ "$RUN" = "yes" ]; then
        /bin/echo -n "  [ST] $DIR; result in /tmp/$DIR.log .. "
        cd $DIR && make \
          SYSTEMTESTROOT=$SYSTEMTESTROOT \
          TESTROOT=$SYSTEMTESTROOT/$DIR \
          >/tmp/$DIR.log 2>&1
        if grep -q SUCCESS /tmp/$DIR.log; then
          echo "	Succeeded."
        else
          /bin/echo -e "	\e[31mFailed.\e[39m"
        fi
        cd ..
      else
        /bin/echo "  [ST] $DIR; Requirements not met."
      fi
    fi
  fi
done

date
