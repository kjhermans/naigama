#!/usr/bin/perl

my $result = {};

use Data::Dumper;
$Data::Dumper::Sortkeys = 1;

my $instrfile = shift @ARGV;
my $instrperl = `cat $instrfile`;
my $instrhash = eval $instrperl;

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
  call          => { size => 8,  param1 => 'address', terse => 1 },
  ret           => { size => 4, terse => 1 },
  jump          => { size => 8,  param1 => 'address', terse => 1 },
  counter       => { size => 12, param1 => 'register', param2 => 'value' },
  condjump      => { size => 12, param1 => 'register', param2 => 'address' },
  any           => { size => 4 },
  testany       => { size => 8,  param1 => 'address' },
  char          => { size => 8,  param1 => 'char' },
  testchar      => { size => 12, param1 => 'address', param2 => 'char' },
  maskedchar    => { size => 12, param1 => 'char', param2 => 'mask', terse => 1 },
  quad          => { size => 8,  param1 => 'quad' },
  testquad      => { size => 12, param1 => 'address', param2 => 'quad' },
  set           => { size => 36, param1 => 'set', terse => 1 },
  testset       => { size => 40, param1 => 'address', param2 => 'set' },
  span          => { size => 36, param1 => 'set' },
  range         => { size => 12, param1 => 'from', param2 => 'until', terse => 1 },
  skip          => { size => 8,  param1 => 'number' },
  catch         => { size => 8,  param1 => 'address', terse => 1 },
  commit        => { size => 8,  param1 => 'address', terse => 1 },
  partialcommit => { size => 8,  param1 => 'address' },
  backcommit    => { size => 8,  param1 => 'address', terse => 1 },
  fail          => { size => 4, terse => 1 },
  failtwice     => { size => 4 },
  opencapture   => { size => 8,  param1 => 'slot', terse => 1 },
  closecapture  => { size => 8,  param1 => 'slot', terse => 1 },
  var           => { size => 8,  param1 => 'slot', terse => 1 },
  replace       => { size => 12, param1 => 'slot', param2 => 'address', terse => 1 },
  endreplace    => { size => 4, terse => 1 },
  isolate       => { size => 4, },
  endisolate    => { size => 4, },
};

my $script_instructions = {
  scr_condjump   => { size => 12 },
  scr_jump       => { size => 8 },
  scr_call       => { size => 8 },
  scr_ret        => { size => 4 },
  scr_push       => { size => 4 },
  scr_pop        => { size => 4 },
  scr_equals     => { size => 4 },
  scr_nequals    => { size => 4 },
  scr_lt         => { size => 4 },
  scr_gt         => { size => 4 },
  scr_lteq       => { size => 4 },
  scr_gteq       => { size => 4 },
  scr_pow        => { size => 4 },
  scr_mul        => { size => 4 },
  scr_div        => { size => 4 },
  scr_add        => { size => 4 },
  scr_sub        => { size => 4 },
  scr_inc        => { size => 4 },
  scr_dec        => { size => 4 },
  scr_logand     => { size => 4 },
  scr_logor      => { size => 4 },
  scr_lognot     => { size => 4 },
  scr_bitand     => { size => 4 },
  scr_bitor      => { size => 4 },
  scr_bitxor     => { size => 4 },
  scr_bitnot     => { size => 4 },
  scr_assign     => { size => 4 },
  scr_bitandis   => { size => 4 },
  scr_bitoris    => { size => 4 },
  scr_bitxoris   => { size => 4 },
  scr_bitnotis   => { size => 4 },
  scr_shiftin    => { size => 4 },
  scr_shiftout   => { size => 4 },
  scr_shiftinis  => { size => 4 },
  scr_shiftoutis => { size => 4 },
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
print Dumper $result;

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
    $result->{$key} = eval(Dumper($instr->{$key}));
    $result->{$key}{mnem} = $key;
    $result->{$key}{instr} = eval("0x" . $instr->{$key}{opcode});
  }
}
