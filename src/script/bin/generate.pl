#!/usr/bin/perl

my (
  $bytecodefile,
  $path
) = (@ARGV);

print STDERR "Absorbing bytecode file $bytecodefile\n";
my $bytecode = absorb_binary($bytecodefile);

my $slotmapfile = "$bytecodefile";
$slotmapfile =~ s/\.byc$/.slotmap/;
print STDERR "Absorbing slotmap file $slotmapfile\n";
my $slotmap = absorb_binary($slotmapfile);

my $h_bytecode = "$bytecodefile";
$h_bytecode =~ s/\.byc$/_bytecode.h/;
$h_bytecode =~ s/^.*\/([^\/]+)$/$1/;
$h_bytecode = "$path/$h_bytecode";

my $h_slotmap = "$bytecodefile";
$h_slotmap =~ s/\.byc$/_slotmap.h/;
$h_slotmap =~ s/^.*\/([^\/]+)$/$1/;
$h_slotmap = "$path/$h_slotmap";

write_bytecode_file();
write_slotmap_file();

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

sub write_bytecode_file
{
  my $str = "#define BYTECODE \\\n  { \\\n    ";
  open FILE, "> $h_bytecode";
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

sub write_slotmap_file
{
  open FILE, "> $h_slotmap";
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

1;
