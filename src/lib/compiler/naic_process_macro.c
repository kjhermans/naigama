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

#include <naigama/compiler/naic.h>
  
/**
 * Processes the hardcorded macroes %s %w %a %n %nl, which stand for
 * whitespace, alphabetic ('word'), alphanumeric, numeric and newline
 * character sets, and compiles them to 'set' instructions.
 */
NAIG_ERR_T naic_process_macro
  (naic_t* naic)
{
  naie_resact_t* a = &(naic->captures->actions[ naic->capindex ]);
  char* chr = naic->grammar + a->start + 1;
  unsigned i;
  unsigned char set[ 32 ] = { 0 };

#ifdef _DEBUG
  fprintf(stderr, "-- %s ", __FILE__); naic_debug(naic);
#endif

  switch (a->length) {
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
      for (i = '0'; i <= '9'; i++) { NAIC_SET_BIT_SET(set, i); }
      break;
    default:
      RETURNERR(NAIC_ERR_MACRO);
    }
    break;
  case '3':
    if (chr[ 0 ] == 'n' && chr[ 1 ] == 'l') {
      NAIC_SET_BIT_SET(set, '\n');
      NAIC_SET_BIT_SET(set, '\r');
    } else {
      RETURNERR(NAIC_ERR_MACRO);
    }
    break;
  default:
    RETURNERR(NAIC_ERR_MACRO);
  }
  CHECK(naic->write(naic->write_arg, "  set "));
  for (i=0; i < sizeof(set); i++) {
    CHECK(naic->write(naic->write_arg, "%.2x", set[ i ]));
  }
  CHECK(naic->write(naic->write_arg, "\n"));

  return NAIG_OK;
}
