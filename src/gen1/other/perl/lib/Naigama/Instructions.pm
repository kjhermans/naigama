package Naigama::Instructions;

our $INSTR_ANY = 0x000003e4;
our $INSTR_BACKCOMMIT = 0x000403c0;
our $INSTR_CALL = 0x00040382;
our $INSTR_CATCH = 0x00040393;
our $INSTR_CHAR = 0x000403d7;
our $INSTR_CLOSECAPTURE = 0x00040300;
our $INSTR_COMMIT = 0x00040336;
our $INSTR_CONDJUMP = 0x00080321;
our $INSTR_COUNTER = 0x00080356;
our $INSTR_END = 0x000400d8;
our $INSTR_ENDREPLACE = 0x00000399;
our $INSTR_FAIL = 0x0000034b;
our $INSTR_FAILTWICE = 0x00000390;
our $INSTR_JUMP = 0x00040333;
our $INSTR_MASKEDCHAR = 0x00080365;
our $INSTR_NOOP = 0x00000000;
our $INSTR_OPENCAPTURE = 0x0004039c;
our $INSTR_PARTIALCOMMIT = 0x000403b4;
our $INSTR_QUAD = 0x0004037e;
our $INSTR_RANGE = 0x000803bd;
our $INSTR_REPLACE = 0x00080348;
our $INSTR_RET = 0x000003a0;
our $INSTR_SET = 0x002003ca;
our $INSTR_SKIP = 0x00040330;
our $INSTR_SPAN = 0x002003e1;
our $INSTR_TESTANY = 0x00040306;
our $INSTR_TESTCHAR = 0x0008039a;
our $INSTR_TESTQUAD = 0x000803db;
our $INSTR_TESTSET = 0x00240363;
our $INSTR_TRAP = 0xff00ffff;
our $INSTR_VAR = 0x000403ee;

sub get_opcode_string
{
  my $opcode = shift;
  if ($opcode == 0x000003e4) { return "any"; }
  if ($opcode == 0x000403c0) { return "backcommit"; }
  if ($opcode == 0x00040382) { return "call"; }
  if ($opcode == 0x00040393) { return "catch"; }
  if ($opcode == 0x000403d7) { return "char"; }
  if ($opcode == 0x00040300) { return "closecapture"; }
  if ($opcode == 0x00040336) { return "commit"; }
  if ($opcode == 0x00080321) { return "condjump"; }
  if ($opcode == 0x00080356) { return "counter"; }
  if ($opcode == 0x000400d8) { return "end"; }
  if ($opcode == 0x00000399) { return "endreplace"; }
  if ($opcode == 0x0000034b) { return "fail"; }
  if ($opcode == 0x00000390) { return "failtwice"; }
  if ($opcode == 0x00040333) { return "jump"; }
  if ($opcode == 0x00080365) { return "maskedchar"; }
  if ($opcode == 0x00000000) { return "noop"; }
  if ($opcode == 0x0004039c) { return "opencapture"; }
  if ($opcode == 0x000403b4) { return "partialcommit"; }
  if ($opcode == 0x0004037e) { return "quad"; }
  if ($opcode == 0x000803bd) { return "range"; }
  if ($opcode == 0x00080348) { return "replace"; }
  if ($opcode == 0x000003a0) { return "ret"; }
  if ($opcode == 0x002003ca) { return "set"; }
  if ($opcode == 0x00040330) { return "skip"; }
  if ($opcode == 0x002003e1) { return "span"; }
  if ($opcode == 0x00040306) { return "testany"; }
  if ($opcode == 0x0008039a) { return "testchar"; }
  if ($opcode == 0x000803db) { return "testquad"; }
  if ($opcode == 0x00240363) { return "testset"; }
  if ($opcode == 0xff00ffff) { return "trap"; }
  if ($opcode == 0x000403ee) { return "var"; }
  return "Unknown opcode";
}
