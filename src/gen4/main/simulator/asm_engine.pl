#!/usr/bin/perl

use Data::Dumper;

my $file = shift @ARGV;
my $asm = `cat $file`;
my @lines = split(/\n/, $asm);

zeroth_pass(\@lines);

my $lineno = 0;
my $labelmap = {};
my @stack;
my $lastfunc = 0;
my $output = '';
my $endcode;

while ($lineno >= 0 && $lineno < scalar(@lines)) {
  my $line = $lines[ $lineno ];

  print STDERR "    STACK (lastfunc=$lastfunc):\n";
  for (my $i=0; $i < scalar(@stack); $i++) {
    my $elt = $stack[$i];
    print STDERR "      $i: $elt->{type} $elt->{param1}";
    if ($elt->{type} eq 'REGREF') {
      my $atom = register_read($elt->{param1});
      print STDERR " { $atom->{type}:$atom->{param1} }";
    }
    print STDERR "\n";
  }
  print STDERR "At $lineno: $line\n";

  if ($line =~ /^scr_call\s+(.*)$/) {
    my $label = $1;
    stack_push('CALL', $lineno + 1);
    $lineno = resolve_label("__FUNC_$label");
    next;

  } elsif ($line =~ /^scr_builtin\s+([0-9]+)$/) {
    my $func = $1;
    if ($func eq '1') {
      my $top0 = pop @stack;
      my $top1 = pop @stack;
      $output .= $top0->{param1};
      push @stack, $top0;
    } else {
      die "Unknown built-in function code $func";
    }

  } elsif ($line =~ /^scr_push\s+(.*)$/) {
    my $arg = $1;
    if ($arg eq 'void') {
      stack_push('VOID');
    } elsif ($arg =~ /^string\s+(.*)$/) {
      my $stringlabel = $1;
      my $stringoffset = resolve_label($stringlabel);
      for (; $stringoffset < scalar(@lines); $stringoffset++) {
        if ($lines[ $stringoffset ] =~ /^scr_string '(.*)'$/) {
          stack_push('STRING', $1);
        }
      }
    } elsif ($arg =~ /^[0-9]+$/) {
      stack_push('INT', $arg);
    } elsif ($arg =~ /^{\s*(-?[0-9]+)\s*}/) {
      stack_push('REGREF', $1);
    } else {
      die "WARNING: UNKNOWN PUSH '$arg'\n";
    }

  } elsif ($line =~ /^mode\s+([0-9]+)$/) {
    ##.. ignore

  } elsif ($line =~ /^scr_pop$/) {
    pop @stack;

  } elsif ($line =~ /^scr_shift\s+([0-9]+)$/) {
    my $n = int($1);
    if ($n) {
      my $elt = pop @stack;
      splice @stack, -$n, 0, $elt;
      if ($elt->{type} eq 'CALL') {
        for (my $i=0; $i < $n; $i++) {
          $stack[ -($i+1) ] = copy($stack[ -($i+1) ]);
        }
        $lastfunc = scalar(@stack) - $n;
      }
    }

  } elsif ($line =~ /^scr_add/) {
    my $top0 = pop @stack;
    my $top1 = pop @stack;
    if ($top0->{type} eq 'STRING' || $top1->{type} eq 'STRING') {
      my $cop0 = copy($top0);
      my $cop1 = copy($top1);
      stack_push('STRING', $cop1->{param1} . $cop0->{param1});
    } else {
      stack_push('INT', numvalue($top1) + numvalue($top0));
    }

  } elsif ($line =~ /^scr_sub/) {
    my $top0 = pop @stack;
    my $top1 = pop @stack;
    stack_push('INT', numvalue($top1) - numvalue($top0));

  } elsif ($line =~ /^scr_mul/) {
    my $top0 = pop @stack;
    my $top1 = pop @stack;
    stack_push('INT', numvalue($top1) * numvalue($top0));

  } elsif ($line =~ /^scr_div/) {
    my $top0 = pop @stack;
    my $top1 = pop @stack;
    stack_push('INT', numvalue($top1) / numvalue($top0));

  } elsif ($line =~ /^scr_lt/) {
    my $top0 = pop @stack;
    my $top1 = pop @stack;
    stack_push('BOOL', int(numvalue($top1) < numvalue($top0)));

  } elsif ($line =~ /^scr_equals/) {
    my $top0 = pop @stack;
    my $top1 = pop @stack;
    stack_push('BOOL', numvalue($top1) == numvalue($top0));

  } elsif ($line =~ /^scr_assign/) {
    my $top0 = pop @stack;
    my $top1 = pop @stack;
    die "Assignment not to a register" if ($top0->{type} ne 'REGREF');
    register_write($top0->{param1}, $top1);

  } elsif ($line =~ /^scr_condjump\s+(.*)$/) {
    my $top0 = pop @stack;
    if (!(numvalue($top0))) {
      $lineno = resolve_label($1);
      next;
    }

  } elsif ($line =~ /^jump\s+(.*)$/) {
    $lineno = resolve_label($1);
    next;

  } elsif ($line =~ /^jump\s+(.*)$/) {
    $lineno = resolve_label($1);
    next;

  } elsif ($line =~ /^scr_ret$/) {
    my ($topcall, $belowcall, $jumpoffset);
    for (my $i=scalar(@stack); $i > 0; $i--) {
      if ($stack[ $i-1 ]->{type} eq 'CALL') {
        if (!defined($topcall)) {
          $topcall = $i-1;
          $jumpoffset = $stack[ $i-1 ]->{param1};
        } else {
          $belowcall = $i-1;
          last;
        }
      }
    }
    my $retval = copy( $stack[ $lastfunc ] );
    splice @stack, $lastfunc-1;
    push @stack, $retval;
    $lastfunc = $belowcall + 1;
    $lineno = $jumpoffset;
    next;

  } elsif ($line =~ /^end(\s+([0-9]+))?/) {
    $endcode = $2 || '0';
    print STDERR "End with code $endcode\n";
    last;

  } elsif ($line =~ /^([A-Za-z0-9_]+):/) {
    $labelmap{$1} = $lineno;

  } elsif (length($line)) {
    die "WARNING: UNKNOWN OPCODE $line\n";
  }
  ++$lineno;
}

print STDERR
  "Breaking out of processing loop.\n" .
  "ENDCODE=$endcode\n" .
  "OUTPUT IS $output\n";

exit 0;

##---- functions ----------------------------------------------------------##

sub zeroth_pass
{
  my $lines = shift;
  foreach my $line (@{$lines}) {
    $line =~ s/--.*$//;
    $line =~ s/\s+$//;
    $line =~ s/^\s+//;
  }
}

sub stack_push
{
  my ($type, $param1) = @_;
  push @stack, { type => $type, param1 => $param1 };
}

sub resolve_label
{
  my $label = shift;
  if (defined(my $line = $labelmap->{$label})) {
    return $line;
  } else {
    for (my $i=0; $i < scalar(@lines); $i++) {
      if ($lines[ $i ] =~ /^$label:/) {
        $labelmap->{$label} = $i;
        return $i;
      }
    }
  }
  die "Could not resolve label '$label'";
}

sub numvalue
{
  my $stackelt = shift;
  if ($stackelt->{type} eq 'INT') { return $stackelt->{param1}; }
  if ($stackelt->{type} eq 'BOOL') { return $stackelt->{param1}; }
  if ($stackelt->{type} eq 'VOID') { return 0; }
  if ($stackelt->{type} eq 'REGREF') {
    return numvalue( register_read($stackelt->{param1}) );
  }
  die "Unknown stack element type $stackelt->{type}";
}

sub register_offset
{
  my ($regnum) = @_;
  if ($regnum < 0) {
    return -($regnum+1);
  } else {
    return $lastfunc + $regnum;
  }
}

sub register_write
{
  my ($regnum, $value) = @_;
  $stack[ register_offset($regnum) ] = $value;
}

sub register_read
{
  my ($regnum) = @_;
  return $stack[ register_offset($regnum) ];
}

sub copy
{
  my $elt = shift;
  if ($elt->{type} eq 'REGREF') {
    return $stack[ register_offset( $elt->{param1} ) ];
  } else {
    return $elt;
  }
}

1;
