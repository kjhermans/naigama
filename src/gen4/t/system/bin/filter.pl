#!/usr/bin/perl

use AnyEvent::HTTPD;

my $httpd = AnyEvent::HTTPD->new (port => 9090);

my $ctr = 0;

sub handle_manage
{
  my ($httpd, $req) = @_;
}

sub handle_transaction
{
  my ($httpd, $req) = @_;
  $req->respond ({
    content => [
      'text/xml',
      "<transaction_id value=\"$ctr\"/>"
    ]
  });
  ++$ctr;
}

sub handle_upload
{
  my ($httpd, $req) = @_;
  my $file = '/tmp/filterupload_' . (++$ctr);
  open FILE, '>', $file;
  print FILE $req->parm('file');
  close FILE;
  $req->respond ({ content => ['text/html',
    "<html><body>FILE WRITTEN</body></html>"
  ]});
  my @cmd = (
    'naie',
    '-c', '/tmp/filter.byc',
    '-i', $file,
    ">$file.result"
    ,"2>/tmp/error.log"
  );
  print STDERR "Executing " . join(' ', @cmd) . "\n";
  if (system(join(' ', @cmd))) {
    print STDERR "Error executing; $@ = $?\n";
  } else {
    system("hexdump -C $file.result");
  }
}

sub handle_download
{
  my ($httpd, $req) = @_;
}

$httpd->reg_cb (
  '/manage' => \&handle_manage,
  '/transaction' => \&handle_transaction,
  '/upload' => \&handle_upload,
  '/download' => \&handle_download,
);

$httpd->run;
