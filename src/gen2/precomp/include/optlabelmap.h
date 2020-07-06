#define OPTLABELMAP_SWITCH \
  if (0 == strcmp("CHAR2QUAD", label)) { return 16; } \
  else \
  if (0 == strcmp("__REPL_JMP_OVER_120", label)) { return 280; } \
  else \
  if (0 == strcmp("HEXBYTE", label)) { return 284; } \
  else \
  if (0 == strcmp("__TERM_123", label)) { return 296; } \
  else \
  if (0 == strcmp("S", label)) { return 348; } \
  else \
  if (0 == strcmp("__TERM_130", label)) { return 392; } \
  else \
  if (0 == strcmp("__TERM_131", label)) { return 436; } \
  else \
  return 0;

#define OPTLABEL_CHAR2QUAD 16
#define OPTLABEL__REPL_JMP_OVER_120 280
#define OPTLABEL_HEXBYTE 284
#define OPTLABEL__TERM_123 296
#define OPTLABEL_S 348
#define OPTLABEL__TERM_130 392
#define OPTLABEL__TERM_131 436
