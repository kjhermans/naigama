#!/usr/bin/perl

package IPEG::Compiler;

##
## TODO:
## Semantics checks:
## - proper nesting of differently typed brackets ( {
## - !... is not allowed
## - ... must always be the only element in a catch arm
## Function:
## - lookahead
##

use Data::Dumper;
$Data::Dumper::Terse = 1;
$Data::Dumper::Ident = 1;
$Data::Dumper::Sortkeys = 1;

sub new
{
  my $class = shift;
  my $classname = ref($class) || $class;
  my $self = {
  };
  bless $self, $classname;

  my $grammar = shift;
  if (defined($grammar)) {
    $self->set_grammar($grammar);
  }
  return $self;
}

sub set_grammar
{
  my $self = shift;
  my $grammar = shift || die "Need grammar text";
  $self->{grammar} = $grammar;
}

sub get_definitions
{
  my $self = shift;
  return $self->{definitions};
}

sub get_slotmap
{
  my $self = shift;
  return $self->{slotmap};
}

sub add_plugin
{
  my $self = shift;
  my $plugin = shift;
  push @{$self->{plugins}}, $plugin;
}

sub compile
{
  my $self = shift;
  my $input = $self->{grammar} || die "No grammar provided";

  my $icapture = 0;
  my $variables = {};
  
  my $prefix;
  my $lineno = 1;
  my @definitions;
  my @slots;

  $self->{slotmap} = \@slots;

  DEFINITION: while (length($input))
  {
    if ($input =~ s/^\s+// || $input =~ s/^--[^\n]*\n//) {
      next DEFINITION;
    }
    $input =~ s/^([a-zA-Z_][a-zA-Z0-9_]*)\s*<-//
      || die "Expected definition at $input";
    my $definition = { ident => $1, tokens => [] };
    push @definitions, $definition;
    TOKEN: while (length($input))
    {
      my $origlen = length($input);
      my $origstr = "$input";
      if ($input =~ s/^\s+// || $input =~ s/^--[^\n]*\n//) {
        next TOKEN;
      }
      if ($input =~ s/^\.\.\.//) {
        push @{$definition->{tokens}}, { type => 'nothing' };
        next TOKEN;
      } elsif ($input =~ s/^->//) {
        push @{$definition->{tokens}}, { type => 'replace' };
        next TOKEN;
      } elsif ($input =~ s/^\.//) {
        push @{$definition->{tokens}}, { type => 'any' };
      } elsif ($input =~ s/^\///) {
        push @{$definition->{tokens}}, { type => 'catch' };
        next TOKEN;
      } elsif ($input =~ s/^\[//) {
        push @{$definition->{tokens}}, { type => 'range',
          range => consume_range(\$input)
        };
        my $token = $definition->{tokens}[ -1 ];
      } elsif ($input =~ s/^'//) {
        push @{$definition->{tokens}}, { type => 'string',
          string => consume_string(\$input)
        };
      } elsif ($input =~ s/^0x([0-9a-fA-F]{2})//) {
        push @{$definition->{tokens}}, { type => 'string',
          string => chr(hex($1))
        };
      } elsif ($input =~ s/^\{:([a-zA-Z_][a-zA-Z_0-9]*)://) {
        push @{$definition->{tokens}}, { type => 'openvarcapture', var => $1 };
        next TOKEN;
      } elsif ($input =~ s/^:\}//) {
        push @{$definition->{tokens}}, { type => 'closevarcapture' };
      } elsif ($input =~ s/^=([a-zA-Z_][a-zA-Z_0-9]*)//) {
        push @{$definition->{tokens}}, { type => 'varreference', var => $1 };
      } elsif ($input =~ s/^\{//) {
        push @{$definition->{tokens}}, { type => 'opencapture' };
        next TOKEN;
      } elsif ($input =~ s/^\(//) {
        push @{$definition->{tokens}}, { type => 'groupopen' };
        next TOKEN;
      } elsif ($input =~ s/^\}//) {
        push @{$definition->{tokens}}, { type => 'closecapture' };
      } elsif ($input =~ s/^\)//) {
        push @{$definition->{tokens}}, { type => 'groupclose' };
      } elsif ($input =~ s/^\%//) {
        push @{$definition->{tokens}}, { type => 'macro',
          macro => consume_macro(\$input)
        };
      } elsif ($input =~ s/^!//) {
        push @{$definition->{tokens}}, { type => 'not' };
        next TOKEN;
      } elsif ($input =~ /^[a-zA-Z_][a-zA-Z0-9_]*\s*<-/) {
        next DEFINITION;
      } elsif ($input =~ s/^([a-zA-Z_][a-zA-Z0-9_]*)//) {
        push @{$definition->{tokens}}, { type => 'ident', ident => $1 };
      } elsif (length($input)) {
        die "Unknown token at $input";
      }
      $input =~ s/^\s+//;
      if ($input =~ s/^([?])//) {
        $definition->{tokens}[ -1 ]{quantifier} = { min => 0, max => 1 };
      } elsif ($input =~ s/^([*])//) {
        $definition->{tokens}[ -1 ]{quantifier} = { min => 0, max => undef };
      } elsif ($input =~ s/^([+])//) {
        $definition->{tokens}[ -1 ]{quantifier} = { min => 1, max => undef };
      } elsif ($input =~ s/^\^([0-9]+)-([0-9]+)//) {
        $definition->{tokens}[ -1 ]{quantifier} = { min => $1, max => $2 };
      } elsif ($input =~ s/^\^([0-9]+)-//) {
        $definition->{tokens}[ -1 ]{quantifier} = { min => $1, max => undef };
      } elsif ($input =~ s/^\^-([0-9]+)//) {
        $definition->{tokens}[ -1 ]{quantifier} = { min => 0, max => $1 };
      } elsif ($input =~ s/^\^([0-9]+)//) {
        $definition->{tokens}[ -1 ]{quantifier} = { min => $1, max => $1 };
      } else {
        $definition->{tokens}[ -1 ]{quantifier} = { min => 1, max => 1 };
      }
      my $tokentext = substr($origstr, 0, (length($origstr) - length($input)));
      while ($tokentext =~ s/\n//) { ++$lineno; }
      $tokentext =~ s/\s+//g;
      $definition->{tokens}[ -1 ]{text} = $tokentext;
      $definition->{tokens}[ -1 ]{lineno} = $lineno;
    }
  }

  if ($self->{debug}) { print STDERR Dumper \@definitions; }
  
  sub consume_range
  {
    my ($stringref) = @_;
    my $result = {};
    if ($$stringref =~ s/^\^//) {
      $result->{negative} = 1;
    }
    my $pairwithlast = 0;
    while (length($$stringref)) {
      my $ord;
      if ($$stringref =~ s/^\\(.)//s) {
        my $escape = $1;
        if ($escape eq 't') {
          $ord = ord("\t");
        } elsif ($escape eq 'n') {
          $ord = ord("\n");
        } elsif ($escape eq 'r') {
          $ord = ord("\r");
        } else {
          $ord = ord($escape);
        }
      } elsif ($$stringref =~ s/^\]//) {
        if ($pairwithlast) {
          $pairwithlast = 0;
          $ord = ord('-');
        }
        die "No range specified in $$stringref"
          if (!scalar(@{$result->{set}}));
        return $result;
      } elsif ($$stringref =~ s/^-//) {
        die "Range without bottom in $$stringref"
          if (!scalar(@{$result->{set}}));
        $pairwithlast = 1;
        next;
      } elsif ($$stringref =~ s/^0x([0-9a-fA-F]{2})//) {
        $ord = hex($1);
      } else {
        $$stringref =~ s/^(.)//s;
        $ord = ord($1);
      }
      if ($pairwithlast) {
        $pairwithlast = 0;
        push @{$result->{set}[ -1 ]}, $ord;
      } else {
        push @{$result->{set}}, [ $ord ];
      }
    }
    die "Ended before end of set definition at $$stringref";
  }

  check(\@definitions);
  $self->{definitions} = \@definitions;
  return output_assembly(\@definitions);
  
  sub consume_string
  {
    my ($stringref) = @_;
    my $result = "";
    while (length($$stringref)) {
      $$stringref =~ s/^(.)//s;
      my $char = $1;
      if ($char eq '\\') {
        if ($$stringref =~ s/^(.)//s) {
          my $escape = $1;
          if ($escape eq 'n') {
            $result .= "\n";
          } elsif ($escape eq 'r') {
            $result .= "\r";
          } elsif ($escape eq 't') {
            $result .= "\t";
          } else {
            $result .= $escape;
          }
        } else {
          die "Ended before end of string (inside escape)";
        }
      } elsif ($char eq '\'') {
        return $result;
      } else {
        $result .= $char;
      }
    }
    die "Ended before end of string at $$stringref";
  }
  
  sub consume_macro
  {
    my ($stringref) = @_;
    $$stringref =~ s/^([a-zA-Z0-9]+)//;
    return $1;
  }
  
  sub check
  {
    my $defs = shift;
    my $rulenames = {};
    foreach my $rule (@{$defs}) {
      if (defined($rulenames->{$rule->{ident}})) {
        die "Rule $rule->{ident} doubly defined."
      }
      $rulenames->{$rule->{ident}} = 1;
    }
    foreach my $rule (@{$defs}) {
      check_rule($rule);
    }
    check_endless_loops($defs);
  }
  
  sub check_endless_loops
  {
    my $defs = shift;
    foreach my $rule (@{$defs}) {
      next if ($rule->{tokens}[0]{type} ne 'ident');
      my $chain = { $rule->{ident} => 1 };
      if ($rule->{ident} eq $rule->{tokens}[0]{ident}) {
        die "Recursion detected at $rule->{ident}";
      }
      check_el_chain($defs, $chain, $rule->{tokens}[0]{ident});
    }
  }

  sub check_el_chain
  {
    my ($defs, $chain, $ident) = @_;
    if ($chain->{$ident}) {
      die "Recursion detected at $ident after " . join(', ', keys(%{$chain}));
    }
    $chain->{$ident} = 1;
    foreach my $rule (@{$defs}) {
      next if ($rule->{ident} ne $ident);
      next if ($rule->{tokens}[0]{type} ne 'ident');
      check_el_chain($defs, $chain, $rule->{tokens}[0]{ident});
    }
  }

  sub check_rule
  {
    my $rule = shift;
    if ($debug) { print STDERR "Checking rule $rule->{ident}\n"; }
    die "Rule has no tokens" if (!scalar(@{$rule->{tokens}}));
    match_captures($rule->{tokens}, $rule);
    check_brackets($rule->{tokens});
    process_catches($rule->{tokens});
    check_references($rule->{tokens}, $rule);
  }
  
  sub match_captures
  {
    my $tokens = shift;
    my $rule = shift;
    my @stack;
    for (my $i=0; $i < scalar(@{$tokens}); $i++) {
      my $token = $tokens->[$i];
      if ($token->{type} eq 'opencapture'
          || $token->{type} eq 'openvarcapture')
      {
        $token->{capture} = $icapture++;
        if ($token->{type} eq 'openvarcapture') {
          $variables->{$token->{var}} = $token->{capture};
        }
        push @stack, $token;
      } elsif ($token->{type} eq 'closecapture'
               || $token->{type} eq 'closevarcapture')
      {
        die "Unmatched capture bracket close" if (!scalar(@stack));
        my $opentoken = pop @stack;
        $token->{capture} = $opentoken->{capture};
        if (scalar(@stack)) {
          my $tok = $stack[ -1 ];
          push @slots, [ $token->{capture}, $tok->{capture}, $rule->{ident} ];
        } else {
          push @slots, [ $token->{capture}, 0xffffffff, $rule->{ident} ];
        }
      }
    }
    die "Unmatched capture bracket open" if (scalar(@stack));
  }
  
  sub check_brackets
  {
    my $tokens = shift;
  BRACKETOPEN:
    for (my $i=0; $i < scalar(@{$tokens}); $i++) {
      if ($tokens->[$i]{type} eq 'groupopen'
          || $tokens->[$i]{type} eq 'openvarcapture'
          || $tokens->[$i]{type} eq 'opencapture')
      {
        my $o = ++$i;
        my $level = 0;
        for (; $i < scalar(@{$tokens}); $i++) {
          if ($tokens->[$i]{type} eq 'groupopen'
              || $tokens->[$i]{type} eq 'openvarcapture'
              || $tokens->[$i]{type} eq 'opencapture')
          {
            ++$level;
          } elsif ($tokens->[$i]{type} eq 'groupclose'
                   || $tokens->[$i]{type} eq 'closevarcapture'
                   || $tokens->[$i]{type} eq 'closecapture')
          {
            if ($level == 0) {
              my @splc = splice(@{$tokens}, $o, 1 + $i - $o);
              my $close = pop @splc;
              $tokens->[$o - 1]{group} = \@splc;
              $tokens->[$o - 1]{quantifier} = $close->{quantifier};
              check_brackets(\@splc);
              $i = $o - 1;
              next BRACKETOPEN;
            }
            --$level;
          }
        }
        die "Unmatched group open";
      }
    }
  }
  
  sub process_catches
  {
    my $tokens = shift;
    for (my $i=0; $i < scalar(@{$tokens}); $i++) {
      if ($tokens->[$i]{type} eq 'catch') {
        if (!defined($tokens->[$i]{lefthand})) {
          my @lefthand = splice(@{$tokens}, 0, $i);
          my @righthand = splice(@{$tokens}, 1);
          $tokens->[ 0 ]{lefthand} = \@lefthand;
          $tokens->[ 0 ]{righthand} = \@righthand;
        }
        process_catches($tokens->[ 0 ]{lefthand});
        process_catches($tokens->[ 0 ]{righthand});
        return;
      } elsif ($tokens->[$i]{type} eq 'groupopen'
               || $tokens->[$i]{type} eq 'openvarcapture'
               || $tokens->[$i]{type} eq 'opencapture')
      {
        process_catches($tokens->[$i]{group});
      }
    }
  }
  
  sub check_references
  {
    my $tokens = shift;
    my $rule = shift;
  REFTOKEN:
    for (my $i=0; $i < scalar(@{$tokens}); $i++) {
      my $token = $tokens->[ $i ];
      if ($token->{type} eq 'ident') {
        foreach my $rule (@definitions) {
          if ($rule->{ident} eq $token->{ident}) {
            next REFTOKEN;
          }
        }
        die "Unknown reference to rule $token->{ident} in rule $rule->{ident}.";
      } elsif ($token->{type} eq 'catch') {
        check_references($token->{lefthand}, $rule);
        check_references($token->{righthand}, $rule);
      } elsif ($token->{type} eq 'groupopen'
               || $tokens->[$i]{type} eq 'openvarcapture'
               || $tokens->[$i]{type} eq 'opencapture')
      {
        check_references($token->{group}, $rule);
      }
    }
  }

  sub output_assembly
  {
    my $defs = shift;
    my $result = "  call $defs->[0]{ident}\n  end\n";
    foreach my $rule (@{$defs}) {
      $result .= output_rule_assembly($rule);
      if ($rule->{ident} eq '__prefix') {
        $prefix = 1;
      }
    }
    return $result;
  }
  
  sub output_rule_assembly
  {
    my $rule = shift;
    my $result =
      "$rule->{ident}:\n" .
      ((defined($prefix) && $rule->{ident} ne '__prefix')
        ? "  call __prefix\n"
        : ""
      ) .
      output_tokens_assembly($rule->{tokens}, { ident => $rule->{ident} }) .
      "  ret\n";
    return $result;
  }
  
  sub output_tokens_assembly
  {
    my $tokens = shift;
    my $state = shift;
    my $result = '';
    my $not = 0;
    for (my $i=0; $i < scalar(@{$tokens}); $i++) {
      my $token = $tokens->[ $i ];
      my $resultcopy = "$result";
      if ($token->{type} eq 'catch') {
        my $n = ++($state->{n});
        $result .=
          "$state->{ident}_C$state->{n}:\n" .
          "  catch $state->{ident}_C$n" . "_ALT\n" .
          output_tokens_assembly($token->{lefthand}, $state) .
          "  commit $state->{ident}_C$n" . "_OUT\n" .
          "$state->{ident}_C$n" . "_ALT:\n" .
          output_tokens_assembly($token->{righthand}, $state) .
          "$state->{ident}_C$n" . "_OUT:\n";
      } elsif ($token->{type} eq 'ident') {
        if ($token->{string} eq $state->{ident} && $i == 0) {
          die "Leftmost recursion, resulting in endless loop, detected.";
        }
        $result .= output_matcher_assembly($token, $state, $not, 'ident');
        $not = 0;
      } elsif ($token->{type} eq 'groupopen') {
        $result .= output_matcher_assembly($token, $state, $not, 'group');
        $not = 0;
      } elsif ($token->{type} eq 'range') {
        $result .= output_matcher_assembly($token, $state, $not, 'range');
      } elsif ($token->{type} eq 'not') {
        $not = 1;
      } elsif ($token->{type} eq 'any') {
        $result .= output_matcher_assembly($token, $state, $not, 'any');
        $not = 0;
      } elsif ($token->{type} eq 'string') {
        $result .= output_matcher_assembly($token, $state, $not, 'string');
        $not = 0;
      } elsif ($token->{type} eq 'macro') {
        $result .= output_matcher_assembly($token, $state, $not, 'macro');
        $not = 0;
      } elsif ($token->{type} eq 'opencapture') {
        $result .= output_matcher_assembly($token, $state, $not, 'capture');
      } elsif ($token->{type} eq 'nothing') {
        ##.. nothing
      } elsif ($token->{type} eq 'openvarcapture') {
        $result .= output_matcher_assembly($token, $state, $not, 'capture');
      } elsif ($token->{type} eq 'varreference') {
        $result .= output_matcher_assembly($token, $state, $not, 'varreference');
      } elsif ($token->{type} eq 'closecapture') {
        ##.. nothing
      } elsif ($token->{type} eq 'replace') {
        
      } else {
        die "Unknown token type $token->{type}";
      }
      $token->{asm} = substr($result, length($resultcopy) - length($result));
    }
    return $result;
  }
  
  sub output_matcher_assembly
  {
    my $token = shift;
    my $state = shift;
    my $not = shift;
    my $func = shift; my $functor = "output_$func" . "_assembly";
    my $result = '';
    my $notn;
    my $i;
    if ($not) {
      $notn = ++($state->{n});
      $result .= "  catch $state->{ident}_$notn" . "_NOT\n";
    }
    for ($i=0; $i < $token->{quantifier}{min}; $i++) {
      $result .= &$functor($token, $state);
    }
    if (defined($token->{quantifier}{max})) {
      if ($token->{quantifier}{max} > $token->{quantifier}{min}) {
        my $maxn = ++($state->{n});
        $result .= "  catch $state->{ident}_$maxn" . "_MAX\n";
        for (; $i < $token->{quantifier}{max}; $i++) {
          $result .= &$functor($token, $state);
        }
        $result .= "  commit $state->{ident}_$maxn" . "_MAX\n";
        $result .= "$state->{ident}_$maxn" . "_MAX:\n";
      } elsif ($token->{quantifier}{max} < $token->{quantifier}{min}) {
        die "Quantifier: min > max";
      }
    } else {
  ## Implement lookahead...
      my $indefn = ++($state->{n});
      $result .= "  catch $state->{ident}_$indefn" . "_INDEF\n" .
                 "$state->{ident}_$indefn" . "_LOOP:\n" .
                 &$functor($token, $state) .
                 "  partialcommit $state->{ident}_$indefn" . "_LOOP\n" .
                 "$state->{ident}_$indefn" . "_INDEF:\n";
    }
    if ($not) {
      $result .= "  failtwice\n" .
                 "$state->{ident}_$notn" . "_NOT:\n";
    }
    return $result;
  }
  
  sub output_ident_assembly
  {
    my $token = shift;
    my $state = shift;
    return "  call $token->{ident}\n";
  }
  
  sub output_group_assembly
  {
    my $token = shift;
    my $state = shift;
    return output_tokens_assembly($token->{group}, $state);
  }
  
  sub output_capture_assembly
  {
    my $token = shift;
    my $state = shift;
    return
      "  opencapture $token->{capture}\n" .
      output_tokens_assembly($token->{group}, $state) .
      "  closecapture $token->{capture}\n";
  }
  
  sub output_varreference_assembly
  {
    my $token = shift;
    my $state = shift;
    my $ref = $variables->{$token->{var}};
    die "Unknown variable reference '$token->{var}'" if (!defined($ref));
    return "  var $ref\n";
  }
  
  sub output_range_assembly
  {
    my $token = shift;
    my $state = shift;
    my $rangestring = range_string($token);
    return "  set " . $rangestring . "\n";
  }
  
  sub output_any_assembly
  {
    my $token = shift;
    my $state = shift;
    my $rangestring = range_string($token);
    return "  any\n";
  }
  
  sub output_string_assembly
  {
    my $token = shift;
    my $state = shift;
    my $copy = "$token->{string}";
    my $result = '';
    while (length($copy)) {
      $copy =~ s/^(.)//s;
      $result .= "  char " . unpack('H*', $1) . "\n";
    }
    return $result;
  }

  sub output_macro_assembly
  {
    my $token = shift;
    my $state = shift;
    if ($token->{macro} eq 's') {
      $token->{type} = 'range';
      $token->{range}{set} = [ [ 8 ], [ 10 ], [ 13 ], [ 32 ] ];
      return "  set " . range_string($token) . "\n";
    } elsif ($token->{macro} eq 'w') {
      $token->{type} = 'range';
      $token->{range}{set} = [ [ 65, 90 ], [ 97, 122 ] ];
      return "  set " . range_string($token) . "\n";
    } elsif ($token->{macro} eq 'nl') {
      $token->{type} = 'range';
      $token->{range}{set} = [ [ 10 ], [ 13 ] ];
      return "  set " . range_string($token) . "\n";
    } else {
      my $pluginoutput = undef;
      foreach my $plugin (@{$self->{plugins}}) {
        my $pluginoutput = eval { $plugin->output_macro_assembly($token); };
        if (defined($pluginoutput)) {
          return $pluginoutput;
        }
      }
      die "Unknown macro '\%" . $token->{macro};
    }
  }
  
  sub range_string {
    my $token = shift;
    my @mask = (
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    );
    if ($token->{range}{negative}) {
       @mask = (
        255, 255, 255, 255, 255, 255, 255, 255,
        255, 255, 255, 255, 255, 255, 255, 255,
        255, 255, 255, 255, 255, 255, 255, 255,
        255, 255, 255, 255, 255, 255, 255, 255
      );
    }
    foreach my $elt (@{$token->{range}{set}}) {
      if (scalar(@{$elt}) == 1) {
        if ($token->{range}{negative}) {
          $mask[ $elt->[ 0 ] / 8 ] &= ~(1 << ($elt->[ 0 ] % 8));
        } else {
          $mask[ $elt->[ 0 ] / 8 ] |= (1 << ($elt->[ 0 ] % 8));
        }
      } elsif (scalar(@{$elt}) == 2) {
        foreach ($elt->[0] .. $elt->[1]) {
          if ($token->{range}{negative}) {
            $mask[ $_ / 8 ] &= ~(1 << ($_ % 8));
          } else {
            $mask[ $_ / 8 ] |= (1 << ($_ % 8));
          }
        }
      }
    }
    return join('', map(sprintf("%.2x", $_), @mask));
  }
}

1;
