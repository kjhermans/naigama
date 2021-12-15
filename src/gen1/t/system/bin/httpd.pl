#!/usr/bin/perl

my $dir = shift || '/tmp';

`mkdir -p $dir/in`;
`mkdir -p $dir/out`;

use AnyEvent::HTTPD;

my $httpd = AnyEvent::HTTPD->new (port => 9090);

my $ctr = 0;

print STDERR "Starting up httpd from $dir\n";

$httpd->reg_cb (
  '/upload' => sub
  {
    my ($httpd, $req) = @_;
    my $content = $req->parm('file');
    system('mkdir -p /tmp/leftspool/in');
    my $file = sprintf("msg_%08d", $ctr++);
    open FILE, "> $dir/in/$file";
    print FILE $content;
    close FILE;
    $req->respond ({ content => ['text/html',
      "<html><body>FILE $file WRITTEN</body></html>"
    ]});
    print STDERR "Written " . length($content) . " bytes in $dir/in/$file\n";
  },
);

$httpd->reg_cb (
  '/list' => sub
  {
    my ($httpd, $req) = @_;
    my $response = "<list>\n";
    my $log = '';
    if (opendir(DIR, "$dir/out")) {
      while (my $entry = readdir(DIR)) {
        if (-f "$dir/out/$entry") {
          $response .= "<item>$entry</item>\n";
          $log .= "$entry, ";
        }
      }
      closedir(DIR);
    }
    $response .= "</list>\n";
    $req->respond ({ content => ['text/html',
      $response
    ]});
    print STDERR "Written " . length($response) . " bytes in list; $log\n";
  },
);

$httpd->reg_cb (
  '/download' => sub
  {
    my ($httpd, $req) = @_;
    my $url = $req->url();
    if ($url =~ s/^.*\/download\///) {
      if (-f "$dir/out/$url") {
        my $content = `cat $dir/out/$url`;
        $req->respond ({ content => ['text/html',
          $content
        ]});
        unlink("$dir/out/$url");
      } else {
        $req->responsd([
            404, 'Not Found', {
            'Content-Type' => 'text/html'
          },
          "$url not found."
        ]);
      }
    }
  },
);

$httpd->run;
