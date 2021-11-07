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
 * Grammar:
 * 
 * EXPRESSION         <- { TERMS } OR NOTHING /
 *                       { TERMS } OR EXPRESSION /
 *                       { TERMS } /
 *                       CALL
 * 
 */
NAIG_ERR_T naic_process_expression
  (naic_t* naic)
{
#ifdef _DEBUG
  fprintf(stderr, "-- %s ", __FILE__); naic_debug(naic);
#endif

  switch (naic->captures->actions[ naic->capindex ].slot) {
  case SLOT_EXPRESSION_TERMS:
    CHECK(naic_process_terms_or_nothing(naic));
    break;
  case SLOT_EXPRESSION_TERMS_1:
    CHECK(naic_process_terms_or_expression(naic));
    break;
  case SLOT_EXPRESSION_TERMS_2:
    CHECK(naic_process_terms(naic));
    break;
  default:
    snprintf(naic->error, sizeof(naic->error),
      "Unexpected token type %u\n"
      , naic->captures->actions[ naic->capindex ].slot
    );
    RETURNERR(NAIC_ERR_TOKEN);
  }
  return NAIG_OK;
}
