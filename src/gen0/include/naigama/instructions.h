#ifndef _INSTRUCTIONS_H_
#define _INSTRUCTIONS_H_

#define OPCODE_ANY 0x000003e4
#define OPCODE_BACKCOMMIT 0x000403c0
#define OPCODE_CALL 0x00040382
#define OPCODE_CATCH 0x00040393
#define OPCODE_CHAR 0x000403d7
#define OPCODE_CLOSECAPTURE 0x00040300
#define OPCODE_COMMIT 0x00040336
#define OPCODE_CONDJUMP 0x00080321
#define OPCODE_COUNTER 0x00080356
#define OPCODE_END 0x000400d8
#define OPCODE_ENDREPLACE 0x00000399
#define OPCODE_FAIL 0x0000034b
#define OPCODE_FAILTWICE 0x00000390
#define OPCODE_JUMP 0x00040333
#define OPCODE_MASKEDCHAR 0x00080365
#define OPCODE_NOOP 0x00000000
#define OPCODE_OPENCAPTURE 0x0004039c
#define OPCODE_PARTIALCOMMIT 0x000403b4
#define OPCODE_QUAD 0x0004037e
#define OPCODE_RANGE 0x000803bd
#define OPCODE_REPLACE 0x00080348
#define OPCODE_RET 0x000003a0
#define OPCODE_SET 0x002003ca
#define OPCODE_SKIP 0x00040330
#define OPCODE_SPAN 0x002003e1
#define OPCODE_TESTANY 0x00040306
#define OPCODE_TESTCHAR 0x0008039a
#define OPCODE_TESTQUAD 0x000803db
#define OPCODE_TESTSET 0x00240363
#define OPCODE_TRAP 0xff00ffff
#define OPCODE_VAR 0x000403ee

#define INSTRCASES \
  case OPCODE_ANY: return "ANY";\
  case OPCODE_BACKCOMMIT: return "BACKCOMMIT";\
  case OPCODE_CALL: return "CALL";\
  case OPCODE_CATCH: return "CATCH";\
  case OPCODE_CHAR: return "CHAR";\
  case OPCODE_CLOSECAPTURE: return "CLOSECAPTURE";\
  case OPCODE_COMMIT: return "COMMIT";\
  case OPCODE_CONDJUMP: return "CONDJUMP";\
  case OPCODE_COUNTER: return "COUNTER";\
  case OPCODE_END: return "END";\
  case OPCODE_ENDREPLACE: return "ENDREPLACE";\
  case OPCODE_FAIL: return "FAIL";\
  case OPCODE_FAILTWICE: return "FAILTWICE";\
  case OPCODE_JUMP: return "JUMP";\
  case OPCODE_MASKEDCHAR: return "MASKEDCHAR";\
  case OPCODE_NOOP: return "NOOP";\
  case OPCODE_OPENCAPTURE: return "OPENCAPTURE";\
  case OPCODE_PARTIALCOMMIT: return "PARTIALCOMMIT";\
  case OPCODE_QUAD: return "QUAD";\
  case OPCODE_RANGE: return "RANGE";\
  case OPCODE_REPLACE: return "REPLACE";\
  case OPCODE_RET: return "RET";\
  case OPCODE_SET: return "SET";\
  case OPCODE_SKIP: return "SKIP";\
  case OPCODE_SPAN: return "SPAN";\
  case OPCODE_TESTANY: return "TESTANY";\
  case OPCODE_TESTCHAR: return "TESTCHAR";\
  case OPCODE_TESTQUAD: return "TESTQUAD";\
  case OPCODE_TESTSET: return "TESTSET";\
  case OPCODE_TRAP: return "TRAP";\
  case OPCODE_VAR: return "VAR";\
  default: return "Unknown opcode";

#endif
