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

#include <naigama/util/hexcodon.h>

#include "naic_private.h"

/**
 *
 * No Unicode support, but all the other escapes.
 *
 * \a         → BEL @ U+0007 (“alert”—beeps, dings, flashes)
 * \b         → BS  @ U+0008 (moves cursor ← 1)
 * \t         → HT  @ U+0009 (advance to next horiz tab stop, not nec. every 8)
 * \n         → LF  @ U+000A (newline, or bump cursor ↓ 1)
 * \v         → VT  @ U+000B (bump ↓ to next vert tab stop)
 * \f         → FF  @ U+000C (adv to next page; wipe screen)
 * \r         → CR  @ U+000D (move to start of line)
 * \e         → ESC @ U+001B (GNU dialect only)
 * \"         → "   @ U+0022 (avoids ending string lit)
 * \'         → '   @ U+0027 (avoid ending char lit)
 * \?         → ?   @ U+003F (to avoid trigraphization)
 * \\         → \   @ U+005C (avoid escape)
 * \CCC…      → octal char code (eats digits C=[0–7]; C23 will cap @ 3)
 * \xXX…      → hex char code (eats digits X=[0–9A–Fa–f]; no cap)
 *
 */
NAIG_ERR_T naic_string_unescape
  (
    naic_t* naic,
    naic_nsp_t* nsp,
    naic_rule_t* rule,
    char* string,
    NAIG_ERR_T(*fnc)(naic_t*,naic_nsp_t*,naic_rule_t*,unsigned,int)
  )
{
  unsigned char c;
  int last;

  while ((c = *string) != 0) {
    switch (c) {
    case '\\':
      ++string;
      if ((c = *string) == 0) {
        RETURNERR(NAIG_ERR_ESCAPE);
      } else {
        last = (string[ 1 ] == 0);
      }
      switch (c) {
      case 'n': NAIG_CHECK(fnc(naic, nsp, rule, '\n', last), PROPAGATE); break;
      case 'r': NAIG_CHECK(fnc(naic, nsp, rule, '\r', last), PROPAGATE); break;
      case 't': NAIG_CHECK(fnc(naic, nsp, rule, '\t', last), PROPAGATE); break;
      case 'v': NAIG_CHECK(fnc(naic, nsp, rule, '\v', last), PROPAGATE); break;
      case '\\': NAIG_CHECK(fnc(naic, nsp, rule, '\\', last), PROPAGATE); break;
      case '\'': NAIG_CHECK(fnc(naic, nsp, rule, '\'', last), PROPAGATE); break;
      case '0': case '1': case '2': case '3': case '4': case '5': case '6':
      case '7': case '8': case '9': case 'a': case 'b': case 'c': case 'd':
      case 'e': case 'f': case 'A': case 'B': case 'C': case 'D': case 'E':
      case 'F':
        if (string[ 1 ] == 0) {
          RETURNERR(NAIG_ERR_ESCAPE);
        }
        NAIG_CHECK(fnc(naic, nsp, rule, hexcodon(c, string[ 1 ]), (string[ 2 ] == 0)), PROPAGATE);
        ++string;
      }
      break;
    default:
      NAIG_CHECK(fnc(naic, nsp, rule, c, (string[ 1 ] == 0)), PROPAGATE);
    }
    ++string;
  }
  return NAIG_OK;
}
