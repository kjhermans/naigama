#!/usr/bin/perl

use IO::Socket::INET;
use threads;

use Naigama;

my $config;
{
  my $configfile = "$root/etc/nais.conf";
  -f $configfile || die "NAIS_ROOT/etc/nais.conf must exist";
  my $configtext = `cat $configfile`;
  $config = eval($configtext);
}

my $naigama;
if ($config->{grammar}) {
  $naigama = Naigama->new($config->{grammar});
}
if ($config->{iface0}) {
  threads->create(\&service, $config->{iface0}{address}, $config->{iface0}{port});
}
if ($config->{iface1}) {
  threads->create(\&service, $config->{iface1}{address}, $config->{iface1}{port});
}
scheduler();

exit 0;

##---- functions ----------------------------------------------------------##

sub service
{
  my ($host, $port) = @_;

  my $sock = new IO::Socket::INET;
  {
    LocalHost => $host,
    LocalPort => $port,
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
          threads->create(\&handler, $data);
          last;
        } else {
          $data .= $chunk;
        }
      }
    }
  }
  
  sub handler {
    my $data = shift;
    if ($naigama) {
      my $outcome = $naigama->run($data);
    }
  }
}

sub scheduler
{
  while (1) {
    fprint STDERR, "Scheduler @" . time() . "\n";
    sleep(1);
  }
}

1;
