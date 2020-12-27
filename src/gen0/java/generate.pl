#!/usr/bin/perl

my $file = shift @ARGV;
my $instr = eval(`cat $file`);

print "package com.kj.naigama.general;

public class NaigamaInstructions
{
  public static final int OPCODE_TRAP = 0xffffffff;
";

foreach my $opcode (sort(keys(%{$instr}))) {
  print "  public static final int OPCODE_" .
        uc($opcode) . " = $instr->{$opcode}{instr};\n";
}

print "
}
";

1;
