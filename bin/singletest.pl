#!/usr/bin/perl

my $file = shift @ARGV;
my $compiler = shift @ARGV;
my $assembler = shift @ARGV;
my $engine = shift @ARGV;
my $replace = shift @ARGV;

my $test = `cat $file`;
my $n = 'single';
if ($file =~ /([0-9]+)\.tst$/) {
  $n = int($1);
}

my $tmpfile="/tmp/test$$";

if ($test =~ /-- (Replace|Capture|Grammar|Assembly):\s*\n(.*)\n-- (Input|Hexinput):\s*\n(.*)\n-- Result:(.*)$/s) {
  print "Test $file - ";
  my $action = $1;
  my $inputtype = $3;
  my (@fields) = ($2, $4, $5);
  $fields[2] =~ s/^\s+//; $fields[2] =~ s/\s+$//;
  if ($inputtype eq 'Hexinput') {
    my $bin = hexdecode($fields[1]);
    open FILE, "> $tmpfile.txt"; syswrite FILE, $bin; close FILE;
  } else {
    open FILE, "> $tmpfile.txt"; print FILE $fields[1]; close FILE;
  }
  if ($action eq 'Assembly') {
    open FILE, "> $tmpfile.asm"; print FILE $fields[0]; close FILE;
  } else {
    open FILE, "> $tmpfile.naig"; print FILE $fields[0]; close FILE;
    my $c = "$compiler";
    $c =~ s/GRAMMAR/$tmpfile.naig/g;
    $c =~ s/ASM/$tmpfile.asm/g;
    $c .= " 2>$tmpfile.$n.log";
    my $x = system($c);
    if ($x) {
      print "Compile NOK - ";
      if ($fields[2] eq 'ERR_COMP') {
        print "Test Ok\n";
      } else {
        print "Test NOK\n";
        system("mv $tmpfile.$n.log /tmp/failure.$n.log");
      }
      exit 0;
    } else {
      print "Compile Ok  - ";
    }
  }
  my $a = "$assembler";
  $a =~ s/ASM/$tmpfile.asm/g;
  $a =~ s/BYTECODE/$tmpfile.byc/g;
  $a .= " 2>>$tmpfile.$n.log";
  system("cat $tmpfile.asm >> $tmpfile.$n.log");
  my $x = system($a);
  system("ls -l $tmpfile.byc >> $tmpfile.$n.log");
  system("hexdump -C $tmpfile.byc >> $tmpfile.$n.log");
  system("../bin/disassembler $tmpfile.byc >> $tmpfile.$n.log");
  if ($x) {
    print "Assembly NOK - ";
    if ($fields[2] eq 'ERR_ASM') {
      print "Test Ok\n";
    } else {
      print "Test NOK\n";
      system("mv $tmpfile.$n.log /tmp/failure.$n.log");
    }
    exit 0;
  } else {
    print "Assembly Ok  - ";
  }
  my $e = "$engine";
  if ($action eq 'Replace') {
    $e = "$replace";
  }
  $e =~ s/BYTECODE/$tmpfile.byc/g;
  $e =~ s/INPUT/$tmpfile.txt/g;
  $e .= " >>$tmpfile.$n.log " . '2>&1';
  system("cat $tmpfile.txt >> $tmpfile.$n.log");
  my $x = system($e);
  if ($x) {
    print "Engine NOK - ";
    if ($fields[2] eq 'NOK') {
      print "Test Ok\n";
    } else {
      print "Test NOK\n";
      system("mv $tmpfile.$n.log /tmp/failure.$n.log");
    }
    exit 0;
  } else {
    print "Engine Ok  - ";
    if ($fields[2] eq 'OK') {
      print "Test Ok\n";
      system("mv $tmpfile.$n.log /tmp/success.$n.log");
    } else {
      print "Test NOK\n";
      system("mv $tmpfile.$n.log /tmp/failure.$n.log");
    }
  }
}

system("rm $tmpfile.*");

sub hexdecode
{
  my $hex = shift;
  my $res = '';
  while (length($hex)) {
    $hex =~ s/^(.)//s;
    my $char = $1;
    if ($char =~ /^[a-fA-F0-9]$/) {
      $hex =~ s/^([a-fA-F0-9])// || return undef;
      my $char2 = $1;
      $res .= chr(hex("$char$char2"));
    }
  }
  return $res;
}

1;
