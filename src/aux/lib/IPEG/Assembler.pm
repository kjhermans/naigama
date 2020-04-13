#!/usr/bin/perl

package IPEG::Assembler;

##DEADBEEF
my $INSTR_ANY = 1283;
my $INSTR_BACKCOMMIT = 264752;
my $INSTR_CALL = 262915;
my $INSTR_CATCH = 264707;
my $INSTR_CHAR = 263433;
my $INSTR_CLOSECAPTURE = 528133;
my $INSTR_COMMIT = 264709;
my $INSTR_CONDJUMP = 525107;
my $INSTR_COUNTER = 525071;
my $INSTR_END = 262922;
my $INSTR_FAIL = 2570;
my $INSTR_FAILTWICE = 2575;
my $INSTR_JUMP = 262921;
my $INSTR_MASKEDCHAR = 263434;
my $INSTR_NOOP = 0;
my $INSTR_OPENCAPTURE = 265987;
my $INSTR_PARTIALCOMMIT = 264713;
my $INSTR_QUAD = 263475;
my $INSTR_RANGE = 525651;
my $INSTR_REPLACE = 265994;
my $INSTR_REPLACESTRING = 265999;
my $INSTR_RET = 773;
my $INSTR_SET = 2098489;
my $INSTR_SKIP = 263509;
my $INSTR_SKIPVAR = 264531;
my $INSTR_SPAN = 2098495;
my $INSTR_TESTANY = 263429;
my $INSTR_TESTCHAR = 525583;
my $INSTR_TESTQUAD = 525621;
my $INSTR_TESTSET = 2360634;
my $INSTR_VAR = 265993;
my $dbghsh = {
  1283 => 'ANY',
  264752 => 'BACKCOMMIT',
  262915 => 'CALL',
  264707 => 'CATCH',
  263433 => 'CHAR',
  528133 => 'CLOSECAPTURE',
  264709 => 'COMMIT',
  525107 => 'CONDJUMP',
  525071 => 'COUNTER',
  262922 => 'END',
  2570 => 'FAIL',
  2575 => 'FAILTWICE',
  262921 => 'JUMP',
  263434 => 'MASKEDCHAR',
  0 => 'NOOP',
  265987 => 'OPENCAPTURE',
  264713 => 'PARTIALCOMMIT',
  263475 => 'QUAD',
  525651 => 'RANGE',
  265994 => 'REPLACE',
  265999 => 'REPLACESTRING',
  773 => 'RET',
  2098489 => 'SET',
  263509 => 'SKIP',
  264531 => 'SKIPVAR',
  2098495 => 'SPAN',
  263429 => 'TESTANY',
  525583 => 'TESTCHAR',
  525621 => 'TESTQUAD',
  2360634 => 'TESTSET',
  265993 => 'VAR',
};
##DEADBEEF

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
  my $assembly = shift;
  die "No assembly given" if (!defined($assembly));
  $self->{assembly} = $assembly;
}

sub get_labelmap
{
  my $self = shift;
  return $self->{labelmap};
}

sub assemble
{
  my $self = shift;
  die "No assembly given" if (!defined($self->{assembly}));
  my $assembly = $self->{assembly};

  my @input = split(/\n/, $assembly);

  my %labelmap;
  
  first_pass(@input);
  my $bytecode = second_pass(@input);
  return $bytecode;
  
  sub first_pass
  {
    my @lines = @_;
    my $address = 0;
    foreach my $line (@lines) {
      next if ($line =~ /^--/);
      if ($line =~ /^([a-zA-Z0-9_]+):$/) {
        $labelmap{$1} = $address;
      } elsif ($line =~ /^\s*any$/) {
        $address += 4;
      } elsif ($line =~ /^\s*and\s+/) {
        $address += 8;
      } elsif ($line =~ /^\s*or\s+/) {
        $address += 8;
      } elsif ($line =~ /^\s*skip\s+/) {
        $address += 8;
      } elsif ($line =~ /^\s*testany\s+/) {
        $address += 8;
      } elsif ($line =~ /^\s*char\s+/) {
        $address += 8;
      } elsif ($line =~ /^\s*testchar\s+/) {
        $address += 12;
      } elsif ($line =~ /^\s*quad\s+/) {
        $address += 8;
      } elsif ($line =~ /^\s*testquad\s+/) {
        $address += 12;
      } elsif ($line =~ /^\s*set\s+/) {
        $address += 36;
      } elsif ($line =~ /^\s*testset\s+/) {
        $address += 40;
      } elsif ($line =~ /^\s*span\s+/) {
        $address += 36;
      } elsif ($line =~ /^\s*catch\s+/) {
        $address += 8;
      } elsif ($line =~ /^\s*commit\s+/) {
        $address += 8;
      } elsif ($line =~ /^\s*partialcommit\s+/) {
        $address += 8;
      } elsif ($line =~ /^\s*fail$/) {
        $address += 4;
      } elsif ($line =~ /^\s*failtwice$/) {
        $address += 4;
      } elsif ($line =~ /^\s*jump\s+/) {
        $address += 8;
      } elsif ($line =~ /^\s*call\s+/) {
        $address += 8;
      } elsif ($line =~ /^\s*ret$/) {
        $address += 4;
      } elsif ($line =~ /^\s*end(\s+|$)/) {
        $address += 8;
      } elsif ($line =~ /^\s*opencapture\s+/) {
        $address += 8;
      } elsif ($line =~ /^\s*closecapture\s+/) {
        $address += 12;
      } elsif ($line =~ /^\s*var\s+/) {
        $address += 8;
      } else {
        $line =~ s/^\s+//;
        die "Unknown opcode $line" if (length($line));
      }
    }
    $self->{labelmap} = \%labelmap;
  }
  
  sub second_pass
  {
    my @lines = @_;
    my $address = 0;
    my $char = "[a-f0-9A-F]{2}";
    my $quad = "[a-f0-9A-F]{8}";
    my $label = "[a-zA-Z0-9_]+";
    my $output = '';
    foreach my $line (@lines) {
      next if ($line =~ /^--/);
      if ($line =~ /^($label):$/) {
        my $pos = length($output);
        if ($labelmap{$1} ne $pos) {
          die "Expected to have label at $labelmap{$1} (am at $pos).\n";
        }

      } elsif ($line =~ /^\s*any$/) {
        $output .= pack('N', $INSTR_ANY);
  
      } elsif ($line =~ /^\s*skip\s+([0-9]+)$/) {
        my $n = $1;
        die "Non sensical skip\n" if ($n < 1);
        $output .= pack('N', $INSTR_SKIP);
        $output .= pack('N', $n);
  
      } elsif ($line =~ /^\s*testany\s+($label)$/) {
        my $address = $labelmap{$1};
        die "Unknown label $1" if (!defined($address));
        $output .= pack('N', $INSTR_TESTANY);
        $output .= pack('N', $address);
  
      } elsif ($line =~ /^\s*char\s+($char)(\s+($char))?$/) {
        my $c = hex($1);
        my $m = (defined($2)? hex($2) : 0);
        $output .= pack('N', $INSTR_CHAR);
        $output .= pack('n', $m);
        $output .= pack('n', $c);
  
      } elsif ($line =~ /^\s*testchar\s+($char)\s+($label)(\s+($char))?$/) {
        my ($c, $address) = (hex($1), $labelmap{$2});
        my $m = (defined($3)? hex($3) : 0);
        die "Unknown label $2" if (!defined($address));
        $output .= pack('N', $INSTR_TESTCHAR);
        $output .= pack('N', $address);
        $output .= pack('n', $m);
        $output .= pack('n', $c);

      } elsif ($line =~ /^\s*quad\s+($quad)$/) {
        my $q = hex($1);
        $output .= pack('N', $INSTR_QUAD);
        $output .= pack('N', $q);

      } elsif ($line =~ /^\s*testquad\s+($quad)\s+($label)$/) {
        my ($q, $address) = (hex($1), $labelmap{$2});
        die "Unknown label $2" if (!defined($address));
        $output .= pack('N', $INSTR_TESTQUAD);
        $output .= pack('N', $address);
        $output .= pack('N', $q);
  
      } elsif ($line =~ /^\s*set\s+([a-fA-F0-9]{64})$/) {
        my $s = $1;
        $output .= pack('N', $INSTR_SET);
        while (length($s)) {
          $s =~ s/^(.{8})//;
          my $h = hex($1);
          $output .= pack('N', $h);
        }
  
      } elsif ($line =~ /^\s*testset\s+([a-fA-F0-9]{64})\s+($label)$/) {
        my $s = $1;
        my $address = $labelmap{$2};
        die "Unknown label $2" if (!defined($address));
        $output .= pack('N', $INSTR_TESTSET);
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
        $output .= pack('N', $INSTR_CATCH);
        $output .= pack('N', $address);
  
      } elsif ($line =~ /^\s*commit\s+($label)$/) {
        my $address = $labelmap{$1};
        die "Unknown label $1" if (!defined($address));
        $output .= pack('N', $INSTR_COMMIT);
        $output .= pack('N', $address);
  
      } elsif ($line =~ /^\s*partialcommit\s+($label)$/) {
        my $address = $labelmap{$1};
        die "Unknown label $1" if (!defined($address));
        $output .= pack('N', $INSTR_PARTIALCOMMIT);
        $output .= pack('N', $address);
  
      } elsif ($line =~ /^\s*fail$/) {
        $output .= pack('N', $INSTR_FAIL);
  
      } elsif ($line =~ /^\s*failtwice$/) {
        $output .= pack('N', $INSTR_FAILTWICE);
  
      } elsif ($line =~ /^\s*jump\s+($label)/) {
        my $address = $labelmap{$1};
        die "Unknown label $1" if (!defined($address));
        $output .= pack('N', $INSTR_JUMP);
        $output .= pack('N', $address);
  
      } elsif ($line =~ /^\s*call\s+($label)/) {
        my $address = $labelmap{$1};
        die "Unknown label $1" if (!defined($address));
        $output .= pack('N', $INSTR_CALL);
        $output .= pack('N', $address);
  
      } elsif ($line =~ /^\s*ret$/) {
        $output .= pack('N', $INSTR_RET);
  
      } elsif ($line =~ /^\s*end$/) {
        $output .= pack('N', $INSTR_END);
        $output .= pack('N', 0);
  
      } elsif ($line =~ /^\s*end\s+([0-9]+)$/) {
        $output .= pack('N', $INSTR_END);
        $output .= pack('N', $1);
  
      } elsif ($line =~ /^\s*opencapture\s+([0-9]+)$/) {
        $output .= pack('N', $INSTR_OPENCAPTURE);
        $output .= pack('N', $1);
  
      } elsif ($line =~ /^\s*closecapture\s+([0-9]+)(\s+([0-9]+))?$/) {
        $output .= pack('N', $INSTR_CLOSECAPTURE);
        $output .= pack('N', $1);
        if (defined($3)) {
          $output .= pack('N', $3);
        } else {
          $output .= pack('N', 0);
        }
  
      } elsif ($line =~ /^\s*var\s+([0-9]+)$/) {
        $output .= pack('N', $INSTR_VAR);
        $output .= pack('N', $1);
  
      }
    }
    return $output;
  }
}

1;
