#!/usr/bin/perl

my $release = shift @ARGV;
print "

pub static RELEASE: &str = \"$release\";

";
