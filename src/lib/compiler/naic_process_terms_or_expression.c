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
 * Pattern is:
 *
 *   catch L1
 *   <terms>
 *   commit L2
 * L1:
 *   <expression>
 * L2:
 *   
 */
NAIG_ERR_T naic_process_terms_or_expression
  (naic_t* naic)
{
  char l1[ 64 ];
  char l2[ 64 ];

#ifdef _DEBUG
  fprintf(stderr, "-- %s ", __FILE__); naic_debug(naic);
#endif

  snprintf(l1, sizeof(l1), "__RIGHTHAND_%u", (naic->labelcount)++);
  snprintf(l2, sizeof(l2), "__LEFTHAND_%u", (naic->labelcount)++);
  CHECK(naic->write(naic->write_arg,
    "  catch %s\n"
    , l1
  ));
  CHECK(naic_process_terms(naic));
  CHECK(naic->write(naic->write_arg,
    "  commit %s\n"
    "%s:\n"
    , l2
    , l1
  ));
  CHECK(naic_process_expression(naic));
  CHECK(naic->write(naic->write_arg,
    "%s:\n"
    , l2
  ));
  return NAIG_OK;
}
