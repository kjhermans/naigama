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
 *
 */
NAIG_ERR_T naic_process_rule
  (naic_t* naic)
{
  naie_resact_t* a = &(naic->captures->actions[ naic->capindex ]);
  char* chr = naic->grammar + a->start;
  unsigned i, end = a->stop;

#ifdef _DEBUG
  fprintf(stderr, "-- %s ", __FILE__); naic_debug(naic);
#endif

  naic->rulevarmap.size = 0;
  naic->currentrule = a;
  fprintf(naic->output, "-- Rule\n");
  if (naic->flags & NAIC_FLG_TRAPS) {
    fprintf(naic->output, "  trap\n");
  }
  fprintf(naic->output, "%-.*s:\n" , (int)(a->stop - a->start), chr);
  if (naic->flags & NAIC_FLG_IMPLICITPREFIX) {
    fprintf(naic->output, "  call __prefix\n");
  }
  ++(naic->capindex);
  CHECK(naic_process_expression(naic));
  fprintf(naic->output, "  ret\n");
  if (naic->flags & NAIC_FLG_TRAPS) {
    fprintf(naic->output, "  trap\n");
  }

  for (i = naic->capindex; i < naic->captures->size; i++) {
    if (naic->captures->actions[ i ].start >= end) {
      break;
    }
  }
  naic->capindex = i;
  return NAIG_OK;
}
