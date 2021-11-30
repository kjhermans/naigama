#!/usr/bin/perl

use Naigama;

my $grammar = <<EOS

RULE <- 'a' / 'b' / 'c'

EOS
;

my $parser = Naigama->new($grammar);
my $output = $parser->run('a');

1;
