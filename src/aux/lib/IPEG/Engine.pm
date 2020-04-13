package IPEG::Engine;

use Data::Dumper;

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

sub new
{
  my $class = shift;
  my $classname = ref($class) || $class;
  my $self = {
    stack_max => 1024,
  };
  bless $self, $classname;

  my $bytecode = shift;
  if (defined($bytecode)) {
    $self->set_bytecode($bytecode);
  }
  return $self;
}

sub _absorb_binary
{
  my $path = shift; die "$path not found" if (! -f $path);
  my $result = '';
  die "Error $@ opening $bytecodefile" if (!open(FILE, '<', $path));
  binmode FILE;
  my $buf;
  while (1) {
    my $n = sysread(FILE, $buf, 1024);
    if (!$n) {
      close FILE;
      return $result;
    }
    $result .= $buf;
  }
}

sub _absorb_slotmap
{
  my $path = shift;
  my $slotmapfile = "$path";
  $slotmapfile =~ s/\.byc$/.slotmap/ || $slotmapfile.slotmap;
  return undef if (!-f $slotmapfile);
  my $bin = _absorb_binary($slotmapfile);
  my $slotmap = [];
  while (length($bin)) {
    $bin =~ s/^(....)(....)([^\0]+)\0//s;
    my ($slot, $parent, $rule) = (unpack('N', $1), unpack('N', $2), $3);
    push @{$slotmap}, [ $slot, $parent, $rule ];
  }
  return $slotmap;
}

sub _absorb_labelmap
{
  my $path = shift;
  my $labelmapfile = "$path";
  $labelmapfile =~ s/\.byc$/.labelmap/ || $labelmapfile.labelmap;
  return undef if (!-f $labelmapfile);
  my $bin = _absorb_binary($labelmapfile);
  my $labelmap = {};
  while (length($bin)) {
    $bin =~ s/^([^\0]+)\0(....)//s;
    my ($label, $offset) = ($1, unpack('N', $2));
    $labelmap->{$label} = $offset;
  }
  return $labelmap;
}

sub set_file
{
  my $self = shift;
  my $path = shift;
  my $bytecode = _absorb_binary($path);
  die "Error loading $path; $@" if (!defined($bytecode));
  $self->{bytecode} = $bytecode;
  $self->{slotmap} = _absorb_slotmap($path);
  $self->{labelmap} = _absorb_labelmap($path);
}

sub set_bytecode
{
  my $self = shift;
  my $bytecode = shift || die "Need bytecode data";
  $self->{bytecode} = $bytecode;
}

sub set_debug
{
  my $self = shift;
  my $debug = shift;
  $self->{debug} = $debug;
}

sub set_labelmap
{
  my $self = shift;
  my $map = shift || die "Need labelmap";
  $self->{labelmap} = $map;
}

sub set_callback
{
  my $self = shift;
  my $functor = shift;
  $self->{callback} = $functor;
}

sub run
{
  my $self = shift;

  my $bc = $self->{bytecode} || die "Need bytecode data";
  my $txt = shift;
  die "Need text" if (!defined($txt));
  my $labelmap = $self->{labelmap};
  
  my $debug = $self->{debug};
  if ($debug) {
    print STDERR "Bytecode is " . length($bc) . " bytes.\n";
    print STDERR "Data is " . length($txt) . " bytes.\n";
  }
  
  my $stack = [];
  my $codeaddress = 0;
  my $textoffset = 0;
  my $capturelist = [];
  my $result = 0;
  my $ninstr = 0;
  my $stackdepth = 0;

  $self->{stack} = $stack;
  $self->{capturelist} = $capturelist;
  
  INSTRUCTION:
  while (1) {
    die "Instruction address overflow"
      if ($codeaddress > length($bc) - 4);
    die "Stack size $self->{stack_max} exceeded"
      if (scalar(@{$stack}) > $self->{stack_max});
    my $instr = unpack('N', substr($bc, $codeaddress, 4));
    ++$ninstr;
    if (scalar(@{$stack}) > $stackdepth) {
      $stackdepth = scalar(@{$stack});
    }
    my $textfragment;
    if ($debug || $self->{callback}) {
      my $length = $self->{textfraglen} || 10;
      $textfragment = substr($txt, $textoffset, $length);
      $textfragment =~ s/[^[:print:]]/./g;
      $textfragment .= " " x (10 - length($textfragment));
    }
    if ($debug) {
      print STDERR
        sprintf("%13s ", $dbghsh->{$instr}) .
        sprintf("c=%6d ", $codeaddress) .
        sprintf("t=%6d ", $textoffset) .
        $textfragment . " " .
        stackstring($stack) . "\n";
    }
    if ($self->{callback}) {
      my $fnc = $self->{callback};
      my $r = eval{ &$fnc(
                      $ninstr,
                      $codeaddress,
                      $instr,
                      substr($bc, $codeaddress + 4),
                      $textoffset,
                      $textfragment,
                      $stack,
                      $capturelist,
                    );
      };
      if (!defined($r)) { print STDERR "$@\n"; }
    }

    if ($instr == $INSTR_SLOT) {
      my $slot = unpack('N', substr($bc, $codeaddress + 4, 4));
      my $parent = unpack('N', substr($bc, $codeaddress + 8, 4));
      my $rule = substr($codeaddress + 12, 20);
      $codeaddress += 32;
      if ($debug) {
        print STDERR "Slot reserved $slot, parent $parent.\n";
      }

    } elsif ($instr == $INSTR_ANY) {
      if ($textoffset < length($txt)) {
        ++$textoffset;
        $codeaddress += 4;
      } else {
        goto FAIL;
      }

    } elsif ($instr == $INSTR_SKIP) {
      my $n = unpack('N', substr($bc, $codeaddress + 4, 4));
      if ($textoffset < length($txt) - ($n - 1)) {
        $textoffset += $n;
        $codeaddress += 8;
      } else {
        goto FAIL;
      }

    } elsif ($instr == $INSTR_CALL) {
      my $jump = unpack('N', substr($bc, $codeaddress + 4, 4));
      for ($i=0; $i < scalar(@{$stack}); $i++) {
        if (scalar(@{$stack})
            && $stack->[ $i ]{addr} eq $codeaddress
            && $stack->[ $i ]{pos} eq $textoffset)
        {
          if ($debug) { print STDERR "Endless loop detected.\n"; }
## TODO: This is an ending in a different category.
          goto FAIL;
        }
      }
      push @{$stack}, {
        type => 'call',
        addr => $codeaddress,
        pos => $textoffset,
        ret => $codeaddress + 8
      };
      $codeaddress = $jump;
      if ($debug) {
        print STDERR " "x14 . "(Calling " .labelreverse($codeaddress) . ")\n";
      }

    } elsif ($instr == $INSTR_CHAR) {
      my $mask = unpack('n', substr($bc, $codeaddress + 4, 2));
      my $char = unpack('n', substr($bc, $codeaddress + 6, 2));
      if ($mask == 0) { $mask = 0xff; }
      my $inp = ord(substr($txt, $textoffset, 1));
      if ($textoffset < length($txt) && $char eq ($inp & $mask)) {
        ++$textoffset;
        $codeaddress += 8;
      } else {
        goto FAIL;
      }

    } elsif ($instr == $INSTR_QUAD) {
      my $quad = substr($bc, $codeaddress + 4, 4);
      if ($textoffset < length($txt) - 3
          && $quad eq substr($txt, $textoffset, 4))
      {
        $textoffset += 4;
        $codeaddress += 8;
      } else {
        goto FAIL;
      }

    } elsif ($instr == $INSTR_CATCH) {
      my $rgt = unpack('N', substr($bc, $codeaddress + 4, 4));
      push @{$stack}, {
        type => 'catch',
        righthand => $rgt,
        textoffset => $textoffset,
        capturelength => scalar(@{$capturelist}),
      };
      $codeaddress += 8;

    } elsif ($instr == $INSTR_COMMIT) {
      my $elt = pop @{$stack};
      die "Stack corruption" if ($elt->{type} ne 'catch');
      $codeaddress = unpack('N', substr($bc, $codeaddress + 4, 4));

    } elsif ($instr == $INSTR_PARTIALCOMMIT) {
      my $elt = $stack->[ -1 ];
      die "Stack corruption" if ($elt->{type} ne 'catch');
      $elt->{textoffset} = $textoffset;
      $elt->{capturelength} = scalar(@{$capturelist});
      $codeaddress = unpack('N', substr($bc, $codeaddress + 4, 4));

    } elsif ($instr == $INSTR_BACKCOMMIT) {
      my $off = unpack('N', substr($bc, $codeaddress + 4, 4));
      my $elt = pop @{$stack};
      die "Stack corruption" if ($elt->{type} ne 'catch');
      $codeaddress = $off;
      $textoffset = $elt->{textoffset};
      splice(@{$capturelist}, $elt->{capturelength});

    } elsif ($instr == $INSTR_END) {
      my $endcode = unpack('N', substr($bc, $codeaddress + 4, 4));
      if ($debug) {
        print STDERR "SUCCESS WITH CODE $endcode.\n";
        print STDERR "$ninstr instructions executed.\n";
        print STDERR "$stackdepth max stack depth.\n";
      }
      for (my $i=0; $i < scalar(@{$capturelist}); $i++) {
        my $a = $capturelist->[$i];
        if ($a->{type} eq 'opencapture') {
          my $level = 1;
          for (my $j=$i+1; $j < scalar(@{$capturelist}); $j++) {
            my $b = $capturelist->[$j];
            if ($b->{type} eq 'opencapture') {
              ++$level;
            } elsif ($b->{type} eq 'closecapture') {
              --$level;
              if ($level == 0) {
                if ($a->{stacklen} == $b->{stacklen}
                    && $a->{slot} == $b->{slot})
                {
                  $a->{string} =
                    substr($txt, $a->{offset}, $b->{offset} - $a->{offset});
                }
                splice(@{$capturelist}, $j, 1);
                last;
              }
            }
          }
        }
      }
      return {
         endcode => $endcode,
         textoffset => $textoffset,
         captures => $capturelist
      };

    } elsif ($instr == $INSTR_FAIL) {
      goto FAIL;

    } elsif ($instr == $INSTR_FAILTWICE) {
      my $elt = pop @{$stack};
      die "Stack corruption on failtwice" if (!defined($elt->{righthand}));
      goto FAIL;

    } elsif ($instr == $INSTR_JUMP) {
      $codeaddress = unpack('N', substr($bc, $codeaddress + 4, 4));

    } elsif ($instr == $INSTR_REPLACE) {
      $stringaddress = unpack('N', substr($bc, $codeaddress + 4, 4));
      push @{$capturelist}, {
        type => 'replace',
        bytecode_offset => $stringaddress,
        text_offset => $textoffset,
      };
      $codeaddress += 8;

    } elsif ($instr == $INSTR_REPLACESTRING) {
      ##.. this shouldn't happen

    } elsif ($instr == $INSTR_RET) {
      if (scalar(@{$stack})) {
        my $elt = pop @{$stack};
        if ($elt->{type} eq 'call') {
          $codeaddress = $elt->{ret};
        } else {
          die "Bytecode error (ret before call)";
        }
      }

    } elsif ($instr == $INSTR_SET) {
      if ($textoffset < length($txt)) {
        my $c = ord(substr($txt, $textoffset, 1));
        my $b = ord(substr($bc, $codeaddress + 4 + ($c / 8), 1));
        if ($b & (1 << ($c % 8))) {
          ++$textoffset;
          $codeaddress += 36;
        } else {
          goto FAIL;
        }
      } else {
        goto FAIL;
      }

    } elsif ($instr == $INSTR_SPAN) {
      while ($textoffset < length($txt)) {
        my $c = ord(substr($txt, $textoffset, 1));
        my $b = ord(substr($bc, $codeaddress + 4 + ($c / 8), 1));
        if ($b & (1 << ($c % 8))) {
          ++$textoffset;
        } else {
          last;
        }
      }
      $codeaddress += 36;

    } elsif ($instr == $INSTR_TESTANY) {
      if ($textoffset < length($txt)) {
        $codeaddress += 8;
      } else {
        $codeaddress = unpack('N', substr($bc, $codeaddress + 4, 4));
      }

    } elsif ($instr == $INSTR_TESTCHAR) {
      my $mask = unpack('n', substr($bc, $codeaddress + 8, 2));
      my $char = unpack('n', substr($bc, $codeaddress + 10, 2));
      if ($mask == 0) { $mask = 0xff; }
      if ($textoffset < length($txt)
          && ($char & $mask) eq ord(substr($txt, $textoffset, 1)))
      {
        $codeaddress += 12;
      } else {
        $codeaddress = unpack('N', substr($bc, $codeaddress + 4, 4));
      }

    } elsif ($instr == $INSTR_TESTSET) {
      if ($textoffset < length($txt)) {
        my $c = ord(substr($txt, $textoffset, 1));
        my $b = ord(substr($bc, $codeaddress + 8 + ($c / 8), 1));
        if ($b & (1 << ($c % 8))) {
          $codeaddress += 40;
        } else {
          $codeaddress = unpack('N', substr($bc, $codeaddress + 4, 4));
        }
      } else {
        $codeaddress = unpack('N', substr($bc, $codeaddress + 4, 4));
      }

    } elsif ($instr == $INSTR_OPENCAPTURE) {
      my $slot = unpack('N', substr($bc, $codeaddress + 4, 4));
      capture_open($slot);
      $codeaddress += 8;

    } elsif ($instr == $INSTR_CLOSECAPTURE) {
      my $slot = unpack('N', substr($bc, $codeaddress + 4, 4));
      my $type = unpack('N', substr($bc, $codeaddress + 8, 4));
      capture_close($slot);
      $codeaddress += 12;

    } elsif ($instr == $INSTR_VAR) {
      my $ref = unpack('N', substr($bc, $codeaddress + 4, 4));
      my $value = reference_value($ref);
      if ($textoffset < length($txt) - length($value) &&
          substr($txt, $textoffset, length($value)) eq $value)
      {
        $codeaddress += 8;
        $textoffset += length($value);
      } else {
        goto FAIL;
      }

    } elsif ($instr == $INSTR_COUNTER) {
      my $reg = unpack('N', substr($bc, $codeaddress + 4, 4));
      my $val = unpack('N', substr($bc, $codeaddress + 8, 4));
      $stack->[ scalar(@{$stack})-1 ]{reg}{$reg} = $val;
      $codeaddress += 12;

    } elsif ($instr == $INSTR_CONDJUMP) {
      my $reg = unpack('N', substr($bc, $codeaddress + 4, 4));
      my $jmp = unpack('N', substr($bc, $codeaddress + 8, 4));
      if (int($stack->[ scalar(@{$stack})-1 ]{reg}{$reg}) eq '1') {
        $codeaddress += 12;
      } else {
        --($stack->[ scalar(@{$stack})-1 ]{reg}{$reg});
        $codeaddress = $jmp;
      }

    } else {
      die "Unknown instruction opcode $instr";
    }
    next;

  FAIL:
    ++$ninstr;
    if ($debug) {
      print STDERR "------------- FAIL\n";
    }
    if ($self->{callback}) {
      my $fnc = $self->{callback};
      my $r = eval{ &$fnc(
                      $ninstr,
                      $codeaddress,
                      0xffffffff,
                      substr($bc, $codeaddress + 4),
                      $textoffset,
                      $textfragment,
                      $stack,
                      $capturelist,
                    );
      };
      if (!defined($r)) { print STDERR "$@\n"; }
    }

    $self->{stack_before_fail} = [ @{$stack} ];

    $@ = "Fail\n" .
      "Input offset $textoffset '" . substr($txt, $textoffset, 20) . "'..\n" .
      "Bytecode offset $codeaddress\n";
    while (scalar(@{$stack})) {
      my $elt = pop @{$stack};
      if ($elt->{type} eq 'catch') {
        $codeaddress = $elt->{righthand};
        $textoffset = $elt->{textoffset};
        splice(@{$capturelist}, $elt->{capturelength});
        next INSTRUCTION;
      }
    }
    if ($debug) {
      print STDERR "FAILURE\n";
    }
    return undef;
  }
  
  sub stackstring
  {
    my $stack = shift;
    my $result = '';
    my $i = 0;
    foreach my $elt (@{$stack}) {
      if ($elt->{type} eq 'call') {
        $result .= "[ ret=$elt->{ret} ]";
      } else {
        $result = "($i preceeding) [ alt=$elt->{righthand} ]";
      }
      $result .= ", ";
      ++$i;
    }
    return $result;
  }
  
  sub labelreverse
  {
    my $address = shift;
    my $result;
    foreach my $key (keys(%{$labelmap})) {
      if ($labelmap->{$key} eq $address) {
        if (!defined($result) || length($key) < length($result)) {
          $result = $key;
        }
      }
    }
    return (defined($result) ? $result : 'unknown');
  }
  
  sub capture_open
  {
    my $slot = shift;
    push @{$capturelist}, {
      type => 'opencapture',
      slot => $slot,
      offset => $textoffset,
      stacklen => scalar(@{$stack}),
    };
  }
  
  sub capture_close
  {
    my $slot = shift;
    push @{$capturelist}, {
      type => 'closecapture',
      slot => $slot,
      offset => $textoffset,
      stacklen => scalar(@{$stack}),
    };
  }
  
  sub reference_value
  {
    my $slot = shift;
    my ($stop, $stopfound);
    foreach my $elt (reverse(@{$capturelist})) {
      if ($elt->{slot} == $slot
          && $elt->{stacklen} == scalar(@{$stack})) {
        if ($elt->{type} eq 'opencapture' && $stopfound) {
          return substr($txt, $elt->{offset}, $stop - $elt->{offset});
        } elsif ($elt->{type} eq 'closecapture') {
          $stop = $elt->{offset};
          $stopfound = 1;
        }
      }
    }
    return "";
  }
}
  
1;
