#!/usr/bin/perl

use Naigama;

my $grammar = <<EOS

RULE <- [a-z]

EOS
;

my $parser = Naigama->new($grammar);
my $output = $parser->run('a');

1;
