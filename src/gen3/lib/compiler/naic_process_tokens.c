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

#include "naic_private.h"

/**
 * Topmost function
 */
NAIG_ERR_T naic_process_tokens
  (naic_t* naic)
{
#ifdef _DEBUG
  unsigned i; for (i=0; i < naic->captures->count; i++) {
    naic->capindex = i;
    naic_debug(naic);
  }
  naic->capindex = 0;
#endif

  while (naic->capindex < naic->captures->count) {
#ifdef _DEBUG
    fprintf(stderr, "-- %s ", __FILE__); naic_debug(naic);
#endif
    switch (naic->captures->actions[ naic->capindex ].slot) {
    case SLOT_RULE_IDENT:
      if (0 == (naic->flags & NAIC_FLG_FIRSTRULE)) {
        naic->write(naic->write_arg,
          "  call %-.*s\n"
          "  end\n"
          , naic->captures->actions[ naic->capindex ].length
          , naic->grammar + naic->captures->actions[ naic->capindex ].start
        );
        naic->flags |= NAIC_FLG_FIRSTRULE;
      }
      if (0 == cmp_substr(
             naic->grammar + naic->captures->actions[ naic->capindex ].start,
             naic->captures->actions[ naic->capindex ].length,
             "__prefix"))
      {
        CHECK(naic_process_rule(naic));
        naic->flags |= NAIC_FLG_IMPLICITPREFIX;
      } else {
        CHECK(naic_process_rule(naic));
      }
      break;
    case SLOT_FUNCDECL_IDENT:
      CHECK(naic_process_function(naic));
      break;
    default:
      CHECK(naic_process_expression(naic));
      break;
    }
  }
  naic->write(naic->write_arg, "\n  end 0\n");
  return NAIG_OK;
}
