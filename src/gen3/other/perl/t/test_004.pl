#!/usr/bin/perl

use Data::Dumper;

use Naigama;

my $grammar = <<'EOS'

TOP          <- JSON
__prefix     <- %s*
JSON         <- HASH END
HASH         <- { CBOPEN OPTHASHELTS CBCLOSE }
OPTHASHELTS  <- HASHELTS / ...
HASHELTS     <- HASHELT COMMA HASHELTS / HASHELT
HASHELT      <- STRING COLON VALUE
ARRAY        <- { ABOPEN OPTARRAYELTS ABCLOSE }
OPTARRAYELTS <- ARRAYELTS / ...
ARRAYELTS    <- VALUE COMMA ARRAYELTS / VALUE
VALUE        <- STRING / FLOAT / INT / BOOL / NULL / HASH / ARRAY
STRING       <- '"' { ( '\\' ([nrtv"] / [0-9]^3) / [^"\\] )* } '"'
INT          <- { [0-9]+ }
FLOAT        <- { [0-9]* '.' [0-9]+ }
BOOL         <- { 'true' / 'false' }
NULL         <- { 'null' }
CBOPEN       <- '{'
CBCLOSE      <- '}'
ABOPEN       <- '['
ABCLOSE      <- ']'
COMMA        <- ','
COLON        <- ':'
END          <- !.

EOS
;

my $json = <<'EOS'

{ "foo" : { "bar" : "test" } }

EOS
;

my $parser = Naigama->new($grammar);
#$parser->{debug} = 1;
my $output = eval { $parser->run($json) };
if ($output) {
  print "Ok\n";
} else {
  print "NOK; $@\n";
}

1;
