#!/usr/bin/perl

##
## This script copies, in order, all object files, and the contents
## of object archives, to a single directory, and then creates a
## single object archive out of them.
##

my $result = shift @ARGV;
my $rfilename = "$result";
$rfilename =~ s/^.*\/([^\/]+)$/$1/;

my $dir = "/tmp/arrear_$$";
mkdir $dir or die "Could not make dir";

while (my $objlib = shift @ARGV) {
  if ($objlib =~ /\.a$/) {
    my $filename = "$objlib";
    $filename =~ s/^.*\/([^\/]+)$/$1/;
    system("cp $objlib $dir");
    system("cd $dir && ar -x $filename");
    system("rm -f $dir/$filename");
  } elsif ($objlib =~ /\.o$/) {
    system("cp $objlib $dir");
  } else {
    system("rm -rf $dir");
    die "$objlib: Can't handle anything but .a and .o files";
  }
}

system("cd $dir && ar -rcs $result *.o");
system("mv $dir/$rfilename $result");
system("rm -rf $dir");

1;
