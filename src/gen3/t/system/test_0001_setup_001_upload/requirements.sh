#!/bin/sh

set -e

which head
which xxd
which curl
which perl
perl -e 'use AnyEvent::HTTPD;'
