#!/usr/bin/perl

my $file = shift @ARGV;
my $compiler = shift @ARGV;
my $assembler = shift @ARGV;
my $engine = shift @ARGV;

my $test = `cat $file`;
my $n = '0';
if ($file =~ /([0-9]+)\.tst$/) {
  $n = int($1);
}

my $tmpfile="/tmp/bitfault_$n";

if ($test =~ /-- (Grammar):\s*\n(.*)\n-- (Input|Hexinput):\s*\n(.*)$/s) {
  print "Test $file - ";
  my $action = $1;
  my $inputtype = $3;
  my (@fields) = ($2, $4);
  $fields[2] =~ s/^\s+//; $fields[2] =~ s/\s+$//;
  if ($inputtype eq 'Hexinput') {
    my $bin = hexdecode($fields[1]);
    $fields[ 1 ] = $bin;
  }
  open FILE, "> $tmpfile.c";
  print FILE "

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include <naigama/naigama.h>
#include <naigama/engine/naie.h>
#include <naigama/disassembler/naid.h>

static unsigned char input[] = {
";
  for (my $i=0; $i < length($fields[1]); $i++) {
    print FILE "0x" . sprintf("%.2x%s", ord(substr($fields[1], $i, 1)), ($i < length($fields[1])-1?", ":""));
  }
  print FILE "
};

static char grammar[] = {
";

  for (my $i=0; $i < length($fields[0]); $i++) {
    print FILE "0x" . sprintf("%.2x", ord(substr($fields[0], $i, 1))) . ", ";
  }
  print FILE '0x00
};

#include <stdarg.h>

static NAIG_ERR_T debdis
  (void* ptr, char* fmt, ...)
{
  FILE* f = (FILE*)ptr;
  va_list ap;
  va_start(ap, fmt);
  vfprintf(f, fmt, ap);
  return NAIG_OK;
}

int main(int argc, char* argv[])
{
  unsigned i;
  naig_t naigama;
  naie_engine_t engine;
  naie_result_t result;
  (void)argc;
  (void)argv;
  unsigned occurence[ 1024 ] = { 0 };
  NAIG_ERR_T e;

  memset(&naigama, 0, sizeof(naigama));
  naig_compile(&naigama, grammar, 0);

  e = naie_engine_init(&engine, naigama.bytecode, naigama.bytecode_length, input, sizeof(input));
  engine.config.maxnoinstructions = 500000;
  e = naie_engine_run(&engine, &result);
  if (e.code) {
    printf("PROGRAM ENDED IN ERROR %d\n", e.code);
    exit(-1);
  }

  FILE* file = fopen("/tmp/orig_' . $n . '.asm", "w");
  naid_disassemble(naigama.bytecode, naigama.bytecode_length, debdis, file);
  logmem(file, naigama.bytecode, naigama.bytecode_length);
  fclose(file);

  for (i=0; i < naigama.bytecode_length * 8; i++) {
    unsigned offset = i / 8;
    unsigned char mask = 1 << (i % 8);
    unsigned char bytecodecopy[ naigama.bytecode_length ];
    memcpy(bytecodecopy, naigama.bytecode, naigama.bytecode_length);
    bytecodecopy[ offset ] ^= mask;
    e = naie_engine_init(&engine, bytecodecopy, naigama.bytecode_length, input, sizeof(input));
    engine.config.maxnoinstructions = 500000;
    e = naie_engine_run(&engine, &result);
    ++(occurence[ 512 - e.code ]);
    if (e.code == 0) {
      char path[ 1024 ];
      char cmd[ 1024 ];
      snprintf(path, sizeof(path), "/tmp/bitfault_' . $n . '_%u.asm", i);
      file = fopen(path, "w");
      fprintf(file, "-- Bit %u; exit code %d\n", i, e.code);
      naid_disassemble(bytecodecopy, naigama.bytecode_length, debdis, file);
      logmem(file, bytecodecopy, naigama.bytecode_length);
      fclose(file);
      snprintf(cmd, sizeof(cmd), "diff /tmp/orig_' . $n . '.asm /tmp/bitfault_' . $n . '_%u.asm", i);
      system(cmd);
      system("echo");
      system("echo ooooooooooooooooooo");
      system("echo");
      unlink(path);
    }
  }
  for (i=0; i < 1024; i++) {
    if (occurence[ i ]) {
      fprintf(stderr, "Code %d occurence %u\n", (512 - i), occurence[ i ]);
    }
  }
}
';
  close FILE;

  my $ROOT = $ENV{BUILDROOT};
  my $cmd =
    "gcc -g -Wall -Wextra " .
    "-I$ROOT/src/gen2/include " .
    "-o /tmp/bf_$n.exe $tmpfile.c " .
    "$ROOT/src/gen2/lib/naigama/libnaigama.a";
  print STDERR "$cmd\n";
  if (system($cmd)) {
    die "Error on compilation";
  }
  system("/tmp/bf_$n.exe");
}

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
