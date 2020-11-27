#!/usr/bin/perl

my $result = {};

use Data::Dumper;
$Data::Dumper::Sortkeys = 1;

my $instrfile = shift @ARGV;
my $instrperl = `cat $instrfile`;
my $instrhash = eval $instrperl;
my $generation = shift @ARGV;

my @hamming = (
  0x00, 0x03, 0x05, 0x06, 0x09, 0x0a, 0x0c, 0x0f,  
  0x11, 0x12, 0x14, 0x17, 0x18, 0x1b, 0x1d, 0x1e,  
  0x21, 0x22, 0x24, 0x27, 0x28, 0x2b, 0x2d, 0x2e,  
  0x30, 0x33, 0x35, 0x36, 0x39, 0x3a, 0x3c, 0x3f,  
  0x41, 0x42, 0x44, 0x47, 0x48, 0x4b, 0x4d, 0x4e,  
  0x50, 0x53, 0x55, 0x56, 0x59, 0x5a, 0x5c, 0x5f,  
  0x60, 0x63, 0x65, 0x66, 0x69, 0x6a, 0x6c, 0x6f,  
  0x71, 0x72, 0x74, 0x77, 0x78, 0x7b, 0x7d, 0x7e,  
  0x81, 0x82, 0x84, 0x87, 0x88, 0x8b, 0x8d, 0x8e,  
  0x90, 0x93, 0x95, 0x96, 0x99, 0x9a, 0x9c, 0x9f,  
  0xa0, 0xa3, 0xa5, 0xa6, 0xa9, 0xaa, 0xac, 0xaf,  
  0xb1, 0xb2, 0xb4, 0xb7, 0xb8, 0xbb, 0xbd, 0xbe,  
  0xc0, 0xc3, 0xc5, 0xc6, 0xc9, 0xca, 0xcc, 0xcf,  
  0xd1, 0xd2, 0xd4, 0xd7, 0xd8, 0xdb, 0xdd, 0xde,  
  0xe1, 0xe2, 0xe4, 0xe7, 0xe8, 0xeb, 0xed, 0xee,  
  0xf0, 0xf3, 0xf5, 0xf6, 0xf9, 0xfa, 0xfc, 0xff,
);

my $global_instructions = {
  noop => { opcode => '00000000', size => 4 },
  trap => { opcode => 'ff00ffff', size => 4 },
  end  => { size => 8, param1 => 'code', terse => 1 },
};

my $parser_instructions = {
  call          => { gen => 0, size => 8,  param1 => 'address', terse => 1 },
  ret           => { gen => 0, size => 4, terse => 1 },
  jump          => { gen => 0, size => 8,  param1 => 'address', terse => 1 },
  counter       => { gen => 0, size => 12, param1 => 'register', param2 => 'value' },
  condjump      => { gen => 0, size => 12, param1 => 'register', param2 => 'address' },
  any           => { gen => 0, size => 4 },
  testany       => { gen => 0, size => 8,  param1 => 'address' },
  char          => { gen => 0, size => 8,  param1 => 'char' },
  testchar      => { gen => 0, size => 12, param1 => 'address', param2 => 'char' },
  maskedchar    => { gen => 0, size => 12, param1 => 'char', param2 => 'mask', terse => 1 },
  quad          => { gen => 0, size => 8,  param1 => 'quad' },
  testquad      => { gen => 0, size => 12, param1 => 'address', param2 => 'quad' },
  set           => { gen => 0, size => 36, param1 => 'set', terse => 1 },
  testset       => { gen => 0, size => 40, param1 => 'address', param2 => 'set' },
  span          => { gen => 0, size => 36, param1 => 'set' },
  range         => { gen => 0, size => 12, param1 => 'from', param2 => 'until', terse => 1 },
  skip          => { gen => 0, size => 8,  param1 => 'number' },
  catch         => { gen => 0, size => 8,  param1 => 'address', terse => 1 },
  commit        => { gen => 0, size => 8,  param1 => 'address', terse => 1 },
  partialcommit => { gen => 0, size => 8,  param1 => 'address' },
  backcommit    => { gen => 0, size => 8,  param1 => 'address', terse => 1 },
  fail          => { gen => 0, size => 4, terse => 1 },
  failtwice     => { gen => 0, size => 4 },
  opencapture   => { gen => 0, size => 8,  param1 => 'slot', terse => 1 },
  closecapture  => { gen => 0, size => 8,  param1 => 'slot', terse => 1 },
  var           => { gen => 0, size => 8,  param1 => 'slot', terse => 1 },
  replace       => { gen => 1, size => 12, param1 => 'slot', param2 => 'address', terse => 1 },
  endreplace    => { gen => 1, size => 4, terse => 1 },
  isolate       => { gen => 3, size => 8,  param1 => 'slot' },
  endisolate    => { gen => 3, size => 4 },
};

my $script_instructions = {
  scr_condjump   => { gen => 3, size => 12 },
  scr_jump       => { gen => 3, size => 8 },
  scr_call       => { gen => 3, size => 8 },
  scr_ret        => { gen => 3, size => 4 },
  scr_push       => { gen => 3, size => 4 },
  scr_pop        => { gen => 3, size => 4 },
  scr_equals     => { gen => 3, size => 4 },
  scr_nequals    => { gen => 3, size => 4 },
  scr_lt         => { gen => 3, size => 4 },
  scr_gt         => { gen => 3, size => 4 },
  scr_lteq       => { gen => 3, size => 4 },
  scr_gteq       => { gen => 3, size => 4 },
  scr_pow        => { gen => 3, size => 4 },
  scr_mul        => { gen => 3, size => 4 },
  scr_div        => { gen => 3, size => 4 },
  scr_add        => { gen => 3, size => 4 },
  scr_sub        => { gen => 3, size => 4 },
  scr_inc        => { gen => 3, size => 4 },
  scr_dec        => { gen => 3, size => 4 },
  scr_logand     => { gen => 3, size => 4 },
  scr_logor      => { gen => 3, size => 4 },
  scr_lognot     => { gen => 3, size => 4 },
  scr_bitand     => { gen => 3, size => 4 },
  scr_bitor      => { gen => 3, size => 4 },
  scr_bitxor     => { gen => 3, size => 4 },
  scr_bitnot     => { gen => 3, size => 4 },
  scr_assign     => { gen => 3, size => 4 },
  scr_bitandis   => { gen => 3, size => 4 },
  scr_bitoris    => { gen => 3, size => 4 },
  scr_bitxoris   => { gen => 3, size => 4 },
  scr_bitnotis   => { gen => 3, size => 4 },
  scr_shiftin    => { gen => 3, size => 4 },
  scr_shiftout   => { gen => 3, size => 4 },
  scr_shiftinis  => { gen => 3, size => 4 },
  scr_shiftoutis => { gen => 3, size => 4 },
};

{
  foreach my $key (keys(%{$instrhash})) {
    print STDERR "Updating $key with opce $instrhash->{$key}{opcode}\n";
    if ($key =~ /^scr_/) {
      $script_instructions->{$key}{opcode} = $instrhash->{$key}{opcode};
    } else {
      $parser_instructions->{$key}{opcode} = $instrhash->{$key}{opcode};
    }
  }
}

srand(time());

assign_opcodes(0, $global_instructions);
assign_opcodes(3, $parser_instructions);
assign_opcodes(5, $script_instructions);

print STDERR scalar(keys(%{$result})) . " instructions generated.\n";
foreach my $key (sort(keys(%{$result}))) {
  print STDERR "$key -> $result->{$key}{opcode}\n";
}
print "{\n";
foreach my $key (sort(keys(%{$result}))) {
  if (!defined($generation) || $result->{$key}{gen} > $generation) {
    print  "    {
      mnem => '$result->{$key}{mnem}',
      opcode => '$result->{$key}{opcode}',
      instr => " . int($result->{$key}{instr}) . ",
      param1 => '$result->{$key}{param1}',
      param2 => '$result->{$key}{param2}',
      size => " . int($result->{$key}{size}) . ",
      terse => " . int($result->{$key}{terse}) . ",
      gen => " . int($result->{$key}{gen}) . "
    },\n";
  }
}
print "};\n";

exit 0;

sub assign_opcodes
{
  my $category = shift;
  my $instr = shift;
  foreach my $key (sort(keys(%{$instr}))) {
    if (!defined($instr->{$key}{opcode})) {
      my $i = int(rand(scalar(@hamming)));
      my $h = $hamming[ $i ];
      splice @hamming, $i, 1;
      $instr->{$key}{opcode} =
        '00' .
        sprintf("%.2x", $instr->{$key}{size} - 4) .
        sprintf("%.2x", $category) .
        sprintf("%.2x", $h);
    }
#    $result->{$key} = eval(Dumper($instr->{$key}));
    $result->{$key}{mnem} = $key;
    $result->{$key}{instr} = eval("0x" . $instr->{$key}{opcode});
    $result->{$key}{param1} = $instr->{$key}{param1};
    $result->{$key}{param2} = $instr->{$key}{param2};
    $result->{$key}{size} = $instr->{$key}{size};
    $result->{$key}{terse} = $instr->{$key}{terse};
    $result->{$key}{gen} = $instr->{$key}{gen};
  }
}
