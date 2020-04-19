package IPEG::Assembler;

use Data::Dumper;
use IPEG::Engine;

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

##BEEFBEEF
$VAR1 = {
          'char' => {
                      'param2' => '-',
                      'param1' => 'char',
                      'size' => 8,
                      'instr' => 263433
                    },
          'span' => {
                      'instr' => 2098495,
                      'size' => 36,
                      'param1' => 'set',
                      'param2' => '-'
                    },
          'maskedchar' => {
                            'instr' => 263434,
                            'param2' => 'mask',
                            'size' => 8,
                            'param1' => 'char'
                          },
          'set' => {
                     'param2' => '-',
                     'param1' => 'set',
                     'size' => 36,
                     'instr' => 2098489
                   },
          'var' => {
                     'instr' => 265993,
                     'param2' => '-',
                     'param1' => 'slot',
                     'size' => 8
                   },
          'replacestring' => {
                               'instr' => 265999,
                               'param2' => 'string',
                               'doc' => 'This is a semi instruction.',
                               'size' => 8,
                               'param1' => 'length'
                             },
          'catch' => {
                       'size' => 8,
                       'param1' => 'address',
                       'param2' => '-',
                       'instr' => 264707
                     },
          'testany' => {
                         'param1' => 'address',
                         'size' => 8,
                         'param2' => '-',
                         'instr' => 263429
                       },
          'condjump' => {
                          'param1' => 'register',
                          'size' => 12,
                          'param2' => 'address',
                          'instr' => 525107
                        },
          'noop' => {
                      'instr' => 0,
                      'param2' => '-',
                      'param1' => '-',
                      'size' => 4
                    },
          'backcommit' => {
                            'instr' => 264752,
                            'param2' => '-',
                            'param1' => 'address',
                            'size' => 8
                          },
          'testchar' => {
                          'instr' => 525583,
                          'param1' => 'address',
                          'size' => 12,
                          'param2' => 'char'
                        },
          'testquad' => {
                          'instr' => 525621,
                          'param2' => 'quad',
                          'param1' => 'address',
                          'size' => 12
                        },
          'closecapture' => {
                              'instr' => 528133,
                              'size' => 12,
                              'param1' => 'slot',
                              'param2' => 'type'
                            },
          'opencapture' => {
                             'instr' => 265987,
                             'param2' => '-',
                             'param1' => 'slot',
                             'size' => 8
                           },
          'replace' => {
                         'instr' => 265994,
                         'size' => 8,
                         'param1' => 'slot',
                         'param2' => '-'
                       },
          'jump' => {
                      'param2' => '-',
                      'param1' => 'address',
                      'size' => 8,
                      'instr' => 262921
                    },
          'failtwice' => {
                           'param2' => '-',
                           'size' => 4,
                           'param1' => '-',
                           'instr' => 2575
                         },
          'any' => {
                     'param2' => '-',
                     'size' => 4,
                     'param1' => '-',
                     'instr' => 1283
                   },
          'testset' => {
                         'size' => 40,
                         'param1' => 'address',
                         'param2' => 'set',
                         'instr' => 2360634
                       },
          'call' => {
                      'instr' => 262915,
                      'size' => 8,
                      'param1' => 'address',
                      'param2' => '-'
                    },
          'ret' => {
                     'instr' => 773,
                     'param2' => '-',
                     'size' => 4,
                     'param1' => '-'
                   },
          'commit' => {
                        'instr' => 264709,
                        'size' => 8,
                        'param1' => 'address',
                        'param2' => '-'
                      },
          'range' => {
                       'size' => 12,
                       'param1' => 'number',
                       'param2' => 'number',
                       'instr' => 525651
                     },
          'end' => {
                     'instr' => 262922,
                     'param1' => 'code',
                     'size' => 8,
                     'param2' => '-'
                   },
          'skipvar' => {
                         'instr' => 264531,
                         'docshort' => 'Skips number of bytes forward as stored in an
                 unsigned integer interpreted slot',
                         'param1' => 'slot',
                         'size' => 8,
                         'param2' => '-'
                       },
          'fail' => {
                      'param2' => '-',
                      'size' => 4,
                      'param1' => '-',
                      'instr' => 2570
                    },
          'counter' => {
                         'param1' => 'register',
                         'size' => 12,
                         'param2' => 'value',
                         'instr' => 525071
                       },
          'quad' => {
                      'instr' => 263475,
                      'param2' => '-',
                      'param1' => 'quad',
                      'size' => 8
                    },
          'skip' => {
                      'instr' => 263509,
                      'size' => 8,
                      'param1' => 'number',
                      'param2' => '-'
                    },
          'partialcommit' => {
                               'param1' => 'address',
                               'size' => 8,
                               'param2' => '-',
                               'instr' => 264713
                             }
        };

##BEEFBEEF
my $instructions = $VAR1;

##BEEFDEAD
  my $hexbytecode = '00040303000000100004030a00000000
00040303000000d0000003050004030300000eec00040a030000003c00040303
00000eec00040a090000002c0000030500040a03000000cc00040a03000000a4
000405090000002d000405090000002d00040a030000009400200539fffbffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffff00040a09
00000068000405090000000a00040a05000000c40004030300000eec00040a03
000000c40004030300000eec00040a09000000b400040a090000004800000305
0004030300000040000403030000010400040a03000000f80004030300000104
00040a09000000e800040303000003cc00000305000403030000004000040f03
0000000000040a030000012c00040303000003e800040a05000003bc00040a03
00000144000403030000042000040a05000003bc00040a030000015c00040303
0000047000040a05000003bc00040a030000017400040303000004a800040a05
000003bc00040a030000018c00040303000004e800040a05000003bc00040a03
000001a4000403030000055000040a05000003bc00040a03000001bc00040303
0000059800040a05000003bc00040a03000001d400040303000005e000040a05
000003bc00040a03000001ec000403030000066800040a05000003bc00040a03
00000204000403030000064000040a05000003bc00040a030000021c00040303
000006a000040a05000003bc00040a030000023400040303000006d800040a05
000003bc00040a030000024c000403030000070000040a05000003bc00040a03
00000264000403030000075800040a05000003bc00040a030000027c00040303
000007a800040a05000003bc00040a030000029400040303000007e000040a05
000003bc00040a03000002ac000403030000083000040a05000003bc00040a03
000002c4000403030000088000040a05000003bc00040a03000002dc00040303
000008b800040a05000003bc00040a03000002f4000403030000090000040a05
000003bc00040a030000030c000403030000093800040a05000003bc00040a03
00000324000403030000097000040a05000003bc00040a030000033c00040303
000009c000040a05000003bc00040a03000003540004030300000a4000040a05
000003bc00040a030000036c0004030300000a8000040a05000003bc00040a03
000003840004030300000ae000040a05000003bc00040a030000039c00040303
00000b2800040a05000003bc00040a03000003b40004030300000b8800040a05
000003bc0004030300000bd800080f0500000000000000000000030500040303
0000004000040a03000003e40000050300000a0f000003050004030300000040
00040f03000000010004050900000061000405090000006e0004050900000079
00080f05000000010000000000000305000403030000004000040f0300000002
000405336261636b00040533636f6d6d00040509000000690004050900000074
00080f050000000200000000000403030000001c0004030300000c7000000305
000403030000004000040f03000000030004053363616c6c00080f0500000003
00000000000403030000001c0004030300000c70000003050004030300000040
00040f03000000040004053363617463000405090000006800080f0500000004
00000000000403030000001c0004030300000c70000003050004030300000040
00040f0300000005000405336368617200080f05000000050000000000040303
0000001c0004030300000c3000040a030000054c000403030000001c00040303
00000e300004030300000c3000040a090000054400040a050000054c00000305
000403030000004000040f030000000600040533636c6f730004053365636170
000405337475726500080f050000000600000000000403030000001c00040303
00000df400000305000403030000004000040f030000000700040533636f6d6d
0004050900000069000405090000007400080f05000000070000000000040303
0000001c0004030300000c7000000305000403030000004000040f0300000008
0004050900000065000405090000006e000405090000006400080f0500000008
0000000000040a030000063c000403030000001c0004030300000c1c00040a09
0000063400040a050000063c00000305000403030000004000040f0300000009
000405336661696c00080f050000000900000000000003050004030300000040
00040f030000000a000405336661696c00040533747769630004050900000065
00080f050000000a0000000000000305000403030000004000040f030000000b
000405336a756d7000080f050000000b00000000000403030000001c00040303
00000c7000000305000403030000004000040f030000000c000405336e6f6f70
00080f050000000c0000000000000305000403030000004000040f030000000d
000405336f70656e000405336361707400040509000000750004050900000072
000405090000006500080f050000000d00000000000403030000001c00040303
00000df400000305000403030000004000040f030000000e0004053370617274
0004053369616c63000405336f6d6d69000405090000007400080f050000000e
00000000000403030000001c0004030300000c70000003050004030300000040
00040f030000000f000405337175616400080f050000000f0000000000040303
0000001c0004030300000d7400000305000403030000004000040f0300000010
000405337265706c000405090000006100040509000000630004050900000065
00080f050000001000000000000403030000001c0004030300000c7000000305
000403030000004000040f0300000011000405337265706c0004053361636573
000405337472696e000405090000006700080f05000000110000000000040303
0000001c0004030300000e4400000305000403030000004000040f0300000012
00040509000000720004050900000065000405090000007400080f0500000012
0000000000000305000403030000004000040f03000000130004050900000073
0004050900000065000405090000007400080f05000000130000000000040303
0000001c0004030300000db400000305000403030000004000040f0300000014
00040533736b697000080f050000001400000000000403030000001c00040303
00000ce800000305000403030000004000040f0300000015000405337370616e
00080f050000001500000000000403030000001c0004030300000db400000305
000403030000004000040f030000001600040533746573740004050900000061
000405090000006e000405090000007900080f05000000160000000000040303
0000001c0004030300000c7000000305000403030000004000040f0300000017
0004053374657374000405336368617200080f05000000170000000000040303
0000001c0004030300000c30000403030000001c0004030300000c7000040a03
00000a3c000403030000001c0004030300000e300004030300000c3000040a09
00000a3400040a0500000a3c00000305000403030000004000040f0300000018
0004053374657374000405337175616400080f05000000180000000000040303
0000001c0004030300000d7400000305000403030000004000040f0300000019
0004053374657374000405090000007300040509000000650004050900000074
00080f050000001900000000000403030000001c0004030300000db400040303
0000001c0004030300000c7000000305000403030000004000040f030000001a
00040509000000760004050900000061000405090000007200080f050000001a
00000000000403030000001c0004030300000df4000003050004030300000040
00040f030000001b00040533636f756e00040509000000740004050900000065
000405090000007200080f050000001b00000000000403030000001c00040303
00000e08000403030000001c0004030300000ce8000003050004030300000040
00040f030000001c00040533636f6e64000405336a756d7000080f050000001c
00000000000403030000001c0004030300000e08000403030000001c00040303
00000c7000000305000403030000004000040f030000001d0004030300000c70
00080f050000001d000000000004030300000e1c000003050004030300000040
0004030300000c300000030500040303000000400004030300000ce800000305
000403030000004000040f030000001e0008030f000000010000000200040303
00000ec4000803330000000100000c4c00080f050000001e0000000000000305
000403030000004000040f030000001f00200539000000000000ff03feffff87
feffff070000000000000000000000000000000000040a0300000cd800200539
000000000000ff03feffff87feffff0700000000000000000000000000000000
00040a0900000cac00080f050000001f00000000000003050004030300000040
00040f030000002000200539000000000000ff03000000000000000000000000
00000000000000000000000000040a0300000d5000200539000000000000ff03
00000000000000000000000000000000000000000000000000040a0900000d24
00080f0500000020000000000000030500040303000000400004030300000c30
00000305000403030000004000040f03000000210008030f0000000200000008
0004030300000ec4000803330000000200000d9000080f050000002100000000
00000305000403030000004000040f03000000220008030f0000000300000040
0004030300000ec4000803330000000300000dd000080f050000002200000000
0000030500040303000000400004030300000ce8000003050004030300000040
0004030300000ce8000003050004030300000040000405090000003a00000305
0004030300000040000405090000002600000305000403030000004000040f03
00000023000405090000002700040a0300000eac00040a0300000e8000040509
0000005c0000050300040a0500000ea400200539ffffffff7fffffffffffffff
ffffffffffffffffffffffffffffffffffffffff00040a0900000e6400040509
0000002700080f0500000023000000000000030500200539000000000000ff03
7e0000007e000000000000000000000000000000000000000000030500200539
0026000001000000000000000000000000000000000000000000000000000000
00000305';

##BEEFDEAD

## Hash matching capture slots to identifiers
my $tokens = {
  0 => token,
  1 => any,
  2 => backcommit,
  3 => call,
  4 => catch,
  5 => char,
  6 => closecapture,
  7 => commit,
  8 => end,
  9 => fail,
  10 => failtwice,
  11 => jump,
  12 => noop,
  13 => opencapture,
  14 => partialcommit,
  15 => quad,
  16 => replace,
  17 => replacestring,
  18 => ret,
  19 => set,
  20 => skip,
  21 => span,
  22 => testany,
  23 => testchar,
  24 => testquad,
  25 => testset,
  26 => var,
  27 => counter,
  28 => condjump,
  29 => labeltoken,
  30 => hexbyte,
  31 => label,
  32 => number,
  33 => quadliteral,
  34 => setliteral,
};

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
  my $engine = IPEG::Engine->new(__dehex($hexbytecode));
  my $result = $engine->run($assembly);
  my $out = '';
  if (!defined($result) || $result->{endcode} ne '0') {
    die "Assembler parser unhappy ending; $@";
  }
  my $offsets = __get_offsets($result->{captures});
  $self->{labelmap} = $offsets;
  while (my $capture = shift (@{$result->{captures}})) {
    my $id = $tokens->{$capture->{slot}};
    if ($id eq 'any') {
      $out .= pack('N', $INSTR_ANY);
 
    } elsif ($id eq 'backcommit') {
      my $l = shift(@{$result->{captures}});
      my $o = $offsets->{$l->{string}};
      die "Unknown offset for label $l->{string}" if (!defined($o));
      $out .= pack('N', $INSTR_BACKCOMMIT);
      $out .= pack('N', $o);

    } elsif ($id eq 'call') {
      my $l = shift(@{$result->{captures}});
      my $o = $offsets->{$l->{string}};
      die "Unknown offset for label $l->{string}" if (!defined($o));
      $out .= pack('N', $INSTR_CALL);
      $out .= pack('N', $o);

    } elsif ($id eq 'catch') {
      my $l = shift(@{$result->{captures}});
      my $o = $offsets->{$l->{string}};
      die "Unknown offset for label $l->{string}" if (!defined($o));
      $out .= pack('N', $INSTR_CATCH);
      $out .= pack('N', $o);

    } elsif ($id eq 'char') {
      my $c = shift(@{$result->{captures}});
      my $m = 0;
      if ($tokens->{$result->{captures}[0]{slot}} eq 'hexbyte') {
        my $c2 = shift(@{$result->{captures}});
        $m = hex($c2->{string});
      }
      $out .= pack('N', $INSTR_CHAR);
      $out .= pack('n', $m);
      $out .= pack('n', hex($c->{string}));

    } elsif ($id eq 'closecapture') {
      my $s = shift(@{$result->{captures}});
      my $i = shift(@{$result->{captures}});
      $out .= pack('N', $INSTR_CLOSECAPTURE);
      $out .= pack('N', int($s->{string}));
      $out .= pack('N', int($l->{string}));

    } elsif ($id eq 'commit') {
      my $l = shift(@{$result->{captures}});
      my $o = $offsets->{$l->{string}};
      die "Unknown offset for label $l->{string}" if (!defined($o));
      $out .= pack('N', $INSTR_COMMIT);
      $out .= pack('N', $o);

    } elsif ($id eq 'end') {
      my $c = shift(@{$result->{captures}});
      $out .= pack('N', $INSTR_END);
      $out .= pack('N', int($c->{string}));

    } elsif ($id eq 'fail') {
      $out .= pack('N', $INSTR_FAIL);

    } elsif ($id eq 'failtwice') {
      $out .= pack('N', $INSTR_FAILTWICE);

    } elsif ($id eq 'jump') {
      my $l = shift(@{$result->{captures}});
      my $o = $offsets->{$l->{string}};
      die "Unknown offset for label $l->{string}" if (!defined($o));
      $out .= pack('N', $INSTR_JUMP);
      $out .= pack('N', $o);

    } elsif ($id eq 'noop') {
      my $l = shift(@{$result->{captures}});
      $out .= pack('N', $INSTR_NOOP);

    } elsif ($id eq 'opencapture') {
      my $s = shift(@{$result->{captures}});
      $out .= pack('N', $INSTR_OPENCAPTURE);
      $out .= pack('N', int($s->{string}));

    } elsif ($id eq 'partialcommit') {
      my $l = shift(@{$result->{captures}});
      my $o = $offsets->{$l->{string}};
      die "Unknown offset for label $l->{string}" if (!defined($o));
      $out .= pack('N', $INSTR_PARTIALCOMMIT);
      $out .= pack('N', $o);

    } elsif ($id eq 'quad') {
      my $q = shift(@{$result->{captures}});
      $out .= pack('N', $INSTR_QUAD);
      $out .= pack('N', hex($q->{string}));

    } elsif ($id eq 'replace') {
      my $l = shift(@{$result->{captures}});
      my $o = $offsets->{$l->{string}};
      die "Unknown offset for label $l->{string}" if (!defined($o));
      $out .= pack('N', $INSTR_REPLACE);
      $out .= pack('N', $o);

    } elsif ($id eq 'replacestring') {

## TODO: Call __strunescape

      $out .= pack('N', $INSTR_REPLACESTRING);
      my $string = shift(@{$result->{captures}});
      $string = $string->{string};
      my $outstring = '';
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
        $outstring .= chr($ord);
      }
      $out .= pack('N', length($outstring)) . $outstring;
      if (length($outstring) % 4) {
        $out .= chr(0) x (4 - (length($outstring) % 4));
      }

    } elsif ($id eq 'ret') {
      $out .= pack('N', $INSTR_RET);

    } elsif ($id eq 'set') {
      my $s = shift(@{$result->{captures}});
      $out .= pack('N', $INSTR_SET);
      while (length($s->{string})) {
        $s->{string} =~ s/^(.{8})//;
        my $h = hex($1);
        $out .= pack('N', $h);
      }

    } elsif ($id eq 'slot') {
      my $s = shift(@{$result->{captures}});
      my $p = shift(@{$result->{captures}});
      $out .= pack('N', $INSTR_SLOT);
      $out .= pack('N', int($s->{string}));
      $out .= pack('N', int($p->{string}));

    } elsif ($id eq 'skip') {
      my $s = shift(@{$result->{captures}});
      $out .= pack('N', $INSTR_SKIP);
      $out .= pack('N', int($s->{string}));

    } elsif ($id eq 'span') {
      my $s = shift(@{$result->{captures}});
      $out .= pack('N', $INSTR_SPAN);
      while (length($s->{string})) {
        $s->{string} =~ s/^(.{8})//;
        my $h = hex($1);
        $out .= pack('N', $h);
      }

    } elsif ($id eq 'testany') {
      my $l = shift(@{$result->{captures}});
      my $o = $offsets->{$l->{string}};
      die "Unknown offset for label $l->{string}" if (!defined($o));
      $out .= pack('N', $INSTR_TESTANY);
      $out .= pack('N', $o);

    } elsif ($id eq 'testchar') {
      my $c = shift(@{$result->{captures}});
      my $l = shift(@{$result->{captures}});
      my $m = 0;
      if ($tokens->{$result->{captures}[0]{slot}} eq 'hexbyte') {
        my $c2 = shift(@{$result->{captures}});
        $m = hex($c2->{string});
      }
      my $o = $offsets->{$l->{string}};
      die "Unknown offset for label $l->{string}" if (!defined($o));
      $out .= pack('N', $INSTR_TESTCHAR);
      $out .= pack('N', $o);
      $out .= pack('n', $m);
      $out .= pack('n', hex($c->{string}));

    } elsif ($id eq 'testquad') {
      my $q = shift(@{$result->{captures}});
      my $l = shift(@{$result->{captures}});
      my $o = $offsets->{$l->{string}};
      die "Unknown offset for label $l->{string}" if (!defined($o));
      $out .= pack('N', $INSTR_TESTQUAD);
      $out .= pack('N', $o);
      $out .= pack('N', hex($q->{string}));

    } elsif ($id eq 'testset') {
      my $s = shift(@{$result->{captures}});
      my $l = shift(@{$result->{captures}});
      my $o = $offsets->{$l->{string}};
      die "Unknown offset for label $l->{string}" if (!defined($o));
      $out .= pack('N', $INSTR_TESTSET);
      $out .= pack('N', $o);
      while (length($s->{string})) {
        $s->{string} =~ s/^(.{8})//;
        my $h = hex($1);
        $out .= pack('N', $h);
      }

    } elsif ($id eq 'var') {
      my $s = shift(@{$result->{captures}});
      $out .= pack('N', $INSTR_VAR);
      $out .= pack('N', int($s->{string}));

    } elsif ($id eq 'counter') {
      my $r = shift(@{$result->{captures}});
      my $n = shift(@{$result->{captures}});
      $out .= pack('N', $INSTR_COUNTER);
      $out .= pack('N', $r->{string});
      $out .= pack('N', $n->{string});

    } elsif ($id eq 'condjump') {
      my $r = shift(@{$result->{captures}});
      my $l = shift(@{$result->{captures}});
      my $o = $offsets->{$l->{string}};
      die "Unknown offset for label $l->{string}" if (!defined($o));
      $out .= pack('N', $INSTR_CONDJUMP);
      $out .= pack('N', $r->{string});
      $out .= pack('N', $o);

    } elsif (defined($instructions->{$id})) {
      die "Unimplemented instruction $id (slot $capture->{slot})";
    }
  }
  return $out;
}

sub __get_offsets
{
  my $captures = shift;
  my $result = {};
  my $offset = 0;
  for (my $i=0; $i < scalar(@{$captures}); $i++) {
    my $capture = $captures->[ $i ];
    my $id = $tokens->{$capture->{slot}};
    die "Unknown token id $id '$capture->{string}'" if (!defined($id));
    if ($id eq 'labeltoken') {
      $result->{$capture->{string}} = $offset;
    } elsif ($id eq 'replacestring') {
      my $string = __strunescape($captures->[ ++$i ]);
      $offset += 8 + length($string);
      if (length($string) % 4) { $offset += (4 - (length($string) % 4)); }
    } elsif (defined($instructions->{$id})) {
      $offset += $instructions->{$id}{size};
    } else {
      ##.. is a token other than an instruction
    }
  }
  return $result;
}

sub __strunescape
{
  my $string = shift;
##.. TODO
  return $string;
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

1;
