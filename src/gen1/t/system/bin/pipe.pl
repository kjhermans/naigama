#!/usr/bin/perl

my $spooldir = shift;
my $remotehost = shift;

`mkdir -p $spooldir/in`;
`mkdir -p $spooldir/out`;

print STDERR "Starting up spooler in $spooldir\n";

while (1)
{
  if (opendir(DIR, "$spooldir/in")) {
    while (my $file = readdir(DIR)) {
      next if ($file =~ /^\.\.?$/ || -d $path_in || -x $path_in);
      my $path_in = "$spooldir/in/$file";
      my $path_out = "$spooldir/out/$file";
      print STDERR "Handling $path_in\n";
      if (system("$spooldir/handler $path_in $path_out")) {
        print STDERR "Error handling $path_in; $@ = $?\n";
      }
      unlink($path_in);
    }
    closedir(DIR);
  }
  system("$spooldir/fetcher $remotehost");
  sleep(1);
}

1;
