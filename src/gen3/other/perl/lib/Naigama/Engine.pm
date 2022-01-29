package Naigama::Engine;

#use strict;

use Naigama::Instructions qw( get_opcode_string );

sub new
{
  my $class = shift;
  my $bytecode = shift;
  my $self = {
    bytecode => $bytecode
  };
  bless $self, "$class";
  return $self;
}

sub run
{
  my $self = shift;
  my $input = shift;
  my $output = {};
  my $state = {
    input           => $input,
    stack           => [],
    pinpoints       => [],
    input_offset    => 0,
    bytecode_offset => 0,
    output          => $output,
    fail            => 0,
    end             => 0,
  };
  my $__ninstr = 0;
  while (!($state->{end})) {
    if ($state->{bytecode_offset} > length($self->{bytecode}) - 4) {
      die "Bytecode overrun (before reading instruction)";
    }
    $state->{opcode} = get_protected_quad($self->{bytecode}, $state->{bytecode_offset});
    $state->{instrsize} = ord(substr($self->{bytecode}, $state->{bytecode_offset} + 1, 1)) + 4;
    if ($state->{bytecode_offset} > length($self->{bytecode}) - $state->{instrsize}) {
      die "Bytecode overrun (after reading instruction)";
    }
    if ($self->{debug}) {
      print STDERR
        "$__ninstr; " .
        Naigama::Instructions::get_opcode_string($state->{opcode}) .
        " " . scalar(@{$state->{stack}}) .
        "\n";
      $__ninstr++;
    }
    if ($state->{opcode} == $Naigama::Instructions::INSTR_ANY) {
      $self->process_any($state);
    } elsif ($state->{opcode} == $Naigama::Instructions::INSTR_BACKCOMMIT) {
      $self->process_backcommit($state);
    } elsif ($state->{opcode} == $Naigama::Instructions::INSTR_CALL) {
      $self->process_call($state);
    } elsif ($state->{opcode} == $Naigama::Instructions::INSTR_CATCH) {
      $self->process_catch($state);
    } elsif ($state->{opcode} == $Naigama::Instructions::INSTR_CHAR) {
      $self->process_char($state);
    } elsif ($state->{opcode} == $Naigama::Instructions::INSTR_CLOSECAPTURE) {
      $self->process_closecapture($state);
    } elsif ($state->{opcode} == $Naigama::Instructions::INSTR_COMMIT) {
      $self->process_commit($state);
    } elsif ($state->{opcode} == $Naigama::Instructions::INSTR_CONDJUMP) {
      $self->process_condjump($state);
    } elsif ($state->{opcode} == $Naigama::Instructions::INSTR_COUNTER) {
      $self->process_counter($state);
    } elsif ($state->{opcode} == $Naigama::Instructions::INSTR_END) {
      $self->process_end($state);
    } elsif ($state->{opcode} == $Naigama::Instructions::INSTR_ENDREPLACE) {
      ##..
    } elsif ($state->{opcode} == $Naigama::Instructions::INSTR_FAIL) {
      $state->{fail} = 1;
    } elsif ($state->{opcode} == $Naigama::Instructions::INSTR_FAILTWICE) {
      $self->process_failtwice($state);
    } elsif ($state->{opcode} == $Naigama::Instructions::INSTR_JUMP) {
      $self->process_jump($state);
    } elsif ($state->{opcode} == $Naigama::Instructions::INSTR_MASKEDCHAR) {
      $self->process_maskedchar($state);
    } elsif ($state->{opcode} == $Naigama::Instructions::INSTR_NOOP) {
      $self->{bytecode_offset} += $state->{instrsize};
    } elsif ($state->{opcode} == $Naigama::Instructions::INSTR_OPENCAPTURE) {
      $self->process_opencapture($state);
    } elsif ($state->{opcode} == $Naigama::Instructions::INSTR_PARTIALCOMMIT) {
      $self->process_partialcommit($state);
    } elsif ($state->{opcode} == $Naigama::Instructions::INSTR_QUAD) {
      $self->process_quad($state);
    } elsif ($state->{opcode} == $Naigama::Instructions::INSTR_RANGE) {
      $self->process_range($state);
    } elsif ($state->{opcode} == $Naigama::Instructions::INSTR_REPLACE) {
      ##..
    } elsif ($state->{opcode} == $Naigama::Instructions::INSTR_RET) {
      $self->process_ret($state);
    } elsif ($state->{opcode} == $Naigama::Instructions::INSTR_SET) {
      $self->process_set($state);
    } elsif ($state->{opcode} == $Naigama::Instructions::INSTR_SKIP) {
      $self->process_skip($state);
    } elsif ($state->{opcode} == $Naigama::Instructions::INSTR_SPAN) {
      $self->process_span($state);
    } elsif ($state->{opcode} == $Naigama::Instructions::INSTR_TESTANY) {
      $self->process_testany($state);
    } elsif ($state->{opcode} == $Naigama::Instructions::INSTR_TESTCHAR) {
      $self->process_testchar($state);
    } elsif ($state->{opcode} == $Naigama::Instructions::INSTR_TESTQUAD) {
      $self->process_testquad($state);
    } elsif ($state->{opcode} == $Naigama::Instructions::INSTR_TESTSET) {
      $self->process_testset($state);
    } elsif ($state->{opcode} == $Naigama::Instructions::INSTR_TRAP) {
      die "Trapped at byc=" . $state->{bytecode_offset} .
          " and inp=" . $state->{input_offset};
    } elsif ($state->{opcode} == $Naigama::Instructions::INSTR_VAR) {
      $self->process_var($state);
    } else {
      die "Bytecode corrupt or instruction pointer misaligned at " .
          $state->{bytecode_offset};
    }
    if ($state->{fail}) {
      $self->fail($state);
    }
  }
  $output->{exitcode} = $state->{exitcode};
  $output->{pinpoints} = $state->{pinpoints};
  $output->{captures} = pins_to_captures($state->{input}, $state->{pinpoints});
  $output->{tree} = captures_to_tree($output->{captures});
  return $output;
}

sub pins_to_captures
{
  my ($input, $pinpoints) = @_;
  my $result = [];
  for (my $i=0; $i < scalar(@{$pinpoints}); $i++) {
    my $p0 = $pinpoints->[ $i ];
    if ($p0->{type} eq 'OPEN') {
      my $level = 1;
      for (my $j = $i+1; $j < scalar(@{$pinpoints}); $j++) {
        my $p1 = $pinpoints->[ $j ];
        if ($p1->{type} eq 'OPEN') {
          ++$level;
        } elsif ($p1->{type} eq 'CLOSE') {
          if (--$level == 0) {
            if ($p0->{slot} ne $p1->{slot}) {
              die "Pinpoints list slot inconsistency";
            }
            push @{$result}, {
              type => 'CAPTURE',
              offset => $p0->{offset},
              length => $p1->{offset} - $p0->{offset},
              slot => $p0->{slot},
              string => substr(
                          $input,
                          $p0->{offset},
                          $p1->{offset} - $p0->{offset}),
            };
            last;
          }
        }
      }
    }
  }
  return $result;
}

sub captures_to_tree
{
  my ($captures) = @_;
  my $length = 0;
  foreach my $cap (@{$captures}) {
    if ($cap->{offset} + $cap->{length} > $length) {
      $length = $cap->{offset} + $cap->{length};
    }
  }
  my $result = { offset => 0, length => $length, children => [] };
  _captures_to_tree($captures, 0, $result);
  return $result;
}

sub _captures_to_tree
{
  my ($captures, $i, $parent) = @_;
  for (; $i < scalar(@{$captures}); $i++) {
    my $cap = $captures->[ $i ];
    if ($cap->{offset} >= $parent->{offset}
        && $cap->{offset} + $cap->{length}
           <= $parent->{offset} + $parent->{length}) {
      my $node = {
        offset => $cap->{offset},
        length => $cap->{length},
        string => $cap->{string},
        slot => $cap->{slot},
        children => [],
      };
      push @{$parent->{children}}, $node;
      $i = _captures_to_tree($captures, $i+1, $node) - 1;
    } else {
      return $i;
    }
  }
  return $i;
}

sub get_protected_quad
{
  my ($bytecode, $offset) = @_;
  return (
    (ord(substr($bytecode, $offset+1, 1)) << 16) |
    (ord(substr($bytecode, $offset+2, 1)) << 8) |
    (ord(substr($bytecode, $offset+3, 1)) & 0xff)
  );
}

sub fail
{
  my ($self, $state) = @_;
  if ($self->{debug}) {
    print STDERR "FAIL\n";
  }
  while (scalar(@{$state->{stack}})) {
    my $stackelt = pop(@{$state->{stack}});
    if ($stackelt->{type} eq 'ALT') {
      $state->{bytecode_offset} = $stackelt->{bytecode_offset};
      $state->{input_offset} = $stackelt->{input_offset};
      splice @{$state->{pinpoints}}, $stackelt->{pinpoints_length};
      $state->{fail} = 0;
      last;
    }
  }
  if (!(scalar(@{$state->{stack}}))) {
    die "Match failed.";
  }
}

sub process_any
{
  my ($self, $state) = @_;
  if ($state->{input_offset} == length($state->{input})) {
    $state->{fail} = 1;
  } else {
    ++($state->{input_offset});
    $state->{bytecode_offset} += $state->{instrsize};
  }
}

sub process_backcommit
{
  my ($self, $state) = @_;
  my $stackelt = pop(@{$state->{stack}}) || die "Stack undeflow at backcommit";
  if ($stackelt->{type} eq 'ALT') {
    $state->{bytecode_offset} = $stackelt->{bytecode_offset};
    $state->{inputoffset} = $stackelt->{input_offset};
    splice @{$state->{pinpoints}}, $stackelt->{pinpoints_length};
  } else {
    die "Stack corrupt in backcommit";
  }
}

sub process_call
{
  my ($self, $state) = @_;
  my $offset = get_protected_quad($self->{bytecode}, $state->{bytecode_offset} + 4);
  push @{$state->{stack}}, {
    type => 'CLL',
    bytecode_offset => $state->{bytecode_offset} + $state->{instrsize}
  };
  $state->{bytecode_offset} = $offset;
}

sub process_catch
{
  my ($self, $state) = @_;
  my $offset = get_protected_quad($self->{bytecode}, $state->{bytecode_offset} + 4);
  push @{$state->{stack}}, {
    type => 'ALT',
    bytecode_offset => $offset,
    input_offset => $state->{input_offset},
    pinpoints_length => scalar(@{$state->{pinpoints}})
  };
  $state->{bytecode_offset} += $state->{instrsize};
}

sub process_char
{
  my ($self, $state) = @_;
  my $chr = get_protected_quad($self->{bytecode}, $state->{bytecode_offset} + 4);
  if ($state->{input_offset} == length($state->{input})) {
    $state->{fail} = 1;
  } elsif (ord(substr($state->{input}, $state->{input_offset}, 1)) eq $chr) {
    ++($state->{input_offset});
    $state->{bytecode_offset} += $state->{instrsize};
  } else {
    $state->{fail} = 1;
  }
}

sub process_closecapture
{
  my ($self, $state) = @_;
  my $slot = get_protected_quad($self->{bytecode}, $state->{bytecode_offset} + 4);
  push @{$state->{pinpoints}}, {
    type => 'CLOSE',
    slot => $slot,
    offset => $state->{input_offset}
  };
  $state->{bytecode_offset} += $state->{instrsize};
}

sub process_commit
{
  my ($self, $state) = @_;
  my $offset = get_protected_quad($self->{bytecode}, $state->{bytecode_offset} + 4);
  my $stackelt = pop(@{$state->{stack}}) || die "Stack underflow at commit";
  if ($stackelt->{type} eq 'ALT') {
    $state->{bytecode_offset} = $offset;
  } else {
    die "Stack corrupt at commit";
  }
}

sub process_condjump
{
  my ($self, $state) = @_;
  my $counter = get_protected_quad($self->{bytecode}, $state->{bytecode_offset} + 4);
  my $offset = get_protected_quad($self->{bytecode}, $state->{bytecode_offset} + 8);
  my $value = counter_resolve($state, $counter);
  if ($value > 0) {
    $state->{bytecode_offset} = $offset;
  } else {
    $state->{bytecode_offset} += $state->{instrsize};
  }
}

sub process_counter
{
  my ($self, $state) = @_;
  my $counter = get_protected_quad($self->{bytecode}, $state->{bytecode_offset} + 4);
  my $value = get_protected_quad($self->{bytecode}, $state->{bytecode_offset} + 8);
  counter_push($state, $counter, $value);
  $state->{bytecode_offset} += $state->{instrsize};
}

sub process_end
{
  my ($self, $state) = @_;
  my $exitcode = get_protected_quad($self->{bytecode}, $state->{bytecode_offset} + 4);
  $state->{exitcode} = $exitcode;
  $state->{end} = 1;
}

sub process_failtwice
{
  my ($self, $state) = @_;
  my $stackelt = pop(@{$state->{stack}}) || die "Stack underflow at failtwice";
  if ($stackelt->{type} eq 'ALT') {
    $state->{fail} = 1;
  } else {
    die "Stack corrupt at failtwice";
  }
}

sub process_jump
{
  my ($self, $state) = @_;
  my $offset = get_protected_quad($self->{bytecode}, $state->{bytecode_offset} + 4);
  $state->{bytecode_offset} = $offset;
}

sub process_maskedchar
{
  my ($self, $state) = @_;
  my $outcome = get_protected_quad($self->{bytecode}, $state->{bytecode_offset} + 4);
  my $mask = get_protected_quad($self->{bytecode}, $state->{bytecode_offset} + 8);
  if ($state->{input_offset} == length($state->{input})) {
    $state->{fail} = 1;
  } elsif ((ord(substr($state->{input}, $state->{input_offset}, 1)) & $mask) == $outcome) {
    ++($state->{input_offset});
    $state->{bytecode_offset} += $state->{instrsize};
  } else {
    $state->{fail} = 1;
  }
}

sub process_opencapture
{
  my ($self, $state) = @_;
  my $slot = get_protected_quad($self->{bytecode}, $state->{bytecode_offset} + 4);
  push @{$state->{pinpoints}}, {
    type => 'OPEN',
    slot => $slot,
    offset => $state->{input_offset}
  };
  $state->{bytecode_offset} += $state->{instrsize};
}

sub process_partialcommit
{
  my ($self, $state) = @_;
  my $offset = get_protected_quad($self->{bytecode}, $state->{bytecode_offset} + 4);
  die "Stack underflow at partialcommit" if (!scalar(@{$state->{stack}}));
  my $stackelt = $state->{stack}[-1];
  if ($stackelt->{type} eq 'ALT') {
    $stackelt->{input_offset} = $state->{input_offset};
    $stackelt->{pinpoints_length} = scalar(@{$state->{pinpoints}});
    $state->{bytecode_offset} = $offset;
  } else {
    die "Stack corrupt at partialcommit";
  }
}

sub process_quad
{
  my ($self, $state) = @_;
  if ($state->{input_offset} + 4 > length(@{$state->{input}})) {
    $state->{fail} = 1;
  } elsif (substr($state->{input}, $state->{input_offset}, 4) ne
           substr($self->{bytecode}, $state->{bytecode_offset} + 4, 4))
  {
    $state->{fail} = 1;
  } else {
    $state->{input_offset} += 4;
    $state->{bytecode_offset} += $state->{instrsize};
  }
}

sub process_range
{
  my ($self, $state) = @_;
  my $from = get_protected_quad($self->{bytecode}, $state->{bytecode_offset} + 4);
  my $to = get_protected_quad($self->{bytecode}, $state->{bytecode_offset} + 8);
  if ($state->{input_offset} <= length(@{$state->{input}})) {
    my $chr = ord(substr($state->{input}, $state->{input_offset}, 1));
    if ($chr >= $from && $chr <= $to) {
      ++($state->{input_offset});
      $state->{bytecode_offset} += $state->{instrsize};
    } else {
      $state->{fail} = 1;
    }
  } else {
    $state->{fail} = 1;
  }
}

sub process_ret
{
  my ($self, $state) = @_;
  my $stackelt = pop(@{$state->{stack}}) || die "Stack underflow at ret";
  if ($stackelt->{type} eq 'CLL') {
    $state->{bytecode_offset} = $stackelt->{bytecode_offset};
  } else {
    die "Stack corrupt at ret";
  }
}

sub process_set
{
  my ($self, $state) = @_;
  if ($state->{input_offset} == length($state->{input})) {
    $state->{fail} = 1;
  } else {
    my $setoff = $state->{bytecode_offset} + 4;
    my $bitoff = ord(substr($state->{input}, $state->{input_offset}, 1));
    my $setbyte = ord(substr($self->{bytecode}, $setoff + ($bitoff / 8)));
    my $setbit = (($setbyte >> ($bitoff % 8)) & 0x01);
    if ($setbit) {
      $state->{bytecode_offset} += $state->{instrsize};
      ++($state->{input_offset});
    } else {
      $state->{fail} = 1;
    }
  }
}

sub process_skip
{
  my ($self, $state) = @_;
  my $steps = get_protected_quad($self->{bytecode}, $state->{bytecode_offset} + 4);
  if ($state->{input_offset} + $steps > length(@{$state->{input}})) {
    $state->{fail} = 1;
  } else {
    $state->{input_offset} += $steps;
    $state->{bytecode_offset} += $state->{instrsize};
  }
}

sub process_span
{
  my ($self, $state) = @_;
  while ($state->{input_offset} < length($state->{input})) {
    my $setoff = $state->{bytecode_offset} + 4;
    my $bitoff = ord(substr($state->{input}, $state->{input_offset}, 1));
    my $setbyte = ord(substr($self->{bytecode}, $setoff + ($bitoff / 8)));
    my $setbit = (($setbyte >> ($bitoff % 8)) & 0x01);
    if ($setbit) {
      ++($state->{input_offset});
    } else {
      last;
    }
  }
  $state->{bytecode_offset} += $state->{instrsize};
}

sub process_testany
{
  my ($self, $state) = @_;
  my $offset = get_protected_quad($self->{bytecode}, $state->{bytecode_offset} + 4);
  if ($state->{input_offset} == length($state->{input})) {
    $state->{bytecode_offset} = $offset;
  } else {
    ++($state->{input_offset});
    $state->{bytecode_offset} += $state->{instrsize};
  }
}

sub process_testchar
{
  my ($self, $state) = @_;
  my $offset = get_protected_quad($self->{bytecode}, $state->{bytecode_offset} + 4);
  my $chr = get_protected_quad($self->{bytecode}, $state->{bytecode_offset} + 8);
  if ($state->{input_offset} == length($state->{input})) {
    $state->{bytecode_offset} = $offset;
  } elsif (ord(substr($state->{input}, $state->{input_offset}, 1)) eq $chr) {
    ++($state->{input_offset});
    $state->{bytecode_offset} += $state->{instrsize};
  } else {
    $state->{bytecode_offset} = $offset;
  }
}

sub process_testquad
{
  my ($self, $state) = @_;
  my $offset = get_protected_quad($self->{bytecode}, $state->{bytecode_offset} + 4);
  if ($state->{input_offset} + 4 > length(@{$state->{input}})) {
    $state->{bytecode_offset} = $offset;
  } elsif (substr($state->{input}, $state->{input_offset}, 4) ne
           substr($self->{bytecode}, $state->{bytecode_offset} + 8, 4))
  {
    $state->{bytecode_offset} = $offset;
  } else {
    $state->{input_offset} += 4;
    $state->{bytecode_offset} += $state->{instrsize};
  }
}

sub process_testset
{
  my ($self, $state) = @_;
  my $offset = get_protected_quad($self->{bytecode}, $state->{bytecode_offset} + 4);
  if ($state->{input_offset} == length($state->{input})) {
    $state->{bytecode_offset} = $offset;
  } else {
    my $setoff = $state->{bytecode_offset} + 8;
    my $bitoff = ord(substr($state->{input}, $state->{input_offset}, 1));
    my $setbyte = ord(substr($self->{bytecode}, $setoff + ($bitoff / 8)));
    my $setbit = (($setbyte >> ($bitoff % 8)) & 0x01);
    if ($setbit) {
      $state->{bytecode_offset} += $state->{instrsize};
      ++($state->{input_offset});
    } else {
      $state->{bytecode_offset} = $offset;
    }
  }
}

sub process_var
{
  my ($self, $state) = @_;
}

1;
