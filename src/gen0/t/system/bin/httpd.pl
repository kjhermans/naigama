#!/usr/bin/perl

use AnyEvent::HTTPD;

my $httpd = AnyEvent::HTTPD->new (port => 9090);

my $ctr = 0;

$httpd->reg_cb (
   '/upload' => sub
   {
     my ($httpd, $req) = @_;
     open FILE, '> /tmp/uploadedfile';
     print FILE $req->parm('file');
     close FILE;
     $req->respond ({ content => ['text/html',
       "<html><body>FILE WRITTEN</body></html>"
     ]});
   },
   '/upload_xml' => sub
   {
     my ($httpd, $req) = @_;
     system('mkdir -p /tmp/leftspool/in');
     my $file = sprintf("msg_%08d.xml", $ctr++);
     open FILE, "> /tmp/leftspool/in/$file";
     print FILE $req->parm('file');
     close FILE;
     $req->respond ({ content => ['text/html',
       "<html><body>FILE $file WRITTEN</body></html>"
     ]});
   },
);

$httpd->run;
