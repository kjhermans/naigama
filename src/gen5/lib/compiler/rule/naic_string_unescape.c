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
 *
 */
NAIG_ERR_T naic_string_unescape
  (
    naic_t* naic,
    unsigned start,
    unsigned stop,
    NAIG_ERR_T(*fnc)(naic_t*,unsigned,int)
  )
{
  unsigned i, c;

  for (i = start; i < stop; i++) {
    switch (c = naic->grammar[ i ]) {
    case '\\':
      switch (c = naic->grammar[ ++i ]) {
      case 'n': CHECK(fnc(naic, '\n', (i==stop-1))); break;
      case 'r': CHECK(fnc(naic, '\r', (i==stop-1))); break;
      case 't': CHECK(fnc(naic, '\t', (i==stop-1))); break;
      case 'v': CHECK(fnc(naic, '\v', (i==stop-1))); break;
      case '\\': CHECK(fnc(naic, '\\', (i==stop-1))); break;
      case '\'': CHECK(fnc(naic, '\'', (i==stop-1))); break;
      case '0': case '1': case '2': case '3': case '4': case '5': case '6':
      case '7': case '8': case '9': case 'a': case 'b': case 'c': case 'd':
      case 'e': case 'f': case 'A': case 'B': case 'C': case 'D': case 'E':
      case 'F':
        CHECK(fnc(naic, hexcodon(c, naic->grammar[ i+1 ]), (i==stop-2)));
        ++i;
      }
      break;
    default:
      CHECK(fnc(naic, c, (i==stop-1)));
    }
  }
  return NAIG_OK;
}
