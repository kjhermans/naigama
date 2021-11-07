#!/bin/sh

IN=$1
OUT=$2 ## ignore

curl -F file=@$IN http://169.254.1.2:9090/upload
