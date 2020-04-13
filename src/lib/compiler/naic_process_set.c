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

static
unsigned naic_set_char
  (char* chr)
{
  switch (*chr) {
  case '\\':
    ++chr;
    switch (*chr) {
    case 'n':
      return (unsigned)'\n';
    case 'r':
      return (unsigned)'\r';
    case 't':
      return (unsigned)'\t';
    case 'v':
      return (unsigned)'\v';
    case '\\':
      return (unsigned)'\\';
    case ']':
      return (unsigned)']';
    case '0': case '1': case '2': case '3': case '4': case '5': case '6':
    case '7': case '8': case '9': case 'a': case 'b': case 'c': case 'd':
    case 'e': case 'f': case 'A': case 'B': case 'C': case 'D': case 'E':
    case 'F':
      return hexcodon(chr[0], chr[1]);
    }
  default:
    return (unsigned)(*chr);
  }
}
  
/**
 *
 */
NAIG_ERR_T naic_process_set
  (naic_t* naic)
{
  naie_resact_t* a = &(naic->captures->actions[ naic->capindex ]);
  unsigned end = a->stop;
  int invert = 0;
  unsigned char set[ 32 ] = { 0 };
  unsigned chr1, chr2;

#ifdef _DEBUG
  fprintf(stderr, "-- %s ", __FILE__); naic_debug(naic);
#endif

  ++a;
  if (a->slot == SLOT_SET_SETNOT) {
    invert = (a->start != a->stop);
    ++a;
  } else {
    abort();
  }
  while (a->stop <= end) {
    switch (a->slot) {
    case SLOT_SET_NRTV:
      chr1 = naic_set_char(naic->grammar + a->start);
      ++a;
      chr2 = naic_set_char(naic->grammar + a->start);
      for (; chr1 <= chr2; chr1++) {
        NAIC_SET_BIT_SET(set, chr1);
      }
      break;
    case SLOT_SET_NRTV_2:
      chr1 = naic_set_char(naic->grammar + a->start);
      NAIC_SET_BIT_SET(set, chr1);
      break;
    }
    ++a;
  }
  if (invert) {
    for (chr1=0; chr1 < sizeof(set); chr1++) {
      set[ chr1 ] = ~set[ chr1 ];
    }
  }
  fprintf(naic->output, "  set ");
  for (chr1=0; chr1 < sizeof(set); chr1++) {
    fprintf(naic->output, "%.2x", set[ chr1 ]);
  }
  fprintf(naic->output, "\n");

  return NAIG_OK;
}
