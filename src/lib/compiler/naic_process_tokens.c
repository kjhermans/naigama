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
#include <naigama/compiler/naic.h>

/**
 * Topmost function
 */
NAIG_ERR_T naic_process_tokens
  (
    char* grammar,
    naie_result_t* captures,
    FILE* output,
    naic_slotmap_t* slots,
    int traps
  )
{
  naic_t naic = {
    .grammar     = grammar,
    .captures    = captures,
    .capindex    = 0,
    .output      = output,
    .slotmap     = slots,
    .labelcount  = 0
  };

#ifdef _DEBUG
  unsigned i; for (i=0; i < captures->size; i++) {
    naic.capindex = i;
    naic_debug(&naic);
  }
  naic.capindex = 0;
#endif
  if (traps) {
    naic.flags |= NAIC_FLG_TRAPS;
  }

  while (naic.capindex < captures->size) {
#ifdef _DEBUG
    fprintf(stderr, "-- %s ", __FILE__); naic_debug(&naic);
#endif
    switch (captures->actions[ naic.capindex ].slot) {
    case SLOT_RULE_IDENT:
      if (0 == (naic.flags & NAIC_FLG_FIRSTRULE)) {
        fprintf(output,
          "  call %-.*s\n"
          "  end\n"
          , (int)(captures->actions[ naic.capindex ].stop
                  - captures->actions[ naic.capindex ].start)
          , grammar + captures->actions[ naic.capindex ].start
        );
        naic.flags |= NAIC_FLG_FIRSTRULE;
      }
      if (0 == cmp_substr(
                 grammar + captures->actions[ naic.capindex ].start,
                 captures->actions[ naic.capindex ].stop
                   - captures->actions[ naic.capindex ].start,
                 "__prefix"))
      {
        CHECK(naic_process_rule(&naic));
        naic.flags |= NAIC_FLG_IMPLICITPREFIX;
      } else {
        CHECK(naic_process_rule(&naic));
      }
      break;
    default:
      CHECK(naic_process_expression(&naic));
      break;
    }
  }
  fprintf(output, "\n  end 0\n");
  return NAIG_OK;
}
