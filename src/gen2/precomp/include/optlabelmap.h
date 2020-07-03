#define OPTLABELMAP_SWITCH \
  if (0 == strcmp("CHAR2QUAD", label)) { return 16; } \
  else \
  if (0 == strcmp("__REPL_JMP_OVER_120", label)) { return 300; } \
  else \
  if (0 == strcmp("HEXBYTE", label)) { return 304; } \
  else \
  if (0 == strcmp("__TERM_123", label)) { return 316; } \
  else \
  if (0 == strcmp("S", label)) { return 368; } \
  else \
  if (0 == strcmp("__TERM_130", label)) { return 412; } \
  else \
  if (0 == strcmp("__TERM_131", label)) { return 456; } \
  else \
  return 0;

#define OPTLABEL_CHAR2QUAD 16
#define OPTLABEL__REPL_JMP_OVER_120 300
#define OPTLABEL_HEXBYTE 304
#define OPTLABEL__TERM_123 316
#define OPTLABEL_S 368
#define OPTLABEL__TERM_130 412
#define OPTLABEL__TERM_131 456
