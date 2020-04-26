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
  unsigned i, end = a->start + a->length;

#ifdef _DEBUG
  fprintf(stderr, "-- %s ", __FILE__); naic_debug(naic);
#endif

  naic->rulevarmap.size = 0;
  naic->currentrule = a;
  CHECK(naic->write(naic->write_arg, "-- Rule\n"));
  if (naic->flags & NAIC_FLG_TRAPS) {
    CHECK(naic->write(naic->write_arg, "  trap\n"));
  }
  CHECK(naic->write(naic->write_arg, "%-.*s:\n" , a->length, chr));
  if (naic->flags & NAIC_FLG_IMPLICITPREFIX) {
    CHECK(naic->write(naic->write_arg, "  call __prefix\n"));
  }
  ++(naic->capindex);
  CHECK(naic_process_expression(naic));
  CHECK(naic->write(naic->write_arg, "  ret\n"));
  if (naic->flags & NAIC_FLG_TRAPS) {
    CHECK(naic->write(naic->write_arg, "  trap\n"));
  }

  for (i = naic->capindex; i < naic->captures->size; i++) {
    if (naic->captures->actions[ i ].start >= end) {
      break;
    }
  }
  naic->capindex = i;
  return NAIG_OK;
}
