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
