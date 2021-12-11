#!/usr/bin/perl

use Naigama;

my $grammar = <<EOS

RULE <- [a-z]

EOS
;

my $parser = Naigama->new($grammar);
eval { my $output = $parser->run('0') };
my $err = $@;
if ($err =~ /Match failed/) {
  print "Ok\n";
} else {
  print "NOK\n";
}

1;
