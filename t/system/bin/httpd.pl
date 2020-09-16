#!/usr/bin/perl

use AnyEvent::HTTPD;

my $httpd = AnyEvent::HTTPD->new (port => 9090);

$httpd->reg_cb (
   '/upload' => sub {
      my ($httpd, $req) = @_;

      open FILE, '> /tmp/uploadedfile';
      print FILE $req->parm('file');
      close FILE;

      $req->respond ({ content => ['text/html',
        "<html><body>" .
        "FILE WRITTEN" .
        "</body></html>"
      ]});
     system('echo "foo" > /tmp/log');
   },
);

$httpd->run;
