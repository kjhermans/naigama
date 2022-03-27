/**
 * This file is part of Raksaka / NAIG,
 * which is a network guard / message parser solution.
 * Copyright 2020, KJ Hermans
 * Written by KJ Hermans <kees.jan.hermans@gmail.com>
 *
 * LICENSE:
 * Withheld
 *
 * \file
 * \brief
 */

#include "../naic_private.h"
  
/**
 * Processes the hardcorded macroes %s %w %a %n %nl, which stand for
 * whitespace, alphabetic ('word'), alphanumeric, numeric and newline
 * character sets, and compiles them to 'set' instructions.
 */
NAIG_ERR_T naic_compile_macro
  (naic_t* naic, naio_resobj_t* macro)
{
  unsigned i;
  unsigned char set[ 32 ] = { 0 };
  char* chr = macro->string + 1;

  switch (macro->stringlen) {
  case 2:
    switch (*chr) {
    case 's':
      NAIC_SET_BIT_SET(set, '\n');
      NAIC_SET_BIT_SET(set, '\r');
      NAIC_SET_BIT_SET(set, '\t');
      NAIC_SET_BIT_SET(set, '\v');
      NAIC_SET_BIT_SET(set, ' ');
      break;
    case 'w':
      for (i = 'A'; i <= 'Z'; i++) { NAIC_SET_BIT_SET(set, i); }
      for (i = 'a'; i <= 'z'; i++) { NAIC_SET_BIT_SET(set, i); }
      break;
    case 'a':
      for (i = 'A'; i <= 'Z'; i++) { NAIC_SET_BIT_SET(set, i); }
      for (i = 'a'; i <= 'z'; i++) { NAIC_SET_BIT_SET(set, i); }
      for (i = '0'; i <= '9'; i++) { NAIC_SET_BIT_SET(set, i); }
      break;
    case 'n':
      NAIC_WRITE("  range %u %u\n", '0', '9');
      return NAIG_OK;
      //for (i = '0'; i <= '9'; i++) { NAIC_SET_BIT_SET(set, i); }
      //break;
    case 'r':
      NAIC_WRITE("  range 32 126\n");
      return NAIG_OK;
    default:
      snprintf(naic->error, sizeof(naic->error), "Unknown macro '%c'", *chr);
      RETURNERR(NAIG_ERR_MACRO);
    }
    break;
  case '3':
    if (chr[ 0 ] == 'n' && chr[ 1 ] == 'l') {
      NAIC_SET_BIT_SET(set, '\n');
      NAIC_SET_BIT_SET(set, '\r');
    } else {
      snprintf(naic->error, sizeof(naic->error),
        "Unknown macro '%c%c'", chr[0], chr[1]
      );
      RETURNERR(NAIG_ERR_MACRO);
    }
    break;
  default:
    snprintf(naic->error, sizeof(naic->error), "Macro length error.");
    RETURNERR(NAIG_ERR_MACRO);
  }
  NAIC_WRITE("  set ");
  for (i=0; i < sizeof(set); i++) {
    NAIC_WRITE("%.2x", set[ i ]);
  }
  NAIC_WRITE("\n");

  return NAIG_OK;
}
