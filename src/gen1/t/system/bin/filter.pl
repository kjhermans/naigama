#!/usr/bin/perl

use AnyEvent::HTTPD;

my $host = shift || '0.0.0.0';
my $outdir = shift || "/tmp/out";
my $indir = shift || "/tmp/in";

if (! -d $outdir) { `mkdir -p $outdir`; }
if (! -d $indir) { `mkdir -p $indir`; }

print STDERR "Starting up filter from $outdir $indir\n";

my $httpd = AnyEvent::HTTPD->new (host => $host, port => 9090);

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
  my $file = '/tmp/filterupload_' . $$ . '_' . (++$ctr);
  open FILE, '>', $file;
  print FILE $req->parm('file');
  close FILE;
  $req->respond ({ content => ['text/html',
    "<html><body>FILE WRITTEN</body></html>"
  ]});
  print STDERR "Upload: $file\n";
  my @cmd = (
    'naie',
    '-S',
    '-t',
    '-c', '/tmp/filter.byc',
    '-i', $file,
    ">$file.result",
    "2>/tmp/error.log"
  );
  print STDERR "Executing " . join(' ', @cmd) . "\n";
  if (system(join(' ', @cmd))) {
    log("Error executing; $@ = $?");
  } else {
    transfer($file);
  }
}

sub log
{
  my $string = shift;
  ##.. send out on UDP 514
}

sub transfer
{
  my $file = shift;
  print STDERR "Moving $file to $outdir\n";
  `mv $file $outdir`;
}

sub handle_download
{
  my ($httpd, $req) = @_;
  my $url = $req->url();
  if ($url =~ s/^.*\/download\///) {
    if (-f "$indir/$url") {
      my $content = `cat $indir/$url`;
      $req->respond ({ content => ['text/html',
        $content
      ]});
      unlink("$indir/$url");
      print STDERR "Download $url\n";
    } else {
      $req->responsd([
          404, 'Not Found', {
          'Content-Type' => 'text/html'
        },
        "$url not found."
      ]);
    }
  }
}

## Lists downloadable files.
## (Files that have been put in my download dir by the opposing filter.pl)

sub handle_list
{
  my ($httpd, $req) = @_;
  opendir DIR, $indir;
  my $list = "<list>\n";
  my $log = '';
  while (my $entry = readdir(DIR)) {
    if (-f "$indir/$entry") {
      $list .= '<item>' . $entry . '</item>' . "\n";
      $log .= $entry . ', ';
    }
  }
  $list .= "</list>\n";
  print STDERR "List $log\n";
  $req->respond ({
    content => [
      'text/xml',
      $list
    ]
  });
}

$httpd->reg_cb (
  '/manage' => \&handle_manage,
  '/transaction' => \&handle_transaction,
  '/upload' => \&handle_upload,
  '/download' => \&handle_download,
  '/list' => \&handle_list,
);

$httpd->run;
