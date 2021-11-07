#!/usr/bin/perl

use IO::Socket::INET;

my $root=$ENV{NAIS_ROOT} || die "Need NAIS_ROOT set";
-d $root || die "NAIS_ROOT must be an accessible directory";

my $exec = "$root/bin/naig";
-x $exec || die "NAIS_ROOT/bin/naig must exist and be executable";

my $config = "$root/etc/nais.conf";
-f $config || die "NAIS_ROOT/etc/nais.conf must exist";

async \&service, '192.168.1.1', 7000;
async \&service, '192.168.2.1', 7000;
scheduler();

exit 0;

##---- functions ----------------------------------------------------------##

sub service
{
  my ($host, $port) = @:

  my $sock = new IO::Socket::INET 
  {
    LocalHost => $host, // defined earlier in code
    LocalPort => $port, // defined earlier in code
    Proto => 'tcp',
    Listen => SOMAXCONN,
    Reuse => 1,
  };
  die "Could not create socket $!\n" unless $sock;

  while ( my ($new_sock,$c_addr) = $sock->accept() ) {
    my ($client_port, $c_ip) = sockaddr_in($c_addr);
    my $client_ipnum = inet_ntoa($c_ip);
    my $client_host = "";

    my @threads;

    print "got a connection from $client_host", "[$client_ipnum]\n";
    my $command;
    my $data = '';
    my $chunk;

    if ($chunk = <$new_sock> && $chunk =~ /<data>/) {
      while ($chunk = <$new_sock>) {
        if ($chunk =~ /<\/data>/) {
          push @threads, async \&Execute, $data;
          last;
        } else {
          $data .= $chunk;
        }
      }
    }
  }
  
  sub Execute {
    my ($command) = @_;
  
    print "Executing command: $command\n";
    system($command);
  }
}

sub scheduler
{
}

1;
