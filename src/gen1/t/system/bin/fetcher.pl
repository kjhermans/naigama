#!/usr/bin/perl

my $url = shift;
my $dir = shift;

print STDERR "Fetcher starting up with $host -> $dir\n";

while (1) {
  my $list = `wget -q $url/list -O -`;
  while ($list =~ s/<item>(.*?)<\/item>//) {
    my $item = $1;
    print STDERR "Fetcher fetching $item to $dir.\n";
    my $content = `wget -q $url/download/$item -O -`;
    if (open(FILE, '>', "$dir/$item")) {
      print FILE $content;
      close FILE;
    }
  }
  sleep(1);
}

1;
