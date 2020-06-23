#!/usr/bin/perl

use Data::Dumper;

my ($inputfile, $outputfile) = ( '-', '-' );

my $labelcount = 0;
my $counter = 0;
my $slot = 0;
my $prefixset = 0;
my $slotmapfile;
my %slotmap;
my $currentrule;

while (my $arg = shift @ARGV) {
  if ($arg =~ s/^-//) {
    while ($arg =~ s/^(.)//) {
      my $option = $1;
      if ($option eq 'i') {
        $inputfile = shift @ARGV;
      } elsif ($option eq 'o') {
        $outputfile = shift @ARGV;
      } elsif ($option eq 's') {
        my $path = shift @ARGV;
        open $slotmapfile, '>', $path
          || die "Could not open slotmapfile $path";
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

compile($input);

if ($slotmapfile) {
  slotmap_write();
}

exit 0;

##---- functions --------------------------------------------------##

sub compile
{
  my $grammar = shift;
  my @tokens = tokenize($grammar);
  shuffle_rules(\@tokens);
  foreach my $rule (@tokens) { shuffle_brackets($rule->{chunk}); }
  foreach my $rule (@tokens) { shuffle_prefixes($rule->{chunk}); }
  foreach my $rule (@tokens) { shuffle_choices($rule->{chunk}); }
  #print STDERR Dumper \@tokens;
  output_assembly(\@tokens);
}

sub tokenize {
  my $grammar = shift;
  my @tokens;
  my $ident = '[a-zA-Z_][a-zA-Z_0-9]{0,63}';
  while (length($grammar)) {
    if ($grammar =~ s/^(\s+|--[^\n]*\n)//) {
    } elsif ($grammar =~ s/^($ident)\s*<-*//) {
      push @tokens, { type => 'rule', str => $1 };
    } elsif ($grammar =~ s/^($ident)//) {
      push @tokens, { type => 'ref', str => $1 };
    } elsif ($grammar =~ s/^\(//) {
      push @tokens, { type => 'bopen' };
    } elsif ($grammar =~ s/^\)//) {
      push @tokens, { type => 'bclose' };
    } elsif ($grammar =~ s/^\{//) {
      push @tokens, { type => 'cbopen' };
    } elsif ($grammar =~ s/^\}//) {
      my $recycler;
      if ($grammar =~ s/^\s*=>\s*($ident)//) {
        $recycler = $1;
      }
      push @tokens, { type => 'cbclose', recycler => $recycler };
    } elsif ($grammar =~ s/^\///) {
      push @tokens, { type => 'or' };
    } elsif ($grammar =~ s/^\.//) {
      push @tokens, { type => 'dot' };
    } elsif ($grammar =~ s/^!//) {
      push @tokens, { type => 'not' };
    } elsif ($grammar =~ s/^\&//) {
      push @tokens, { type => 'and' };
    } elsif ($grammar =~ s/^([+])//) {
      my $prev = pop @tokens || die "Quantifier before token";
      die "Token already has quantifier" if (defined($prev->{quantifier}));
      $prev->{quantifier} = { from => 1, until => undef };
      push @tokens, $prev;
    } elsif ($grammar =~ s/^([?])//) {
      my $prev = pop @tokens || die "Quantifier before token";
      die "Token already has quantifier" if (defined($prev->{quantifier}));
      $prev->{quantifier} = { from => 0, until => 1 };
      push @tokens, $prev;
    } elsif ($grammar =~ s/^([*])//) {
      my $prev = pop @tokens || die "Quantifier before token";
      die "Token already has quantifier" if (defined($prev->{quantifier}));
      $prev->{quantifier} = { from => 0, until => undef };
      push @tokens, $prev;
    } elsif ($grammar =~ s/^\^([0-9]+)-([0-9]+)//) {
      my $prev = pop @tokens || die "Quantifier before token";
      die "Token already has quantifier" if (defined($prev->{quantifier}));
      $prev->{quantifier} = { from => $1, until => $2 };
      push @tokens, $prev;
    } elsif ($grammar =~ s/^\^-([0-9]+)//) {
      my $prev = pop @tokens || die "Quantifier before token";
      die "Token already has quantifier" if (defined($prev->{quantifier}));
      $prev->{quantifier} = { from => 0, until => $1 };
      push @tokens, $prev;
    } elsif ($grammar =~ s/^\^([0-9]+)-//) {
      my $prev = pop @tokens || die "Quantifier before token";
      die "Token already has quantifier" if (defined($prev->{quantifier}));
      $prev->{quantifier} = { from => $1, until => undef };
      push @tokens, $prev;
    } elsif ($grammar =~ s/^\^([0-9]+)//) {
      my $prev = pop @tokens || die "Quantifier before token";
      die "Token already has quantifier" if (defined($prev->{quantifier}));
      $prev->{quantifier} = { from => $1, until => $1 };
      push @tokens, $prev;
    } elsif ($grammar =~ s/^\^\$($ident)//) {
      my $prev = pop @tokens || die "Quantifier before token";
      die "Token already has quantifier" if (defined($prev->{quantifier}));
      $prev->{quantifier} = { dynamic => 1, amount => $1 };
      push @tokens, $prev;
    } elsif ($grammar =~ s/^'//) {
      my $string = consume_string(\$grammar);
      push @tokens, { type => 'string', str => $string };
    } elsif ($grammar =~ s/^\[//) {
      my $string = consume_set(\$grammar);
      push @tokens, { type => 'set', str => $string };
    } elsif ($grammar =~ s/^\%//) {
      $grammar =~ s/^([a-z]+)//;
      push @tokens, { type => 'macro', str => $1 };
    } else {
      die "Unknown token at $grammar";
    }
  }
  return @tokens;
}

sub consume_string
{
  my $grammar = shift;
  my $str = '';
  while (length($$grammar)) {
    $$grammar =~ s/^(.)//s;
    my $chr = $1;
    if ($chr eq '\\') {
      $$grammar =~ s/^(.)//s || die "Grammar ended at escape";
      my $esc = $1;
      if ($esc eq 'n') { $str .= "\n"; }
      elsif ($esc eq 'r') { $str .= "\r"; }
      elsif ($esc eq 't') { $str .= "\t"; }
      elsif ($esc eq 'v') { $str .= chr(11); }
      else { $str .= $esc; }
    } elsif ($chr eq '\'') {
      return $str;
    } else {
      $str .= $chr;
    }
  }
  die "Grammar ended before end of string";
}

sub consume_set
{
  my $grammar = shift;
  my $str = '';
  while (length($$grammar)) {
    $$grammar =~ s/^(.)//s;
    my $chr = $1;
    if ($chr eq '\\') {
      $$grammar =~ s/^(.)//s || die "Grammar ended at escape";
      $str .= '\\' . $1;
    } elsif ($chr eq ']') {
      return $str;
    } else {
      $str .= $chr;
    }
  }
  die "Grammar ended before end of string";
}

sub shuffle_rules
{
  my $tokens = shift;
  for (my $i=0; $i < scalar(@{$tokens}); $i++) {
    my $token = $tokens->[ $i ];
    if ($token->{type} eq 'rule') {
      for (my $j = $i+1; $j < scalar(@{$tokens}); $j++) {
        my $matchtok = $tokens->[ $j ];
        if ($matchtok->{type} eq 'rule') {
          my @chunk = splice @{$tokens}, $i+1, ($j - ($i+1));
          $token->{chunk} = \@chunk;
          last;
        } elsif ($j == scalar(@{$tokens})-1) {
          my @chunk = splice @{$tokens}, $i+1, ($j - $i);
          $token->{chunk} = \@chunk;
          last;
        }
      }
    }
  }
}

sub shuffle_brackets
{
  my $tokens = shift;
  for (my $i=0; $i < scalar(@{$tokens}); $i++) {
    my $token = $tokens->[ $i ];
    if ($token->{type} eq 'cbopen') {
      my $level = 1;
      for (my $j = $i+1; $j < scalar(@{$tokens}); $j++) {
        my $matchtok = $tokens->[ $j ];
        if ($matchtok->{type} eq 'cbopen') {
          ++$level;
        } elsif ($matchtok->{type} eq 'cbclose') {
          --$level;
          if ($level eq '0') {
            my @chunk = splice @{$tokens}, $i + 1, ($j - $i);
            $tokens->[ $i ]{chunk} = \@chunk;
            $tokens->[ $i ]{quantifier} = $chunk[ -1 ]->{quantifier};
            shuffle_brackets(\@chunk);
            last;
          }
        }
      }
    } elsif ($token->{type} eq 'bopen') {
      my $level = 1;
      for (my $j = $i+1; $j < scalar(@{$tokens}); $j++) {
        my $matchtok = $tokens->[ $j ];
        if ($matchtok->{type} eq 'bopen') {
          ++$level;
        } elsif ($matchtok->{type} eq 'bclose') {
          --$level;
          if ($level eq '0') {
            my @chunk = splice @{$tokens}, $i + 1, ($j - $i);
            $tokens->[ $i ]{chunk} = \@chunk;
            $tokens->[ $i ]{quantifier} = $chunk[ -1 ]->{quantifier};
            shuffle_brackets(\@chunk);
            last;
          }
        }
      }
    }
  }
}

sub shuffle_prefixes
{
  my $tokens = shift;
  my $prefix = [];
  for (my $i=0; $i < scalar(@{$tokens}); $i++) {
    my $token = $tokens->[ $i ];
    if ($token->{type} eq 'not' || $token->{type} eq 'and') {
      push @{$prefix}, $token;
      splice @{$tokens}, $i, 1;
      --$i;
    } else {
      if (scalar(@{$prefix})) {
        $token->{prefix} = $prefix;
      }
      $prefix = [];
      if ($token->{type} eq 'cbopen') {
        shuffle_prefixes($token->{chunk});
      } elsif ($token->{type} eq 'bopen') {
        shuffle_prefixes($token->{chunk});
      }
    }
  }
}

sub shuffle_choices
{
  my $tokens = shift;
  for (my $i=0; $i < scalar(@{$tokens}); $i++) {
    my $token = $tokens->[ $i ];
    if ($token->{type} eq 'or') {
      my @righthand = splice @{$tokens}, $i + 1;
      my @lefthand = splice @{$tokens}, 0, $i;
      $token->{lefthand} = \@lefthand;
      $token->{righthand} = \@righthand;
      shuffle_choices(\@righthand);
      last;
    } elsif ($token->{type} eq 'cbopen') {
      shuffle_choices($token->{chunk});
    } elsif ($token->{type} eq 'bopen') {
      shuffle_choices($token->{chunk});
    }
  }
}

sub output_assembly
{
  my $tokens = shift;
  for (my $i=0; $i < scalar(@{$tokens}); $i++) {
    my $token = $tokens->[ $i ];
    if ($token->{type} eq 'rule') {
      if ($i == 0) {
        print $out
          "  call __RULE_$token->{str}\n" .
          "  end 0\n";
      }
      output_asm_rule($token->{str}, $token->{chunk});
      if ($token->{str} eq '__prefix') {
        $prefixset = 1;
      }
    } else {
      die "Unexpected token at $i";
    }
  }
}

sub output_asm_rule
{
  my ($name, $tokens) = @_;
  $currentrule = $name;
  print $out
    "__RULE_$name:\n";
  if ($prefixset) {
    print $out
      "  call __RULE___prefix\n";
  }
  output_asm_tokens($tokens);
  print $out
    "  ret\n";
}

sub output_asm_tokens
{
  my $tokens = shift;
  for (my $i=0; $i < scalar(@{$tokens}); $i++) {
    my $token = $tokens->[ $i ];
    if ($token->{type} eq 'ref') {
      output_asm_term($token, 'ref');
    } elsif ($token->{type} eq 'macro') {
      output_asm_term($token, 'macro');
    } elsif ($token->{type} eq 'bopen') {
      output_asm_term($token, 'bopen');
    } elsif ($token->{type} eq 'cbopen') {
      output_asm_term($token, 'cbopen');
    } elsif ($token->{type} eq 'string') {
      output_asm_term($token, 'string');
    } elsif ($token->{type} eq 'set') {
      output_asm_term($token, 'set');
    } elsif ($token->{type} eq 'dot') {
      output_asm_term($token, 'dot');
    } elsif ($token->{type} eq 'or') {
      my $rhlabel = "__RIGHTHAND_$labelcount";
      my $sulabel = "__SUCCESS_$labelcount";
      ++$labelcount;
      print $out
        "  catch $rhlabel\n";
      output_asm_tokens($token->{lefthand});
      print $out
        "  commit $sulabel\n" .
        "$rhlabel:\n";
      output_asm_tokens($token->{righthand});
      print $out
        "$sulabel:\n";
    } elsif ($token->{type} eq 'bclose') {
      ##.. ignore
    } elsif ($token->{type} eq 'cbclose') {
      if (defined($token->{recycler})) {
        print $out
          "  isolate __RULE_$token->{recycler}\n";
      }
    } else {
      die "Unknown token type $token->{type}";
    }
  }
}

sub output_asm_term
{
  my ($token, $func) = @_;
  my $prefixlabel = "__PREFIX_$labelcount"; ++$labelcount;
  my $counterlabel = "__COUNTER_$labelcount"; ++$labelcount;
  my $counter2label = "__COUNTER_$labelcount"; ++$labelcount;
  my $endlesslabel = "__ENDLESS_$labelcount"; ++$labelcount;
  my $forgivelabel = "__FORGIVE_$labelcount"; ++$labelcount;
  my $reverselabel = "__REVERSE_$labelcount"; ++$labelcount;
  my $somelabel = "__USELESS_$labelcount"; ++$labelcount;
  if (scalar(@{$token->{prefix}})) {
    print $out "  catch $prefixlabel\n";
  }
  if (!defined($token->{quantifier})) {
    $token->{quantifier}{from} = 1;
    $token->{quantifier}{until} = 1;
  }
  if (defined($token->{quantifier}{dynamic})) {
     
  }
  if ($token->{quantifier}{from} eq '1') {
    output_asm_term_once($token, $func);
  } elsif ($token->{quantifier}{from} > 1) {
    print $out
      "  counter $counter $token->{quantifier}{from}\n" .
      "$counterlabel:\n";
    output_asm_term_once($token, $func);
    print $out
      "  condjump $counter $counterlabel\n";
    ++$counter;
  }
  if ($token->{quantifier}{until} eq undef) {
    print $out
      "  catch $forgivelabel\n" .
      "$endlesslabel:\n";
    output_asm_term_once($token, $func);
    print $out
      "  partialcommit $endlesslabel\n" .
      "$forgivelabel:\n";
  } elsif ($token->{quantifier}{until} > $token->{quantifier}{from}) {
    my $diff = $token->{quantifier}{until} - $token->{quantifier}{from};
    if ($diff > 1) {
      print $out
        "  catch $forgivelabel\n" .
        "  counter $counter $diff\n" .
        "$counter2label:\n";
      output_asm_term_once($token, $func);
      print $out
        "  partialcommit $somelabel\n" .
        "$somelabel:\n" .
        "  condjump $counter $counter2label\n" .
        "  commit $forgivelabel\n" .
        "$forgivelabel:\n";
    } else {
      print $out
        "  catch $forgivelabel\n";
      output_asm_term_once($token, $func);
      print $out
        "  commit $forgivelabel\n" .
        "$forgivelabel:\n";
    }
  } elsif ($token->{quantifier}{until} ne $token->{quantifier}{from}) {
    die "Quantifier until smaller than from";
  }
  if (scalar(@{$token->{prefix}})) {
    if ($token->{prefix}[ 0 ]{type} eq 'not') {
      print $out
        "  failtwice\n" .
        "$prefixlabel:\n";
    } else {
      print $out
        "  backcommit $reverselabel\n" .
        "$prefixlabel:\n" .
        "  fail\n" .
        "$reverselabel:\n";
    }
  }
}

sub output_asm_term_once
{
  my ($token, $func) = @_;
  my $fnc = "_output_asm_$func";
  &$fnc($token);
}

sub _output_asm_macro
{
  my $token = shift;
  if ($token->{str} eq 's') {
    output_asm_set(
      { range => [
        [ ord("\n") ],
        [ ord("\r") ],
        [ ord("\t") ],
        [ 11 ], # \v
        [ ord(" ") ]
      ] }
    );
  } else {
    die "Unknown macro '\%$token->{str}'";
  }
}

sub _output_asm_bopen
{
  my $token = shift;
  output_asm_tokens($token->{chunk});
}

sub slotmap_substring
{
  my $tokens = shift;
  my $str = '';
  foreach my $sub (@{$tokens}) {
    $str .= $sub->{str};
    if (defined($sub->{chunk})) {
      $str .= slotmap_substring($sub->{chunk});
    } elsif (defined($sub->{lefthand})) {
      $str .= slotmap_substring($sub->{lefthand});
      $str .= slotmap_substring($sub->{righthand});
    }
  }
  return $str;
}

sub slotmap_put
{
  my ($token, $slot) = @_;
  my $str = "$currentrule";
  $str =~ s/[^a-zA-Z]/_/g;
  $str = uc($str);
  $str .= '_';
  my $add = slotmap_substring($token->{chunk});
  $add =~ s/[^a-zA-Z]//g;
  $add = uc($add);
  $str .= $add;
  if (defined($slotmap{$str})) {
    my $cnt = 1;
    while (1) {
      my $alt = $str . '_' . $cnt;
      if (!defined($slotmap{$alt})) {
        $str = $alt;
        last;
      }
      ++$cnt;
    }
  }
  $slotmap{$str} = $slot;
}

sub slotmap_write
{
  foreach my $key (sort(keys(%slotmap))) {
    my $slot = $slotmap{$key};
    syswrite $slotmapfile, pack('N', $slot);
    syswrite $slotmapfile, pack('N', 0xffffffff);
    syswrite $slotmapfile, $key;
    syswrite $slotmapfile, chr(0);
  }
}

sub _output_asm_cbopen
{
  my $token = shift;
  if (!defined($token->{slot})) {
    $token->{slot} = $slot;
    slotmap_put($token, $slot);
    ++$slot;
  }
  print $out
    "  opencapture $token->{slot}\n";
  output_asm_tokens($token->{chunk});
  print $out
    "  closecapture $token->{slot}\n";
}

sub _output_asm_string
{
  my $token = shift;
  my $str = "$token->{str}";
  while (length($str)) {
    if ($str =~ s/^(.)(.)(.)(.)//s) {
      print $out
        sprintf("  quad %.2x%.2x%.2x%.2x\n",
          ord($1), ord($2), ord($3), ord($4)
        );
    } else {
      $str =~ s/^(.)//s;
      print $out
        sprintf("  char %.2x\n", ord($1));
    }
  }
}

sub output_asm_set
{
  my $set = shift;
  my $setstr = set_string($set);
  print $out
    "  set $setstr\n";
}

sub _output_asm_set
{
  my $token = shift;
  if (!defined($token->{set})) {
    $token->{set} = compile_set($token->{str});
  }
  output_asm_set($token->{set});
}

sub set_push
{
  my ($set, $ord) = @_;
  if ($set->{state} eq '-') {
    push @{$set->{range}[ -1 ]}, $ord;
    $set->{state} = '';
  } else {
    push @{$set->{range}}, [ $ord ];
  }
}

sub compile_set
{
  my $str = shift;
  my $set = { };
  if ($str =~ s/^\^//) {
    $set->{negative} = 1;
  }
  while (length($str)) {
    if ($str =~ s/^\\//) {
      $str =~ s/^(.)//s || die "Escape in set '$str' unfinished";
      my $esc = $1;
      if ($esc eq 'n') {
        set_push($set, ord("\n"));
      } elsif ($esc eq 'r') {
        set_push($set, ord("\r"));
      } elsif ($esc eq 't') {
        set_push($set, ord("\t"));
      } elsif ($esc =~ /[0-9]/) {
        $str =~ s/^([0-9][0-9])// || die "Octal escape in set unfinished";
        my $oct = "$esc$1";
##..
      } else {
        set_push($set, ord($esc));
      }
    } else {
      $str =~ s/^(.)//s;
      my $chr = $1;
      if ($chr eq '-' && $set->{state} ne '-') {
        $set->{state} = '-';
      } else {
        set_push($set, ord($chr));
      }
    }
  }
  return $set;
}

sub set_string
{
  my $set = shift;
  my @mask = (
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  );
  if ($set->{negative}) {
     @mask = (
      255, 255, 255, 255, 255, 255, 255, 255,
      255, 255, 255, 255, 255, 255, 255, 255,
      255, 255, 255, 255, 255, 255, 255, 255,
      255, 255, 255, 255, 255, 255, 255, 255
    );
  }
  foreach my $elt (@{$set->{range}}) {
    if (scalar(@{$elt}) == 1) {
      if ($set->{negative}) {
        $mask[ $elt->[ 0 ] / 8 ] &= ~(1 << ($elt->[ 0 ] % 8));
      } else {
        $mask[ $elt->[ 0 ] / 8 ] |= (1 << ($elt->[ 0 ] % 8));
      }
    } elsif (scalar(@{$elt}) == 2) {
      foreach ($elt->[0] .. $elt->[1]) {
        if ($set->{negative}) {
          $mask[ $_ / 8 ] &= ~(1 << ($_ % 8));
        } else {
          $mask[ $_ / 8 ] |= (1 << ($_ % 8));
        }
      }
    }
  }
  return join('', map(sprintf("%.2x", $_), @mask));
}

sub _output_asm_dot
{
  my $token = shift;
  print $out
    "  any\n";
}

sub _output_asm_ref
{
  my $token = shift;
  print $out
    "  call __RULE_$token->{str}\n";
}

1;