#!/bin/sh

set -e

perl $SYSTEMTESTROOT/bin/network.pl ./test.network off

sleep 1

perl $SYSTEMTESTROOT/bin/network.pl ./test.network on
