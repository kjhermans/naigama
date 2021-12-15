#!/usr/bin/perl

my $dir = shift;
my $url = shift;

print STDERR "Pusher started with $dir -> $url\n";

while (1) {
  if (opendir(DIR, $dir)) {
    while (my $entry = readdir(DIR)) {
      if (-f "$dir/$entry") {
        print STDERR "Found $entry to send to $url\n";
        system("curl -s -o /dev/null -F file=\@$dir/$entry $url 2>&1");
        unlink("$dir/$entry");
      }
    }
    closedir(DIR);
  }
  sleep(1);
}

1;
