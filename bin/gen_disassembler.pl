#!/usr/bin/perl

my $disasmpath = shift @ARGV;
my $instrpath = shift @ARGV;

my $disassembler = `cat $disasmpath`;

my $instrperl = `cat $instrpath`;
my $instrhash = eval $instrperl;

my $perl = '';
foreach my $key (sort(keys(%{$instrhash}))) {
  $perl .= "my \$INSTR_" . uc($key) . " = 0x$instrhash->{$key}{opcode};\n";
}

$disassembler =~ s/#DEADBEEF.*#DEADBEEF/#DEADBEEF\n$perl#DEADBEEF/s
  || die "Could not replace";

open FILE, '>', $disasmpath || die "Could not open";
print FILE $disassembler;
close FILE;

1;
