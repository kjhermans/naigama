#!/usr/bin/perl

my $bcfile = shift;
my $package = shift;

my $bc = absorb_binary($bcfile) || die "No bytecode given.";

print "package $package;

public class Grammar
{
  public static byte[] bytecode = {";

for (my $i=0; $i < length($bc); $i++) {
  if (($i % 4) == 0) {
    print "\n    ";
  }
  print sprintf("(byte)0x%.2x", ord(substr($bc, $i, 1)));
  if ($i < length($bc) - 1) {
    print ", ";
  }
}

print "
  };
}
";

exit 0;

##----

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

1;
