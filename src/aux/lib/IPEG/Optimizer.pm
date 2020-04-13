package IPEG::Optimizer;

use Data::Dumper;

sub new
{
  my $class = shift;
  my $classname = ref($class) || $class;
  my $self = {
  };
  bless $self, $classname;

  my $assembly = shift;
  if (defined($assembly)) {
    $self->set_assembly($assembly);
  }
  return $self;
}

sub set_assembly
{
  my $self = shift;
  my $assembly = shift || die "Need assembly";
  $self->{assembly} = $assembly;
}

sub get_assembly
{
  my $self = shift;
  die "Need assembly" if (!defined($self->{assembly}));
  $self->{optimized} = _optimize($self->{assembly});
  return $self->{optimized};
}

sub _optimize
{
  my $assembly = shift || die "Need assembly";
  $assembly = "$assembly";
  do {
    my $changed = 0;

    my $copy = _deduplicate_labels($assembly);
    if ($copy ne $assembly) {
      $changed++;
      $assembly = $copy;
    }

#    my $copy = _introduce_tests($assembly);
#    if ($copy ne $assembly) {
#      $changed++;
#      $assembly = $copy;
#    }

    my $copy = _introduce_quads($assembly);
    if ($copy ne $assembly) {
      $changed++;
      $assembly = $copy;
    }

    my $copy = _introduce_skips($assembly);
    if ($copy ne $assembly) {
      $changed++;
      $assembly = $copy;
    }

    my $copy = _multiple_sets($assembly);
    if ($copy ne $assembly) {
      $changed++;
      $assembly = $copy;
    }

  } while ($changed);
  return $assembly;
}

sub _deduplicate_labels
{
  my $input = shift;
  return $input;
}

##
## Replaces catchs with one match with a 'test' and a jump.
## For example:
## 
##   catch LABEL1
##   char 20
##   commit LABEL2
## LABEL1:
## 
## Is replaced by:
## 
##   testchar 20 LABEL1
##   jump LABEL2
## LABEL1:
## 
## Which means one less instruction and one less item
## to needlessly push on the stack.
##
## REPL    <- 'catch' %s+ {:lab1: LABEL :} %s+
##            { 'any' / 'char' %s+ CHARDEF / 'set' %s+ SETDEF } %s+
##            'commit' %s+ {:lab2: LABEL :} %s+
##            =lab1
##         -> 'test' =2 ' ' =lab1 '\n'
##            'jump ' =lab2 '\n'
##            =lab1 ':\n'
## SETDEF  <- [0-9a-fA-F]^Q64
## CHARDEF <- [0-9a-fA-F]^Q2
## LABEL   <- [a-zA-Z0-9_]+
##

sub _introduce_tests
{
  my $input = shift;
  for (my $i=0; $i < length($input); $i++) {
    my $b = substr($input, 0, $i);
    my $s = substr($input, $i);
    my $LAB = '([0-9a-z_]+)';
    my $CHR = '([0-9a-f]{2})';
    my $SET = '([0-9a-f]{64})';
    if ($s =~ /^catch\s+$LAB\s+any\s+commit\s+$LAB\s+$LAB:/i
        && $1 eq $4)
    {
      $s =~ s/^catch\s+$LAB\s+any\s+commit\s+$LAB\s+$LAB:
             /testany $1\n  any\n  jump $2\n$3:/ix;
      $input = $b . $s;
    }
    if ($s =~ /^catch\s+$LAB\s+char\s+$CHR\s+commit\s+$LAB\s+$LAB:/i
        && $1 eq $4)
    {
      $s =~ s/^catch\s+$LAB\s+char\s+$CHR\s+commit\s+$LAB\s+$LAB:
             /testchar $2 $1\n  any\n  jump $3\n$4:/ix;
      $input = $b . $s;
    }
    if ($s =~ /^catch\s+$LAB\s+set\s+$SET\s+commit\s+$LAB\s+$LAB:/i
        && $1 eq $4)
    {
      $s =~ s/^catch\s+$LAB\s+set\s+$SET\s+commit\s+$LAB\s+$LAB:
             /testset $2 $1\n  any\n  jump $3\n$4:/ix;
      $input = $b . $s;
    }
  }
  return $input;
}

## Replaces groups of four char's with a quad.

sub _introduce_quads
{
  my $input = shift;
  $input =~ s/
    char\s+([0-9a-fA-F]{2})\s+
    char\s+([0-9a-fA-F]{2})\s+
    char\s+([0-9a-fA-F]{2})\s+
    char\s+([0-9a-fA-F]{2})/quad $1$2$3$4/gx;
  return $input;
}

## Replaces one or more any's with a counted skip.

sub _introduce_skips
{
  my $input = shift;
  my @ary = ( $input =~ /\s+any\s+/g );
  my $anycount = scalar(@ary);
  while ($anycount > 1) {
    my $re = 'any\s+' x $anycount;
    $input =~ s/$re/skip $anycount\n  /;
    --$anycount;
  }
  return $input;
}

sub _multiple_sets
{
  my $input = shift;
  my $copy = "$input";
  my %sets;
  while ($copy =~ s/set\s+([0-9a-fA-F]{64})//) {
    my $s = $1;
    my $o = $sets{$s};
    if (!defined($o)) {
      $sets{$s} = 1;
    } else {
      ++( $sets{$s} );
    }
  }
  my $c = 1;
  foreach my $set (keys(%sets)) {
    if ($sets{$set} > 2) {
      $input =~ s/set\s+$set/call SET_$c/g;
      $input .=
        "SET_$c:\n" .
        "  set $set\n" .
        "  ret\n";
      ++$c;
    }
  }
  return $input;
}

1;
