package IPEG::Compiler;

use Data::Dumper;
use IPEG::Engine;

$Data::Dumper::Terse = 1;
$Data::Dumper::Ident = 1;
$Data::Dumper::Sortkeys = 1;

my $counter = 0;
my $variables = {};
my $labels = {};
my $labrefs = {};
my $slots = [];
my $slotnames = {};
my $postfix = '';
my $replacelabel = 0;

my $USE_EXPERIMENTAL = 1;

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

##DEADBEEF

##BEEFDEAD
  my $hexbytecode = '00040303000000100004030a00000000
000403030000012000040a0300000030000403030000012000040a0900000020
00040303000001040000030500040a030000010000040a03000000a000040509
0000002d000405090000002d00040a030000009000200539fffbffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffff00040a0900000064
000405090000000a00040a05000000f800200539002600000100000000000000
000000000000000000000000000000000000000000040a03000000f800200539
0026000001000000000000000000000000000000000000000000000000000000
00040a09000000cc00040a090000004400000305000403030000003c00040a03
0000011c0000050300000a0f00000305000403030000003c0004030300000134
00000305000403030000003c00040f03000000000004030300000c6c00080f05
00000000000000000004030300000fe40004030300000cd00004030300000174
00000305000403030000003c00040a03000001b8000403030000021800040f03
000000010004030300000e8000080f0500000001000000000004030300000ea8
00040a050000021400040a03000001f4000403030000021800040f0300000002
0004030300000e8000080f050000000200000000000403030000017400040a05
0000021400040a030000020c000403030000021800040a050000021400040303
0000109000000305000403030000003c000403030000024400040a0300000240
000403030000024400040a090000023000000305000403030000003c00040a03
0000029800040f030000000300040a03000002740004030300000d2400040a05
0000027c0004030300000d3800080f05000000030000000000040a0900000290
00040a050000029800040303000004d400040a03000002d400040f0300000004
00040303000002d800080f05000000040000000000040a09000002cc00040a05
000002d400000305000403030000003c00040a03000002f8000405090000003f
00040a05000004d000040a0300000310000405090000002b00040a05000004d0
00040a0300000328000405090000002a00040a05000004d000040a03000003b0
000405090000005e00040f0300000005000403030000113400040a0300000360
000403030000113400040a090000035000080f05000000050000000000040509
0000002d00040f0300000006000403030000113400040a030000039c00040303
0000113400040a090000038c00080f05000000060000000000040a05000004d0
00040a0300000404000405090000005e000405090000002d00040f0300000007
000403030000113400040a03000003f0000403030000113400040a09000003e0
00080f05000000070000000000040a05000004d000040a030000045800040509
0000005e00040f0300000008000403030000113400040a030000043c00040303
0000113400040a090000042c00080f050000000800000000000405090000002d
00040a05000004d000040a03000004a4000405090000005e00040f0300000009
000403030000113400040a0300000490000403030000113400040a0900000480
00080f05000000090000000000040a05000004d0000405090000005e00040509
0000003d00040f030000000a0004030300000c6c00080f050000000a00000000
00000305000403030000003c00040a030000050800040f030000000b00040303
00000e9400080f050000000b0000000000040a05000006b000040a0300000534
00040f030000000c00040303000008b800080f050000000c0000000000040a05
000006b000040a030000056000040f030000000d0004030300000df400080f05
0000000d0000000000040a05000006b000040a030000058c00040f030000000e
00040303000006b400080f050000000e0000000000040a05000006b000040a03
000005b800040f030000000f0004030300000db800080f050000000f00000000
00040a05000006b000040a03000005e400040f03000000100004030300000718
00080f05000000100000000000040a05000006b000040a030000061000040f03
00000011000403030000081000080f05000000110000000000040a05000006b0
00040a030000063c00040f0300000012000403030000088000080f0500000012
0000000000040a05000006b000040a030000066800040f030000001300040303
00000d4c00080f05000000130000000000040a05000006b000040a0300000694
00040f03000000140004030300000aac00080f05000000140000000000040a05
000006b000040f03000000150004030300000adc00080f050000001500000000
00000305000403030000003c000405090000007c0008030f0000000100000002
00040303000010e40008033300000001000006d0000405090000007c0008030f
000000020000000200040303000010e40008033300000002000006f800040509
0000007c00000305000403030000003c0004030300000ecc0004030300000ee0
00040f03000000160004030300000c6c00080f05000000160000000000040a03
000007880004030300000f9400040f03000000170004030300000b0c00080f05
000000170000000000040a090000078000040a05000007880004030300000ee0
000403030000017400040a03000007b80004030300000ee000040a09000007b0
00040a05000007b800040f03000000180004030300000ef400080f0500000018
0000000000040a030000080c00040a03000007f40004030300000be000040a05
000007fc0004030300000c3c00040a090000080400040a050000080c00000305
000403030000003c0004030300000ecc000403030000017400040f0300000019
0004030300000ef400080f05000000190000000000040a030000087c00040a03
000008640004030300000be000040a050000086c0004030300000c3c00040a09
0000087400040a050000087c00000305000403030000003c0004030300000f08
000403030000017400040f030000001a0004030300000f1c00080f050000001a
0000000000000305000403030000003c0004030300000f5800040f030000001b
00040a03000008f00004030300000f8000040a09000008e800040a05000008f0
00080f050000001b0000000000040a030000098400040f030000001c00040a03
00000928000405090000005c0000050300040a0500000930000403030000110c
00080f050000001c00000000000405090000002d00040f030000001d00040a03
00000968000405090000005c0000050300040a0500000970000403030000110c
00080f050000001d0000000000040a05000009bc00040f030000001e00040a03
000009a8000405090000005c0000050300040a05000009b0000403030000110c
00080f050000001e0000000000040a0300000a8c00040a0300000a4c00040f03
0000001c00040a03000009f0000405090000005c0000050300040a05000009f8
000403030000110c00080f050000001c00000000000405090000002d00040f03
0000001d00040a0300000a30000405090000005c0000050300040a0500000a38
000403030000110c00080f050000001d0000000000040a0500000a8400040f03
0000001e00040a0300000a70000405090000005c0000050300040a0500000a78
000403030000110c00080f050000001e0000000000040a09000009c400040f03
0000001f0004030300000f6c00080f050000001f000000000000030500040303
0000003c0004030300000f4400040f03000000200004030300000c6c00080f05
000000200000000000000305000403030000003c0004030300000c6c00040a03
00000b080004030300000fe40004030300000cd000000a0f0000030500040303
0000003c00040a0300000b3c0004053375696e74000405090000003300040509
0000003200040a0500000bdc00040a0300000b5c00040533696e743300040509
0000003200040a0500000bdc00040a0300000b8400040533756e657400040509
00000033000405090000003200040a0500000bdc00040a0300000ba400040533
6e657433000405090000003200040a0500000bdc00040a0300000bd400040533
64656369000405090000006d0004050900000061000405090000006c00040a05
00000bdc0004030300000c6c00000305000403030000003c0004030300000cec
00040a0300000c1c00040f03000000210004030300000df400080f0500000021
0000000000040a0500000c3800040f03000000220004030300000aac00080f05
000000220000000000000305000403030000003c0004030300000d0800040f03
000000230004030300000c6c00080f0500000023000000000000030500040303
0000003c002005390000000000000000feffff87feffff070000000000000000
000000000000000000040a0300000ccc00200539000000000000ff03feffff87
feffff070000000000000000000000000000000000040a0900000ca000000305
000403030000003c000405090000003c000405090000002d0000030500040303
0000003c000405090000002d000405090000003e00000305000403030000003c
000405090000003d000405090000003e00000305000403030000003c00040509
0000002100000305000403030000003c00040509000000260000030500040303
0000003c0004050900000025002005390000000000000000feffff07feffff07
0000000000000000000000000000000000040a0300000db40020053900000000
0000ff03feffff07feffff070000000000000000000000000000000000040a09
00000d8800000305000403030000003c00040509000000300004050900000078
0008030f000000030000000200040303000010e4000803330000000300000ddc
00000305000403030000003c000405090000002700040a0300000e5400040a03
00000e28000405090000005c0000050300040a0500000e4c00200539ffffffff
7fffffffffffffffffffffffffffffffffffffffffffffffffffffff00040a09
00000e0c000405090000002700040a0300000e7c000405090000006900040a09
00000e7400040a0500000e7c00000305000403030000003c000405090000002f
00000305000403030000003c000405090000002e00000305000403030000003c
000405090000002e000405090000002e000405090000002e0000030500040303
0000003c000405090000007b00000305000403030000003c000405090000003a
00000305000403030000003c000405090000007d00000305000403030000003c
000405090000002800000305000403030000003c000405090000002900000305
000403030000003c000405090000002d00000305000403030000003c00040509
0000003d00000305000403030000003c000405090000005b0000030500040303
0000003c000405090000005d00000305000403030000003c000405090000005e
00000305000403030000003c000405090000003b00000305000403030000003c
000405090000002c00000305000403030000003c000405090000003c00000305
000403030000003c000405090000003e00000305000403030000003c00040a03
0000102000040f0300000024000403030000102400080f050000002400000000
00040a090000101800040a050000102000000305000403030000003c00040303
00000f0800040f03000000250004030300000c6c00080f050000002500000000
00040a03000010840004030300000fa800040f03000000260004030300000c6c
00080f05000000260000000000040a09000010580004030300000f1c00000305
000403030000003c0004030300000fbc00040f03000000270004030300000c6c
00080f05000000270000000000040f0300000028000403030000102400080f05
00000028000000000004030300000fd00000030500200539000000000000ff03
7e0000007e000000000000000000000000000000000000000000030500200539
ffffffffffffffffffffffdfffffffffffffffffffffffffffffffffffffffff
0000030500200539000000000000ff0300000000000000000000000000000000
000000000000000000000305';

##BEEFDEAD

my $tokentypes = {
  0  => 'ruledef',
  1  => 'or',
  2 =>  'or',
  3  => 'not',
  4  => 'quantifier',
  5  => 'qfrom',
  6  => 'quntil',
  7  => 'quntilonly',
  8  => 'qfromonly',
  9  => 'qabs',
  10 => 'qvar',
  11 => 'any',
  12 => 'set',
  13 => 'string',
  14 => 'bitmask',
  15 => 'hexliteral',
  16 => 'varcapture',
  17 => 'capture',
  18 => 'group',
  19 => 'macro',
  20 => 'var',
  21 => 'ident',
  22 => 'capturevar',
  23 => 'capturetype',
  24 => 'cbclose',
  25 => 'cbclose',
  26 => 'bclose',
  27 => 'setopnot',
  28 => 'setfrom',
  29 => 'setuntil',
  30 => 'setonly',
  31 => 'abclose',
  32 => 'varref',
  33 => 'replacestring',
  34 => 'replacevar',
  35 => 'recycle',
  36 => 'defname',
  37 => 'defarg',
  38 => 'defbody',
};

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

sub get_slotmap
{
  my $self = shift;
  my $slotmap = [];

#  for (my $i=0; $i < scalar(@{$self->{slots}}); $i++) {
  for (my $i=0; $i < scalar(@{$slots}); $i++) {
#    my $slot = $selft->{slots}[$i];
    my $slot = $slots->[$i];
    push @{$slotmap}, [ $i, $slot->{parent}, $slot->{rule} ];
  }
  return $slotmap;
}

sub get_definitions
{
  my $self = shift;
  return $self->{definitions};
}

sub compile
{
  my $self = shift;

  $slots = [];
  $self->{slots} = $slots;
  my $input = $self->{grammar} || die "No grammar provided";
  my $engine = IPEG::Engine->new(__dehex($hexbytecode));
  $self->{engine} = $engine;
  if ($self->{debug}) {
    $engine->{debug} = 1;
  }
  my $result = $engine->run($input);
  my $out = '';
  if (!defined($result) || $result->{endcode} ne '0') {
    die "Grammar parser unhappy ending; $@";
  }
  my $ruledef;
  while (my $capture = shift @{$result->{captures}}) {
    my $tokentype = $tokentypes->{$capture->{slot}};
    if ($tokentype eq 'ruledef') {
      $ruledef = { ident => $capture->{string} };
      push @{$self->{definitions}}, $ruledef;
      if ($self->{debug}) {
        print STDERR "Rule: $capture->{string}\n";
      }
      $ruledef->{tokens} = _get_terms($result->{captures});
    } elsif ($tokentype eq 'defname') {
      print STDERR "Function definition: $capture->{string}\n";
##..
    }
  }
  my $asm = $self->output_assembly();
  label_reference($self->{definitions}[0]{ident});
  label_check();
  return
    "-- Generated by (Xgen) ipeg_compile at " . (my $t= localtime()) . "\n" .
    "  call $self->{definitions}[0]{ident}\n" .
    "  end\n" .
    $asm . "\n" .
    $postfix;
}

sub output_assembly
{
  my $self = shift;

  my $prefix = 0;
  my $output = '';
  foreach my $rule (@{$self->{definitions}}) {
    label_define($rule->{ident});
    $output .= "$rule->{ident}:\n";
    label_define($rule->{ident});
    if ($prefix) {
      label_reference("__prefix");
      $output .= "  call __prefix\n";
    }
    $output .=
      _output_tokens($rule->{ident}, $rule->{tokens}) .
      "  ret\n";
    if ($rule->{ident} eq '__prefix') {
      $prefix = 1;
    }
  }
  return $output;
}

sub _output_tokens
{
  my $rule = shift;
  my $tokens = shift;

  my $output = '';
  for (my $i=0; $i < scalar(@{$tokens}); $i++) {
    my $token = $tokens->[ $i ];
    if ($token->{type} eq 'or') {
      my $label_success = $rule . "_SUCCESS_$counter"; ++$counter;
      my $label_failure = $rule . "_FAILURE_$counter"; ++$counter;
      label_define($label_success);
      label_define($label_failure);
      label_reference($label_success);
      label_reference($label_failure);
      $output .= "  catch $label_failure\n";
      $output .= _output_tokens($rule, $token->{lefthand});
      $output .= "  commit $label_success\n";
      $output .= "$label_failure:\n";
      $output .= _output_tokens($rule, $token->{righthand});
      $output .= "$label_success:\n";
    } else {
      $output .= _output_matcher($rule, $token, $tokens, $i);
    }
  }
  return $output;
}

sub _output_matcher
{
  my $rule = shift;
  my $token = shift;
  my $tokens = shift;
  my $index = shift;

  my $functor = "_output_$token->{type}";
  my $output = '';
  my $label_success = $rule . "_SUCCESS_$counter"; ++$counter;
  my $label_failure = $rule . "_FAILURE_$counter"; ++$counter;
  my $i;
  my $min = $token->{quantifier}{min};
  my $max = $token->{quantifier}{max};
  my $extra = (defined($max) ? ($max - $min) : undef);

  my $labelctr = ++($counter);
  if ($token->{not}) {
    label_reference($label_failure);
    $output .= "  catch $label_failure\n";
  }
  if ($USE_EXPERIMENTAL && $min > 1) {
    ($rule_counter)++;
    $output .=
      "  counter $rule_counter $min\n" .
      "$rule" . "_$labelctr" . "_MINLOOP:\n" .
      &$functor($rule, $token, $tokens, $index) .
      "  condjump $rule_counter $rule" . "_$labelctr" . "_MINLOOP\n";
    label_define("$rule" . "_$labelctr" . "_MINLOOP");
    label_reference("$rule" . "_$labelctr" . "_MINLOOP");
  } else {
    for ($i=0; $i < $min; $i++) {
      $output .= &$functor($rule, $token, $tokens, $index);
    }
  }
  if (defined($max)) {
    if ($extra > 0) {
      $output .= "  catch $rule" . "_$labelctr" . "_MAX\n";
      label_reference($rule . "_$labelctr" . "_MAX");
      if ($USE_EXPERIMENTAL && $extra > 1) {
        $output .=
          "  counter $rule_counter $extra\n" .
          "$rule" . "_$labelctr" . "_EXTRALOOP:\n" .
          &$functor($rule, $token, $tokens, $index) .
          "  partialcommit $rule" . "_$labelctr" . "_PC\n" .
          "$rule" . "_$labelctr" . "_PC:\n" .
          "  condjump $rule_counter $rule" . "_$labelctr" . "_EXTRALOOP\n";
        label_define("$rule" . "_$labelctr" . "_EXTRALOOP");
        label_reference("$rule" . "_$labelctr" . "_EXTRALOOP");
      } else {
        for (; $i < $token->{quantifier}{max}; $i++) {
          $output .= 
            &$functor($rule, $token, $tokens, $index) .
            "  partialcommit $rule" . "_$labelctr" . "_PC\n" .
            "$rule" . "_$labelctr" . "_PC:\n";
        }
      }
      $output .= "  commit $rule" . "_$labelctr" . "_MAX\n";
      $output .= $rule . "_$labelctr" . "_MAX:\n";
      label_define($rule . "_$labelctr" . "_MAX");
    } elsif ($min > $max) {
      die "Quantifier: min ($min) > max ($max) in rule $rule $token->{string}";
    }
  } else {
    my $indefn = ++($counter);
    $output .= "  catch $rule" . "_$indefn" . "_INDEF\n" .
               $rule . "_$indefn" . "_LOOP:\n" .
               &$functor($rule, $token, $tokens, $index) .
               "  partialcommit $rule" . "_$indefn" . "_LOOP\n" .
               $rule . "_$indefn" . "_INDEF:\n";
    label_define($rule . "_$indefn" . "_LOOP");
    label_define($rule . "_$indefn" . "_INDEF");
    label_reference($rule . "_$indefn" . "_LOOP");
    label_reference($rule . "_$indefn" . "_INDEF");
  }
  if ($token->{not}) {
    $output .= "  failtwice\n" .
               "$label_failure:\n";
    label_define($label_failure);
  } elsif ($token->{and}) {
    $output .= "  backcommit $label_success\n" .
               "$label_failure:\n" .
	       "  fail\n" .
	       "$label_success:\n";
  }
  return $output;
}

sub _output_ident
{
  my $rule = shift;
  my $token = shift;

  label_reference($token->{string});
  return "  call $token->{string}\n";
}

sub _output_string
{
  my $rule = shift;
  my $token = shift;

  if ($token->{string} =~ s/i$//) {
    _output_caseinsensitive_string_($rule, $token);
  } else {
    _output_string_($rule, $token, 'char');
  }
}

sub _output_caseinsensitive_string
{
  my $rule = shift;
  my $token = shift;

  my $output = '';
  my $string = "$token->{string}";
  $string =~ s/^.//;
  $string =~ s/.$//;
  while (length($string)) {
    my $ord;
    $string =~ s/^(.)//s;
    my $char = $1;
    if ($char eq '\\') {
      $string =~ s/^(.)//s;
      my $esc = $1;
      if ($esc eq 'n') {
        $ord = ord("\n");
      } else {
        $ord = ord($esc);
      }
    } else {
      $ord = ord($char);
    }
    if ($ord >= ord('A') && $ord <= ord('Z')) {
      $output .=
        "  set " .
        _range_string({ set => { ranges => [ [ $ord ], [ $ord + 32 ] ] } }) .
        "\n";
    } elsif ($ord >= ord('a') && $ord <= ord('z')) {
      $output .=
        "  set " .
        _range_string({ set => { ranges => [ [ $ord ], [ $ord - 32 ] ] } }) .
        "\n";
    } else {
      $output .= "  char " . sprintf("%.2x", $ord) . "\n";
    }
  }
  return $output;
}

sub _output_string_
{
  my $rule = shift;
  my $token = shift;
  my $instr = shift;

  my $output = '';
  my $string = "$token->{string}";
  $string =~ s/^.//;
  $string =~ s/.$//;
  while (length($string)) {
    my $ord;
    $string =~ s/^(.)//s;
    my $char = $1;
    if ($char eq '\\') {
      $string =~ s/^(.)//s;
      my $esc = $1;
      if ($esc eq 'n') {
        $ord = ord("\n");
      } else {
        $ord = ord($esc);
      }
    } else {
      $ord = ord($char);
    }
    $output .= "  $instr " . sprintf("%.2x", $ord) . "\n";
  }
  return $output;
}

sub _output_any
{
  my $rule = shift;
  my $token = shift;

  return "  any\n";
}

sub _output_set
{
  my $rule = shift;
  my $token = shift;

  return "  set " . _range_string($token) . "\n";
}

sub _range_string
{
  my $token = shift;
  my @mask = (
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
  );
  if ($token->{set}{not}) {
     @mask = (
      255, 255, 255, 255, 255, 255, 255, 255,
      255, 255, 255, 255, 255, 255, 255, 255,
      255, 255, 255, 255, 255, 255, 255, 255,
      255, 255, 255, 255, 255, 255, 255, 255
    );
  }
  foreach my $elt (@{$token->{set}{ranges}}) {
    if (scalar(@{$elt}) == 1) {
      if ($token->{set}{not}) {
        $mask[ $elt->[ 0 ] / 8 ] &= ~(1 << ($elt->[ 0 ] % 8));
      } else {
        $mask[ $elt->[ 0 ] / 8 ] |= (1 << ($elt->[ 0 ] % 8));
      }
    } elsif (scalar(@{$elt}) == 2) {
      foreach ($elt->[0] .. $elt->[1]) {
        if ($token->{set}{not}) {
          $mask[ $_ / 8 ] &= ~(1 << ($_ % 8));
        } else {
          $mask[ $_ / 8 ] |= (1 << ($_ % 8));
        }
      }
    }
  }
  return join('', map(sprintf("%.2x", $_), @mask));
}


sub _output_macro
{
  my $rule = shift;
  my $token = shift;

  my $macro = "$token->{string}";
  $macro =~ s/^.//;
  if ($macro eq 's') {
    return _output_set($rule, { set => { ranges => [
      [ ord("\n") ],
      [ ord("\r") ],
      [ ord("\t") ],
      [ ord(' ') ],
    ] } } );
  }
  if ($macro eq 'nl') {
    return _output_set($rule, { set => { ranges => [
      [ ord("\n") ],
      [ ord("\r") ],
    ] } } );
  }
  if ($macro eq 'a') {
    return _output_set($rule, { set => { ranges => [
      [ ord('0'), ord('9') ],
      [ ord('a'), ord('z') ],
      [ ord('A'), ord('Z') ],
    ] } } );
  }
  if ($macro eq 'n') {
    return _output_set($rule, { set => { ranges => [
      [ ord('0'), ord('9') ],
    ] } } );
  }
  if ($macro eq 'w') {
    return _output_set($rule, { set => { ranges => [
      [ ord('a'), ord('z') ],
      [ ord('A'), ord('Z') ],
    ] } } );
  }
  return "  noop -- $token->{string}\n";
}

sub _output_group
{
  my $rule = shift;
  my $token = shift;

  return _output_tokens($rule, $token->{group});
}

sub _output_capture
{
  my $rule = shift;
  my $token = shift;

  my $s = $token->{captureslot};
  if (!defined($s)) {
    $s = int(scalar(@{$slots}));
    my $slotname = $rule;
    my $count = 0;
    if (scalar(@{$slots})) {
      if ($slots->[ -1 ]{orig} eq $rule) {
        $count = $slots->[ -1 ]{count} + 1;
      }
    }
    $slotname = $rule . ($count ? '_' . $count : '');
    if ($token->{string}) {
      my $try = "$token->{string}";
      $try =~ s/[^a-zA-Z]//g;
      if (length($try)) {
        $slotname = $rule . '_' . uc($try);
      }
    }
    if (length($slotname) > 32) {
      $slotname = substr($slotname, 0, 32);
    }
    while ($slotnames->{$slotname}) {
      if ($slotname =~ /^(.*)_([0-9]+)$/) {
        $slotname = $1 . '_' . ($2 + 1);
      } else {
        $slotname .= '_1';
      }
    }
    $slotnames->{$slotname} = 1;
    push @{$slots}, {
      orig => $rule,
      count => $count,
      rule => $slotname,
      parent => -1
    };
    $token->{captureslot} = $s;
  }
  return
    "  opencapture $s\n" .
    _output_tokens($rule, $token->{group}) .
    "  closecapture $s\n";
}

sub _output_varcapture
{
  my $rule = shift;
  my $token = shift;
  my $tokens = shift;
  my $index = shift;

  my $s = $token->{captureslot};
  if (!defined($s)) {
    $s = int(scalar(@{$slots}));
    push @{$slots}, { rule => $rule, parent => -1 };
    $token->{captureslot} = $s;
  }
  $variables->{$token->{variable}} = $s;
  return
    "  opencapture $s\n" .
    _output_tokens($rule, $token->{group}) .
    "  closecapture $s\n";
}

sub _output_var
{
  my $rule = shift;
  my $token = shift;
  my $tokens = shift;
  my $index = shift;

  my $slot = $variables->{$token->{variable}};
  return "  var $slot\n";
}

sub _output_hexliteral
{
  my $rule = shift;
  my $token = shift;
  my $tokens = shift;
  my $index = shift;

  return "  char " . substr($token->{string}, 2, 2) . "\n";
}

sub _output_bitmask
{
  my $rule = shift;
  my $token = shift;
  my $tokens = shift;
  my $index = shift;

  $token->{string} =~ /^.(..).(..)/;
  my ($mask, $char) = ($1, $2);
  return "  char $char &$mask\n";
}

sub _output_replacestring
{
  my $rule = shift;
  my $token = shift;
  my $tokens = shift;
  my $index = shift;
  my $replacelabel = 'REPLACE_' . ++$replacecounter;
  my $string = $token->{string};
  $postfix .=
     $replacelabel . ':' . "\n" .
     '  replacestring ' . $string . "\n";

  return "  replace $replacelabel\n";
}

sub _get_terms
{
  my $captures = shift;

  my $tokens = [];
  while (scalar(@{$captures})) {
    my $next = $captures->[ 0 ];
    my $type = $tokentypes->{$next->{slot}};
    if ($type eq 'ruledef') {
      return $tokens;
    } elsif ($type eq 'bclose' || $type eq 'cbclose') {
      shift @{$captures};
      return $tokens;
    } elsif ($type eq 'or') {
      shift @{$captures};
      my $newtop = {
        type => 'or',
        lefthand => $tokens,
      };
      $tokens = [ $newtop ];
      $newtop->{righthand} = _get_terms($captures);
      return $tokens;
    } else {
      my $token = _get_term($captures);
      push @{$tokens}, $token;
    }
  }
  return $tokens;
}

sub _get_term
{
  my $captures = shift;

  my $next = $captures->[ 0 ];
  my $not = 0;
  my $and = 0;
  if ($tokentypes->{$next->{slot}} eq 'not') {
    if ($next->{string} eq '!') {
      $not = 1;
    } else {
      $and = 1;
    }
    shift @{$captures};
  }
  my $token = _get_matcher($captures);
  $token->{not} = $not;
  $token->{and} = $and;
  $next = $captures->[ 0 ];
  if ($tokentypes->{$next->{slot}} eq 'quantifier') {
    shift @{$captures};
    $token->{quantifier} = _get_quantifier($captures, $next->{string});
  } else {
    $token->{quantifier} = { min => 1, max => 1 };
  }
  return $token;
}

sub _get_quantifier
{
  my $captures = shift;
  my $quantifier = shift;

  if ($quantifier eq '?') {
    return { min => 0, max => 1 };
  } elsif ($quantifier eq '*') {
    return { min => 0, max => undef };
  } elsif ($quantifier eq '+') {
    return { min => 1, max => undef };
  } elsif ($tokentypes->{$captures->[ 0 ]{slot}} eq 'qfrom') {
    my $qfrom = shift @{$captures};
    my $quntil = shift @{$captures};
    return { min => int($qfrom->{string}), max => int($quntil->{string}) };
  } elsif ($tokentypes->{$captures->[ 0 ]{slot}} eq 'qfromonly') {
    my $qfrom = shift @{$captures};
    return { min => int($qfrom->{string}), max => undef };
  } elsif ($tokentypes->{$captures->[ 0 ]{slot}} eq 'quntilonly') {
    my $quntil = shift @{$captures};
    return { min => 0, max => int($quntil->{string}) };
  } elsif ($tokentypes->{$captures->[ 0 ]{slot}} eq 'qabs') {
    my $qabs = shift @{$captures};
    return { min => int($qabs->{string}), max => int($qabs->{string}) };
  } elsif ($tokentypes->{$captures->[ 0 ]{slot}} eq 'qvar') {
    die "No support for quantifier variables yet";
  } else {
    die "Unknown quantifier (shouldn't happen)";
  }
}

sub _get_matcher
{
  my $captures = shift;

  my $next = shift @{$captures};
  my $type = $tokentypes->{$next->{slot}};
  my $token = {
    type => $type,
    string => $next->{string},
  };
  if ($type eq 'group' || $type eq 'capture') {
    $token->{group} = _get_terms($captures);
  } elsif ($type eq 'varcapture') {
    my $nnext = shift @{$captures};
    $token->{variable} = $nnext->{string};
    if ($tokentypes->{$captures->[0]{slot}} eq 'capturetype') {
      $token->{capturetype} = $captures->[0]{string};
      shift @{$captures};
    }
    $token->{group} = _get_terms($captures);
  } elsif ($type eq 'var') {
    my $nnext = shift @{$captures};
    $token->{variable} = $nnext->{string};
  } elsif ($type eq 'set') {
    $token->{set} = _get_set($captures);
  }
  return $token;
}

sub _get_set
{
  my $captures = shift;

  my $set = { ranges => [] };
  my $optnot = shift (@{$captures});
  if ($optnot->{string} eq '^') {
    $set->{not} = 1;
  }
  while (scalar(@{$captures})) {
    my $next = shift (@{$captures});
    last if ($tokentypes->{$next->{slot}} eq 'abclose');
    if ($tokentypes->{$next->{slot}} eq 'setfrom') {
      my $until = shift (@{$captures});
      push @{$set->{ranges}}, [
        _dec_char($next->{string}),
        _dec_char($until->{string})
      ];
    } elsif ($tokentypes->{$next->{slot}} eq 'setonly') {
      push @{$set->{ranges}}, [ _dec_char($next->{string}) ];
    } else {
      die "Unexpected token $next->{string} $next->{slot} (shouldn't happen)";
    }
  }
  return $set;
}

sub _dec_char
{
  my $char = shift;
  if ($char =~ /^\\(.)/) {
    my $esc = $1;
    if ($esc eq 'n') { return ord("\n"); }
    if ($esc eq 'r') { return ord("\r"); }
    if ($esc eq 't') { return ord("\t"); }
    return ord($esc);
  } else {
    return ord($char);
  }
}

sub __dehex
{
  my $hex = shift;
  my $result = '';
  while (length($hex)) {
    if ($hex =~ s/^\s*([0-9a-fA-F]{2})\s*//) {
      my $codon = $1;
      my $b = chr(hex($codon));
      $result .= $b;
    }
  }
  return $result;
}

sub label_define
{
  my $label = shift;
  if (!defined($labels->{$label})) {
    $labels->{$label} = 0;
  }
}

sub label_reference
{
  my $label = shift;
  if (!defined($labels->{$label})) {
    $labels->{$label} = 1;
  } else {
    ++($labels->{$label});
  }
  $labrefs->{$label} = 1;
}

sub label_check
{
  foreach my $label (keys(%{$labels})) {
    if ($labels->{$label} eq '0') {
      print "WARNING: Label $label is defined but not referenced.\n";
    }
  }
  foreach my $labref (keys(%{$labrefs})) {
    if (!defined($labels->{$labref})) {
      die "Label $labref is referenced but not defined.";
    }
  }
}

1;
