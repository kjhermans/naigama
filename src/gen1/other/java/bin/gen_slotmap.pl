#!/usr/bin/perl

##
## Generates java file out of a slotmap
##

my $smfile = shift;
my $package = shift;
my $slotmap = absorb_binary($smfile);

print "
package $package;

public class Slotmap {

";

my $map = {};
while (length($slotmap)) {
  $slotmap =~ s/^.(.)(.)(.)//s;# || die "Not a proper slotmap file (1)";
  my $slot = ord($1) << 16 | ord($2) << 8 | ord($3);
  $slotmap = substr($slotmap, 4);
  $slotmap =~ s/^([^\0]+)\0//;# || die "Not a proper slotmap file (3)";
  print "  public static final int SLOT_" . uc($1) . " = $slot;\n";
  $map->{$1} = $slot;
}

print "

  private int slot = -1;
  public Slotmap(int s) { slot=s; }
  public String toString()
  {
    switch(slot) {
";

foreach my $key (sort(keys(%{$map}))) {
  print "    case $map->{$key}: return \"SLOT_" . uc($key) . "\";\n";
}

print "    default: return \"Unknown slot\";
    }
  }
}
";

exit 0; ##---- end ---------------------------------------------------------##

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
