#!/usr/bin/perl

use Data::Dumper;

print STDERR "This is Naigama assembler Generation 0.\n";

my $instructions;
my %labelmap;
my ($inputfile, $outputfile) = ( '-', '-' );

while (my $arg = shift @ARGV) {
  if ($arg =~ s/^-//) {
    while ($arg =~ s/^(.)//) {
      my $option = $1;
      if ($option eq 'i') {
        $inputfile = shift @ARGV;
      } elsif ($option eq 'o') {
        $outputfile = shift @ARGV;
      } elsif ($option eq 'l') {
        $path = shift @ARGV;
        open $labelmapfile, '>', $path
          || die "Could not open labelmap file $path";
      } elsif ($option eq 'I') {
        my $file = shift @ARGV;
        $instructions = eval(`cat $file`);
      } else {
        die "Unknown command line option '-$option'";
      }
    }
  } else {
    $inputfile = $arg || '-';
    $outputfile = shift @ARGV || '-';
    last;
  }
}

if (!defined($instructions)) {
  die "Need instructions file";
}
if (!scalar(keys(%{$instructions}))) {
  die "No instructions";
} else {
  print STDERR scalar(keys(%{$instructions}))." instructions loaded.\n";
}

my ($in, $out);

if ($inputfile eq '-') {
  $in = *STDIN;
} else {
  open $in, '<', $inputfile || die "Could not open $inputfile";
}

if ($outputfile eq '-') {
  $out = *STDOUT;
} else {
  open $out, '>', $outputfile || die "Could not open $outputfile";
}

my $input = '';
{
  while (my $line = <$in>) {
    $input .= $line;
  }
  close $in;
}

my $bytecode = assemble($input);
print STDERR length($bytecode) . " bytes of bytecode generated.\n";
syswrite $out, $bytecode;
close $out;

if ($labelmapfile) {
  labelmap_write();
}

exit 0;

##---- functions --------------------------------------------------##

sub assemble
{
  my $assembly = shift;
  my @input = split(/\n/, $assembly);
  print STDERR scalar(@input) . " lines of input assembly.\n";
  
  zeroth_pass(\@input);
  first_pass(\@input);
  my $bytecode = second_pass(\@input);
  return $bytecode;
}

sub zeroth_pass
{
  my $lines = shift;
  foreach my $line (@{$lines}) {
    $line =~ s/--.*$//;
    $line =~ s/\s+$//;
    $line =~ s/^\s+//;
  }
}

sub first_pass
{
  my $lines = shift;
  my $address = 0;
  foreach my $line (@{$lines}) {
    next if (!length($line));
    if ($line =~ /^([a-zA-Z0-9_]+):/) {
      $labelmap{$1} = $address;
    } elsif ($line =~ /^([a-z]+)/) {
      my $opcode = $1;
      if (!defined($instructions->{$opcode})) {
        die "Unknown opcode $line";
      }
      my $size = $instructions->{$opcode}{size};
      $address += $size;
    } else {
      die "Unknown opcode $line";
    }
  }
}

sub second_pass
{
  my $lines = shift;
  my $address = 0;
  my $char = "[a-f0-9A-F]{2}";
  my $quad = "[a-f0-9A-F]{8}";
  my $label = "[a-zA-Z0-9_]+";
  my $output = '';
  foreach my $line (@{$lines}) {
    if ($line =~ /^($label):$/) {
      my $pos = length($output);
      if ($labelmap{$1} ne $pos) {
        die "Expected to have label at $labelmap{$1} (am at $pos).\n";
      }

    } elsif ($line =~ /^\s*any$/) {
      $output .= pack('N', $instructions->{lc('ANY')}{instr});

    } elsif ($line =~ /^\s*skip\s+([0-9]+)$/) {
      my $n = $1;
      die "Non sensical skip\n" if ($n < 1);
      $output .= pack('N', $instructions->{lc('SKIP')}{instr});
      $output .= pack('N', $n);

    } elsif ($line =~ /^\s*testany\s+($label)$/) {
      my $address = $labelmap{$1};
      die "Unknown label $1" if (!defined($address));
      $output .= pack('N', $instructions->{lc('TESTANY')}{instr});
      $output .= pack('N', $address);

    } elsif ($line =~ /^\s*char\s+($char)(\s+($char))?$/) {
      my $c = hex($1);
      my $m = (defined($2)? hex($2) : 0);
      $output .= pack('N', $instructions->{lc('CHAR')}{instr});
      $output .= pack('n', $m);
      $output .= pack('n', $c);

    } elsif ($line =~ /^\s*testchar\s+($char)\s+($label)(\s+($char))?$/) {
      my ($c, $address) = (hex($1), $labelmap{$2});
      my $m = (defined($3)? hex($3) : 0);
      die "Unknown label $2" if (!defined($address));
      $output .= pack('N', $instructions->{lc('TESTCHAR')}{instr});
      $output .= pack('N', $address);
      $output .= pack('n', $m);
      $output .= pack('n', $c);

    } elsif ($line =~ /^\s*quad\s+($quad)$/) {
      my $q = hex($1);
      $output .= pack('N', $instructions->{lc('QUAD')}{instr});
      $output .= pack('N', $q);

    } elsif ($line =~ /^\s*testquad\s+($quad)\s+($label)$/) {
      my ($q, $address) = (hex($1), $labelmap{$2});
      die "Unknown label $2" if (!defined($address));
      $output .= pack('N', $instructions->{lc('TESTQUAD')}{instr});
      $output .= pack('N', $address);
      $output .= pack('N', $q);

    } elsif ($line =~ /^\s*set\s+([a-fA-F0-9]{64})$/) {
      my $s = $1;
      $output .= pack('N', $instructions->{lc('SET')}{instr});
      while (length($s)) {
        $s =~ s/^(.{8})//;
        my $h = hex($1);
        $output .= pack('N', $h);
      }

    } elsif ($line =~ /^\s*testset\s+([a-fA-F0-9]{64})\s+($label)$/) {
      my $s = $1;
      my $address = $labelmap{$2};
      die "Unknown label $2" if (!defined($address));
      $output .= pack('N', $instructions->{lc('TESTSET')}{instr});
      $output .= pack('N', $address);
      while (length($s)) {
        $s =~ s/^(.{8})//;
        my $h = hex($1);
        $output .= pack('N', $h);
      }

    } elsif ($line =~ /^\s*span\s+/) {
      die "Implement";

    } elsif ($line =~ /^\s*catch\s+($label)$/) {
      my $address = $labelmap{$1};
      die "Unknown label $1" if (!defined($address));
      $output .= pack('N', $instructions->{lc('CATCH')}{instr});
      $output .= pack('N', $address);

    } elsif ($line =~ /^\s*commit\s+($label)$/) {
      my $address = $labelmap{$1};
      die "Unknown label $1" if (!defined($address));
      $output .= pack('N', $instructions->{lc('COMMIT')}{instr});
      $output .= pack('N', $address);

    } elsif ($line =~ /^\s*partialcommit\s+($label)$/) {
      my $address = $labelmap{$1};
      die "Unknown label $1" if (!defined($address));
      $output .= pack('N', $instructions->{lc('PARTIALCOMMIT')}{instr});
      $output .= pack('N', $address);

    } elsif ($line =~ /^\s*fail$/) {
      $output .= pack('N', $instructions->{lc('FAIL')}{instr});

    } elsif ($line =~ /^\s*failtwice$/) {
      $output .= pack('N', $instructions->{lc('FAILTWICE')}{instr});

    } elsif ($line =~ /^\s*jump\s+($label)/) {
      my $address = $labelmap{$1};
      die "Unknown label $1" if (!defined($address));
      $output .= pack('N', $instructions->{lc('JUMP')}{instr});
      $output .= pack('N', $address);

    } elsif ($line =~ /^\s*call\s+($label)/) {
      my $address = $labelmap{$1};
      die "Unknown label $1" if (!defined($address));
      $output .= pack('N', $instructions->{lc('CALL')}{instr});
      $output .= pack('N', $address);

    } elsif ($line =~ /^\s*ret$/) {
      $output .= pack('N', $instructions->{lc('RET')}{instr});

    } elsif ($line =~ /^\s*end$/) {
      $output .= pack('N', $instructions->{lc('END')}{instr});
      $output .= pack('N', 0);

    } elsif ($line =~ /^\s*end\s+([0-9]+)$/) {
      $output .= pack('N', $instructions->{lc('END')}{instr});
      $output .= pack('N', $1);

    } elsif ($line =~ /^\s*opencapture\s+([0-9]+)$/) {
      $output .= pack('N', $instructions->{lc('OPENCAPTURE')}{instr});
      $output .= pack('N', $1);

    } elsif ($line =~ /^\s*closecapture\s+([0-9]+)$/) {
      $output .= pack('N', $instructions->{lc('CLOSECAPTURE')}{instr});
      $output .= pack('N', $1);

    } elsif ($line =~ /^\s*var\s+([0-9]+)$/) {
      $output .= pack('N', $instructions->{lc('VAR')}{instr});
      $output .= pack('N', $1);

    } elsif ($line =~ /^\s*counter\s+([0-9]+)\s+([0-9]+)$/) {
      $output .= pack('N', $instructions->{lc('COUNTER')}{instr});
      $output .= pack('N', $1);
      $output .= pack('N', $2);

    } elsif ($line =~ /^\s*condjump\s+([0-9]+)\s+($label)$/) {
      my $address = $labelmap{$2};
      die "Unknown label $2" if (!defined($address));
      $output .= pack('N', $instructions->{lc('CONDJUMP')}{instr});
      $output .= pack('N', $1);
      $output .= pack('N', $address);

    } elsif (length($line)) {
      die "Unknown instruction at $line";
    }
  }
  return $output;
}

sub labelmap_write
{
  foreach my $key (sort(keys(%labelmap))) {
    my $offset = $labelmap{$key};
    syswrite $labelmapfile, pack('N', $offset);
    syswrite $labelmapfile, $key;
    syswrite $labelmapfile, chr(0);
  }
}

1;
