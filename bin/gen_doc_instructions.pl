#!/usr/bin/perl

my $instr = shift @ARGV;

my $s = `cat $instr`;
my $structure = eval($s);

my $texindex = '';
foreach my $key (sort keys(%{$structure})) {
  $texindex .=
    "\\newpage\n" .
    "\\input{instr_" . lc($key) . ".tex}\n\n";
  my $instrfile = './instr_' . lc($key) . '.tex';
  if (! -f $instrfile) {
    open INSTR, '>', $instrfile;
    print INSTR
      "\\subsection{Instruction: " . $key . "}\n\n" . 
      "\\subsubsection{Summary}\n\n" .
      "\\subsubsection{Grammar and Compiling}\n\n" .
      "\\subsubsection{Assembly Syntax}\n\n" .
'\\begin{myquote}
\\begin{verbatim}

\\end{verbatim}
\\end{myquote}

' .
      "\\subsubsection{Bytecode Encoding}\n\n" .
      "This instruction is structured in bytecode as follows:\n\n" .
      "\%DEADBEEF\n" .
      "\%DEADBEEF\n" .
      "\\subsubsection{Execution State Change}\n\n" .
'.

Original state: \\textit{(p, i, e, c)}

Operation: \\textbf{any} ; i \\ \\textless \\ $\\vert$S$\\vert$

Failure state: \\textit{(\\textbf{Fail}, i, e, c)}

Success state: \\textit{(p + 1, i + 1, e, c)}

' .
      "";
    close INSTR;
  }
  my $texbytes =
#    "\\newline\n" .
    '$_0$\ ' . "\n" .
    '\\fbox{%' . "\n" .
    '  \\parbox{20pt}{%' . "\n" .
    sprintf("%.2x", (($structure->{$key}{instr} >> 24) & 0xff)) . "\n" .
    '  }%' . "\n" .
    '}' . "\n" .
    '\\fbox{%' . "\n" .
    '  \\parbox{20pt}{%' . "\n" .
    sprintf("%.2x", (($structure->{$key}{instr} >> 16) & 0xff)) . "\n" .
    '  }%' . "\n" .
    '}' . "\n" .
    '\\fbox{%' . "\n" .
    '  \\parbox{20pt}{%' . "\n" .
    sprintf("%.2x", (($structure->{$key}{instr} >> 8) & 0xff)) . "\n" .
    '  }%' . "\n" .
    '}' . "\n" .
    '\\fbox{%' . "\n" .
    '  \\parbox{20pt}{%' . "\n" .
    sprintf("%.2x", (($structure->{$key}{instr} >> 0) & 0xff)) . "\n" .
    '  }%' . "\n" .
    '}' . "\n";
  replace($instrfile, '%DEADBEEF', '%DEADBEEF', $texbytes);
}

replace('./compendium.tex', '%DEADBEEF', '%DEADBEEF', $texindex);

sub replace
{
  my ($path, $begin, $end, $replace) = @_;
  my $contents = `cat $path`;
  if ($contents =~ s/$begin.*$end/$begin\n$replace\n$end/s) {
    open FILE, '>', $path;
    print FILE $contents;
    close FILE;
  }
}

1;
