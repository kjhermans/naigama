#!/usr/bin/perl

my $instrfile = shift;
my $instrperl = `cat $instrfile`;
my $instr = eval($instrperl);

print "package Naigama::Instructions;

";

foreach my $key (sort(keys(%{$instr}))) {
  print "our \$INSTR_" . uc($key) .
        " = 0x" . $instr->{$key}{opcode} . ";\n";
}

print "
sub get_opcode_string
{
  my \$opcode = shift;
";

foreach my $key (sort(keys(%{$instr}))) {
  print "  if (\$opcode == 0x" . $instr->{$key}{opcode} . ") { return \"" . $key . "\"; }\n";
}

print "  return \"Unknown opcode\";
}
";

1;
