#define OPTLABELMAP_SWITCH \
  if (0 == strcmp("CHAR2QUAD", label)) { return 16; } \
  else \
  if (0 == strcmp("__LABEL_120", label)) { return 344; } \
  else \
  if (0 == strcmp("__LABEL_121", label)) { return 424; } \
  else \
  if (0 == strcmp("HEXBYTE", label)) { return 428; } \
  else \
  if (0 == strcmp("__LABEL_124", label)) { return 440; } \
  else \
  if (0 == strcmp("S", label)) { return 492; } \
  else \
  if (0 == strcmp("__LABEL_131", label)) { return 536; } \
  else \
  if (0 == strcmp("__LABEL_132", label)) { return 580; } \
  else \
  return 0;

#define OPTLABEL_CHAR2QUAD 16
#define OPTLABEL__LABEL_120 344
#define OPTLABEL__LABEL_121 424
#define OPTLABEL_HEXBYTE 428
#define OPTLABEL__LABEL_124 440
#define OPTLABEL_S 492
#define OPTLABEL__LABEL_131 536
#define OPTLABEL__LABEL_132 580
