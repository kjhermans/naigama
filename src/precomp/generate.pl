#!/usr/bin/perl

my ($instrfile, $bytecodefile, $asmbytecodefile, $path) = (@ARGV);

my $instrstr = `cat $instrfile`;
my $instr = eval $instrstr;

my $bytecode = absorb_binary($bytecodefile);
$bytecodefile =~ s/\.byc$/.slotmap/;
my $slotmap = absorb_binary($bytecodefile);

my $asmbytecode = absorb_binary($asmbytecodefile);
$asmbytecodefile =~ s/\.byc$/.slotmap/;
my $asmslotmap = absorb_binary($asmbytecodefile);

write_instructions_file();
write_bytecode_file();
write_asmbytecode_file();
write_slotmap_file();
write_asmslotmap_file();

exit 0;

##---- functions ---------------------------------------------------------##

sub absorb_binary
{
  my $path = shift; die "$path not found" if (! -f $path);
  my $result = '';
  die "Error $@ opening $bytecodefile" if (!open(FILE, '<', $path));
  binmode FILE;
  my $buf;
  while (1) {
    my $n = sysread(FILE, $buf, 1024);
    if (!$n) {
      close FILE;
      return $result;
    }
    $result .= $buf;
  }
}

sub write_instructions_file
{
  open FILE, "> $path/instructions.h";
  foreach my $mnem (sort(keys(%{$instr}))) {
    print FILE "#define OPCODE_" . uc($mnem) . ' 0x' .
      sprintf("%.8x", $instr->{$mnem}{instr}) . "\n";
    print FILE "#define INSTR_" . uc($mnem) . ' "' . $mnem . "\"\n";
  }
  close FILE;
}

sub write_bytecode_file
{
  my $str = "#define GRAMMAR_BYTECODE \\\n  { \\\n    ";
  open FILE, "> $path/bytecode.h";
  my $n = 0;
  while (length($bytecode)) {
    $bytecode =~ s/^(.)//s;
    my $char = ord($1);
    $str .= sprintf("0x%.2x, ", $char);
    ++$n;
    if ($n == 8) {
      $str .= "\\\n    ";
      $n = 0;
    }
  }
  if ($n == 0) {
    $str =~ s/......$//s;
  }
  $str =~ s/, ( \\)?$//;
  print FILE $str . " \\\n  }\n";
  close FILE;
}

sub write_asmbytecode_file
{
  my $str = "#define ASSEMBLY_BYTECODE \\\n  { \\\n    ";
  open FILE, ">> $path/bytecode.h";
  my $n = 0;
  while (length($asmbytecode)) {
    $asmbytecode =~ s/^(.)//s;
    my $char = ord($1);
    $str .= sprintf("0x%.2x, ", $char);
    ++$n;
    if ($n == 8) {
      $str .= "\\\n    ";
      $n = 0;
    }
  }
  if ($n == 0) {
    $str =~ s/......$//s;
  }
  $str =~ s/, ( \\)?$//;
  print FILE $str . " \\\n  }\n";
  close FILE;
}

sub write_slotmap_file
{
  open FILE, "> $path/slotmap.h";
  print FILE "#define SLOTMAP_SWITCH \\\n";
  my $add_defines = '';
  while (length($slotmap)) {
    $slotmap =~ s/^(.{4})(.{4})//s || die "Illegal slotmap file";
    my ($i, $p) = ($1, $2);
    my $index = unpack('N', $i);
    my $parentindex = unpack('N', $p);
    $slotmap =~ s/^([^\0]+)\0// || die "Illegal slotmap file";
    my $ident = $1; $ident =~ s/_+$//; $ident =~ s/__/_/g;
    print FILE "  case $index: return \"$ident\"; break; \\\n";
    $add_defines .= "#define SLOT_$ident $index\n";
  }
  print FILE "\n\n" . $add_defines;
  close FILE;
}

sub write_asmslotmap_file
{
  open FILE, "> $path/asmslotmap.h";
  print FILE "#define ASMSLOTMAP_SWITCH \\\n";
  my $add_defines = '';
  while (length($asmslotmap)) {
    $asmslotmap =~ s/^(.{4})(.{4})//s || die "Illegal slotmap file";
    my ($i, $p) = ($1, $2);
    my $index = unpack('N', $i);
    my $parentindex = unpack('N', $p);
    $asmslotmap =~ s/^([^\0]+)\0// || die "Illegal slotmap file";
    my $ident = $1; $ident =~ s/_+$//; $ident =~ s/__/_/g;
    print FILE "  case $index: return \"$ident\"; break; \\\n";
    $add_defines .= "#define ASMSLOT_$ident $index\n";
  }
  print FILE "\n\n" . $add_defines;
  close FILE;
}

1;
