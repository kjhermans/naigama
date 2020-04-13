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
 * Pattern is:
 * 
 *   catch L1
 *   <terms>
 *   commit L1
 * L1:
 */
NAIG_ERR_T naic_process_terms_or_nothing
  (naic_t* naic)
{
  char l1[ 64 ];

#ifdef _DEBUG
  fprintf(stderr, "-- %s ", __FILE__); naic_debug(naic);
#endif

  snprintf(l1, sizeof(l1), "__LABEL_%u", (naic->labelcount)++);
  fprintf(naic->output,
    "  catch %s -- terms or nothing\n"
    , l1
  );
  CHECK(naic_process_terms(naic));
  fprintf(naic->output,
    "  commit %s\n"
    "%s:\n"
    , l1
    , l1
  );
  return NAIG_OK;
}
