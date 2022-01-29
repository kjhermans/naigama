#!/usr/bin/perl

my $instrfile = shift;
my $instrperl = `cat $instrfile`;
my $instr = eval($instrperl);

print "package lib.naigama;

public class Instructions
{
";

foreach my $key (sort(keys(%{$instr}))) {
  print "  public static final int INSTR_" . uc($key) .
        " = 0x" . $instr->{$key}{opcode} . ";\n";
}

print "

  public static int getSize
    (int opcode)
  {
    return ((opcode >> 16) & 0xff) + 4;
  }

  public static String getString
    (int opcode)
  {
    switch (opcode) {
";

foreach my $key (sort(keys(%{$instr}))) {
  print "    case 0x" . $instr->{$key}{opcode} . ": return \"" . $key . "\";\n";
}

print "    default: return \"Unknown opcode\";
    }
  }
}
";

1;
