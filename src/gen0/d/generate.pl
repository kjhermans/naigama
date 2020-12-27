#!/usr/bin/perl

my $instructionsfile = shift;
my $texdir = shift || '.';

my $instructionshash = `cat $instructionsfile`;
my $instructions = eval $instructionshash;

open FILE, '> table_instr.tex';

print FILE '
\\begin{table}[]
\\centering
\\caption{Naigama Assembly Instructions}
\\label{tab:naig_assembly}
\\begin{tabular}{llll}
\\textbf{Mnemonic} & \\textbf{Param1} & \\textbf{Param2} & \\textbf{Terse} \\\\
';

foreach my $i (sort(keys(%{$instructions}))) {
  my $p1 = $instructions->{$i}{param1};
  my $p2 = $instructions->{$i}{param2};
  my $te = $instructions->{$i}{terse} ? 'v' : '';
  if ($p1 eq 'address') { $p1 = 'LABEL'; }
  if ($p2 eq 'address') { $p2 = 'LABEL'; }
  if ($p1 eq 'LABEL' && $p2 ne '-') {
    my $tmp = $p1; $p1 = $p2; $p2 = $tmp;
  }
  next if ($i =~ /^scr_/);
  my $_i = $i;
  $_i =~ s/_/\\_/g;
  print FILE "'$_i' \& $p1 \& $p2 \& $te \\\\\n";
}

print FILE '\\end{tabular}
\\end{table}
';
close FILE;

open FILE, '> table_bytecode.tex';

print FILE '
\\begin{table}[]
\\centering
\\caption{Naigama Bytecode Instructions}
\\label{tab:naig_bytecode}
\\begin{tabular}{lllll}
\\textbf{Mnemonic} & \\textbf{Opcode} & \\textbf{Param1} & \\textbf{Param2} & \\textbf{Length} \\\\
';

foreach my $i (sort(keys(%{$instructions}))) {
  my $_i = $i;
  $_i =~ s/_/\\_/g;
  next if ($i =~ /^scr_/);
  print FILE $_i . ' & ' . sprintf("%.8x", $instructions->{$i}{instr}) .
    " \& $instructions->{$i}{param1} \& $instructions->{$i}{param2} " .
    " \& $instructions->{$i}{size} " .
    "\\\\\n";
}

print FILE '\\end{tabular}
\\end{table}
';
close FILE;

1;
