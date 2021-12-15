#!/bin/sh

set -e

rm -rf /tmp/leftspool /tmp/left

perl $SYSTEMTESTROOT/bin/network.pl ./test.network off

sleep 1

perl $SYSTEMTESTROOT/bin/network.pl ./test.network on
