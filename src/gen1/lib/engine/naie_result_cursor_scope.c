/**
 * This file is part of Naigama, a parser engine.
 * Copyright 2020, KJ Hermans
 * Written by KJ Hermans <kees.jan.hermans@gmail.com>
 *
 * LICENSE:
 * Withheld
 *
 * \file
 * \brief
 */

#include "naie_private.h"

/**
 *
 */
NAIG_ERR_T naie_result_cursor_scope
  (naie_result_t* result, unsigned start, unsigned scope, unsigned* end)
{
  unsigned i;

  if (start >= scope) {
    return NAIG_ERR_NOTFOUND;
  }
  *end = scope;
  for (i=start; i < scope; i++) {
    if (result->actions[ i ].start
          >= result->actions[ start ].start
            + result->actions[ start ].length)
    {
      *end = i;
      return NAIG_OK;
    }
  }
  return NAIG_OK;
}
