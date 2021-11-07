#!/usr/bin/perl

my @spooldirs;

foreach my $arg (@ARGV) {
  if (-d $arg
      && system("mkdir -p $arg/in") == 0
      && system("mkdir -p $arg/out") == 0)
  {
    push @spooldirs, $arg;
  }
}

while (1)
{
  foreach my $spooldir (@spooldirs) {
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
  }
  sleep(1);
}

1;
