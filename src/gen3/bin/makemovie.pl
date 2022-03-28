#!/usr/bin/perl

use Data::Dumper;
use GD;

my ($grammar, $asm, $input) = @ARGV;

my $ctroff = 0;
my $width = 800;
my $height = 600;
my $dir = "/tmp/movie_$$"; 
my $framerate = 8;
my $movie = '/tmp/movie.mp4';

`rm -rf $dir && mkdir -p $dir`;

my @queue;

if (defined($grammar)) {
  make_title('Grammar', `cat $grammar`);
}
if (defined($asm)) {
  make_title('Assembly', `cat $asm`);
}
if (defined($input)) {
  make_title('Input', `cat $input`);
}

while (1) {
  if (my $rec = gather_record()) {
    $rec = process_record($rec);
    make_image($rec);
  } else {
    last;
  }
}

make_movie();

exit 0;

##---- functions ----------------------------------##

sub gather_record
{
  my $result = [];
  my $sep = 0;
  while (my $line = <STDIN>) {
    $line =~ s/\s*\r?\n?$//;
    if (length($line)) {
      push @queue, $line;
      if ($line =~ /^====/) {
        last if (++$sep == 8);
      }
    }
  }
  $sep = 0;
  while (scalar(@queue)) {
    my $line = shift @queue;
    if ($line =~ /^====/) {
      if (++$sep == 2) {
        unshift @queue, $line;
        last;
      }
    }
    push @{$result}, $line;
  }
  if (!(scalar(@{$result}))) {
    return undef;
  }
  return $result;
}

sub process_record
{
  my $record = shift;
  my $result = {};
  for (my $i=0; $i < scalar(@{$record}); $i++) {
    my $line = $record->[ $i ];
    if ($line =~ /^==== Step ([0-9]+)/) {
      $result->{index} = $1;
    } elsif ($line =~ /^State:\s*(.*)$/) {
      $result->{state} = $1;
    } elsif ($line =~ /^Opcode:\s*([A-Z_]+)$/) {
      $result->{opcode} = $1;
    } elsif ($line =~ /^Bytecode pos:\s*([0-9]+)$/) {
      $result->{bytecode_pos} = $1;
    } elsif ($line =~ /^Input char:\s*0x([a-fA-F0-9]+)$/) {
      $result->{input_char} = $1;
    } elsif ($line =~ /^Input string:\s*([a-fA-F0-9 ]+)$/) {
      my @list = split(/ /, $1);
      $result->{input_string} = \@list;
    } elsif ($line =~ /^Input pos:\s*([0-9]+)$/) {
      $result->{input_pos} = $1;
    } elsif ($line =~ /^Input length:\s*([0-9]+)$/) {
      $result->{input_len} = $1;
    } elsif ($line =~ /^Param1:\s*(.*)$/) {
      $result->{param1} = $1;
    } elsif ($line =~ /^Register_ilen:\s*([0-9]+)$/) {
      $result->{reg_ilen} = $1;
    } elsif ($line =~ /^Register_ilen_set:\s*([0-9]+)$/) {
      $result->{reg_ilen_set} = $1;
    } elsif ($line =~ /^Max stack depth:\s*([0-9]+)$/) {
      $result->{max_stack_depth} = $1;
    } elsif ($line =~ /^Stack:/) {
      $result->{stack} = [];
      for (++$i; $i < scalar(@{$record}); $i++) {
        $line = $record->[ $i ];
        if ($line !~ /^  /) { --$i; last; }
        if ($line =~ /^\s*([0-9]+); (CLL|ALT):([0-9]+)\s*(.*)\s*(len|pos)=([0-9]+)/) {
          push @{$result->{stack}}, {
            index => $1,
            type => $2,
            offset => $3,
            label => $4,
            lenpos => $5,
            lpvalue => $6
          };
        }
      }
    } elsif ($line =~ /^Capturelist:/) {
      $result->{captures} = [];
      for (++$i; $i < scalar(@{$record}); $i++) {
        $line = $record->[ $i ];
        if ($line !~ /^  /) { --$i; last; }
        if ($line =~ /^\s*Action #([0-9]+); act=(Cc|Co), slot=([0-9]+), pos=([0-9]+), sl=([0-9]+), int=([0-9]+) (.*)/) {
          push @{$result->{captures}}, {
            index => $1,
            type => $2,
            slot => $3,
            pos => $4,
            sl => $5,
            int => $6,
            slotname => $7
          };
        }
      }
    }
  }
  return $result;
}

sub make_image
{
  my $rec = shift;
  my $im = new GD::Image($width, $height);
  my $white = $im->colorAllocate(255,255,255);
  my $black = $im->colorAllocate(0,0,0);       
  my $red = $im->colorAllocate(255,0,0);      
  my $blue = $im->colorAllocate(0,0,255);
  my $green = $im->colorAllocate(0,128,0);
  if ($rec->{index} % 128 eq '0') {
    print STDERR "Frame $rec->{index}\n";
  }
  $im->line(8, $height - 48, $width - 8, $height - 48, $blue);
  for (my $i=0; $i < scalar(@{$rec->{input_string}}); $i++) {
    $im->string(gdSmallFont, 16 + $i * 16, $height - 46, $rec->{input_string}[ $i ], $blue);
    my $chr = hex($rec->{input_string}[ $i ]);
    if ($chr > 31 && $chr < 127) {
      $im->string(gdSmallFont, 16 + $i * 8, $height - 30, chr($chr), $blue);
    } else {
      $im->string(gdSmallFont, 16 + $i * 8, $height - 30, '.', $blue);
    }
  }
  if ($rec->{state} eq 'FAIL') {
    $im->string(gdSmallFont, 16, 16, "FAIL", $red);
  } else {
    my $str = $rec->{opcode};
    if ($rec->{param1}) {
      $str .= " $rec->{param1}";
    }
    $im->string(gdSmallFont, 16, 16, "Opcode: $str", $black);
  }
  $im->string(gdSmallFont, 16, 32, "Bytecode pos: $rec->{bytecode_pos}", $black);
  $im->string(gdSmallFont, 16, 48, "Input pos: $rec->{input_pos}", $black);
  $im->string(gdSmallFont, 16, 64, "Input length: $rec->{input_len}", $black);
  $im->string(gdSmallFont, 16, 80, "Reg_ilen: $rec->{reg_ilen}", $black);
  $im->string(gdSmallFont, 16, 96, "Reg_ilen_set: $rec->{reg_ilen_set}", $black);
  $im->string(gdSmallFont, 16, 112, "Stack size: " . scalar(@{$rec->{stack}}), $black);
  $im->string(gdSmallFont, 16, 128, "Captures size: " . scalar(@{$rec->{captures}}), $black);
  my $off = 0;
  my $hil = int($height / 16) - 5;
  if (scalar(@{$rec->{stack}}) > $hil) {
    $off = scalar(@{$rec->{stack}}) - $hil;
  }
  for ($i=$off; $i < scalar(@{$rec->{stack}}); $i++) {
    $im->string(
      gdSmallFont,
      int($width / 5),
      $height - 16 - ((3 + ($i - $off)) * 16),
      sprintf(
        "%3d: %s %4d %3d %s",
        $i,
        $rec->{stack}[$i]{type},
        $rec->{stack}[$i]{offset},
        $rec->{stack}[$i]{lpvalue},
        $rec->{stack}[$i]{label}
      ),
      $green
    );
  }
  $off = 0;
  if (scalar(@{$rec->{captures}}) > $hil) {
    $off = scalar(@{$rec->{captures}}) - $hil;
  }
  for ($i=$off; $i < scalar(@{$rec->{captures}}); $i++) {
    $im->string(
      gdSmallFont,
      3 * int($width / 5),
      $height - 16 - ((3 + ($i - $off)) * 16),
      sprintf(
        "%3d: %s %3d %4d %s",
        $i,
        $rec->{captures}[$i]{type},
        $rec->{captures}[$i]{slot},
        $rec->{captures}[$i]{pos},
        $rec->{captures}[$i]{slotname}
      ),
      $green
    );
  }

  open FILE, '>', sprintf("%s/frame_%.6d.png", $dir, $rec->{index} + $ctroff);
  print FILE $im->png;
  close FILE;
}

sub make_title
{
  my $title = shift;
  my @lines = @_;
  my $done = 0;
  my $wait = 32;
  while (!$done) {
    my $im = new GD::Image($width, $height);
    my $white = $im->colorAllocate(255,255,255);
    my $black = $im->colorAllocate(0,0,0);       
    $im->line(8, $height - 32, $width - 8, $height - 32, $black);
    $im->string(gdSmallFont, 16, $height - 30, $title, $black);
    $done = 1;
    for (my $i=0; $i < scalar(@lines); $i++) {
      my $line = $lines[ $i ];
      $line =~ s/\r?\n$//;
      $im->string(gdSmallFont, 16, 16 + $i * 16, $line, $black);
      if (80 + $i * 16 > $height) {
        $done = 0;
        shift @lines;
        last;
      }
    }
    if ($done) {
      $wait = 32;
    }
    for (my $i=0; $i < $wait; $i++) {
      open FILE, '>', sprintf("%s/frame_%.6d.png", $dir, $ctroff++);
      print FILE $im->png;
      close FILE;
    }
    if (!$done) {
      $wait = 1;
    }
  }
}

sub make_movie
{
  my $cmd =
    "cd $dir && ffmpeg -r $framerate -i frame_\%06d.png -c:v libx264 ".
    "-vf \"fps=25,format=yuv420p\" $movie";
  system($cmd);
}

1;
