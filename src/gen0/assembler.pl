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

sub enc32bit
{
  my $value = shift;
  my $byte1 = ($value >> 16) & 0xff;
  my $byte2 = ($value >> 8) & 0xff;
  my $byte3 = $value & 0xff;
  my $byte0 = $byte1 ^ $byte2 ^ $byte3;
  return chr($byte0) . chr($byte1) . chr($byte2) . chr($byte3);
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
      $output .= enc32bit($instructions->{lc('ANY')}{instr});

    } elsif ($line =~ /^\s*skip\s+([0-9]+)$/) {
      my $n = $1;
      die "Non sensical skip\n" if ($n < 1);
      $output .= enc32bit($instructions->{lc('SKIP')}{instr});
      $output .= enc32bit($n);

    } elsif ($line =~ /^\s*testany\s+($label)$/) {
      my $address = $labelmap{$1};
      die "Unknown label $1" if (!defined($address));
      $output .= enc32bit($instructions->{lc('TESTANY')}{instr});
      $output .= enc32bit($address);

    } elsif ($line =~ /^\s*char\s+($char)$/) {
      my $c = hex($1);
      $output .= enc32bit($instructions->{lc('CHAR')}{instr});
      $output .= enc32bit($c);

    } elsif ($line =~ /^\s*testchar\s+($char)\s+($label)$/) {
      my ($c, $address) = (hex($1), $labelmap{$2});
      die "Unknown label $2" if (!defined($address));
      $output .= enc32bit($instructions->{lc('TESTCHAR')}{instr});
      $output .= enc32bit($address);
      $output .= enc32bit($c);

    } elsif ($line =~ /^\s*quad\s+($quad)$/) {
      my $q = hex($1);
      $output .= enc32bit($instructions->{lc('QUAD')}{instr});
      $output .= pack('N', $q);

    } elsif ($line =~ /^\s*testquad\s+($quad)\s+($label)$/) {
      my ($q, $address) = (hex($1), $labelmap{$2});
      die "Unknown label $2" if (!defined($address));
      $output .= enc32bit($instructions->{lc('TESTQUAD')}{instr});
      $output .= enc32bit($address);
      $output .= enc32bit($q);

    } elsif ($line =~ /^\s*set\s+([a-fA-F0-9]{64})$/) {
      my $s = $1;
      $output .= enc32bit($instructions->{lc('SET')}{instr});
      while (length($s)) {
        $s =~ s/^(.{8})//;
        my $h = hex($1);
        $output .= pack('N', $h);
      }

    } elsif ($line =~ /^\s*testset\s+([a-fA-F0-9]{64})\s+($label)$/) {
      my $s = $1;
      my $address = $labelmap{$2};
      die "Unknown label $2" if (!defined($address));
      $output .= enc32bit($instructions->{lc('TESTSET')}{instr});
      $output .= enc32bit($address);
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
      $output .= enc32bit($instructions->{lc('CATCH')}{instr});
      $output .= enc32bit($address);

    } elsif ($line =~ /^\s*commit\s+($label)$/) {
      my $address = $labelmap{$1};
      die "Unknown label $1" if (!defined($address));
      $output .= enc32bit($instructions->{lc('COMMIT')}{instr});
      $output .= enc32bit($address);

    } elsif ($line =~ /^\s*partialcommit\s+($label)$/) {
      my $address = $labelmap{$1};
      die "Unknown label $1" if (!defined($address));
      $output .= enc32bit($instructions->{lc('PARTIALCOMMIT')}{instr});
      $output .= enc32bit($address);

    } elsif ($line =~ /^\s*fail$/) {
      $output .= enc32bit($instructions->{lc('FAIL')}{instr});

    } elsif ($line =~ /^\s*failtwice$/) {
      $output .= enc32bit($instructions->{lc('FAILTWICE')}{instr});

    } elsif ($line =~ /^\s*jump\s+($label)/) {
      my $address = $labelmap{$1};
      die "Unknown label $1" if (!defined($address));
      $output .= enc32bit($instructions->{lc('JUMP')}{instr});
      $output .= enc32bit($address);

    } elsif ($line =~ /^\s*call\s+($label)/) {
      my $address = $labelmap{$1};
      die "Unknown label $1" if (!defined($address));
      $output .= enc32bit($instructions->{lc('CALL')}{instr});
      $output .= enc32bit($address);

    } elsif ($line =~ /^\s*ret$/) {
      $output .= enc32bit($instructions->{lc('RET')}{instr});

    } elsif ($line =~ /^\s*end$/) {
      $output .= enc32bit($instructions->{lc('END')}{instr});
      $output .= enc32bit(0);

    } elsif ($line =~ /^\s*end\s+([0-9]+)$/) {
      $output .= enc32bit($instructions->{lc('END')}{instr});
      $output .= enc32bit($1);

    } elsif ($line =~ /^\s*opencapture\s+([0-9]+)$/) {
      $output .= enc32bit($instructions->{lc('OPENCAPTURE')}{instr});
      $output .= enc32bit($1);

    } elsif ($line =~ /^\s*closecapture\s+([0-9]+)$/) {
      $output .= enc32bit($instructions->{lc('CLOSECAPTURE')}{instr});
      $output .= enc32bit($1);

    } elsif ($line =~ /^\s*var\s+([0-9]+)$/) {
      $output .= enc32bit($instructions->{lc('VAR')}{instr});
      $output .= enc32bit($1);

    } elsif ($line =~ /^\s*counter\s+([0-9]+)\s+([0-9]+)$/) {
      $output .= enc32bit($instructions->{lc('COUNTER')}{instr});
      $output .= enc32bit($1);
      $output .= enc32bit($2);

    } elsif ($line =~ /^\s*condjump\s+([0-9]+)\s+($label)$/) {
      my $address = $labelmap{$2};
      die "Unknown label $2" if (!defined($address));
      $output .= enc32bit($instructions->{lc('CONDJUMP')}{instr});
      $output .= enc32bit($1);
      $output .= enc32bit($address);

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
    syswrite $labelmapfile, enc32bit($offset);
    syswrite $labelmapfile, $key;
    syswrite $labelmapfile, chr(0);
  }
}

1;
