#!/usr/bin/perl

my $instrfile = shift @ARGV;
my $instrtext = `cat $instrfile`;
my $instrhash = eval $instrtext;

print "
use crate::errors::NaigError;

#[allow(non_camel_case_types)]

pub enum NaigInstruction {

";

foreach my $key (sort(keys(%{$instrhash}))) {
  print "  INSTR_" . uc($key) . " = 0x" . $instrhash->{$key}{opcode} . ",\n";
}

print "

}

impl NaigInstruction {

  pub fn from_usize
    (n: usize)
    -> Result<NaigInstruction, NaigError>
  {
    match n {
";

foreach my $key (sort(keys(%{$instrhash}))) {
  print "      0x" . $instrhash->{$key}{opcode} .
        " => { return Ok(NaigInstruction::INSTR_" . uc($key) . "); },\n";
}

print "      _ => { return Err(crate::errors::NaigError::BadOpcode); }
    };
  }
}
";

1;
