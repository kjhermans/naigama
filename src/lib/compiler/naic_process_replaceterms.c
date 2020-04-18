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

#include <naigama/compiler/naic.h>

/**
 *
 */
NAIG_ERR_T naic_process_replaceterms
  (naic_t* naic)
{
  naie_resact_t* a = &(naic->captures->actions[ naic->capindex ]);
  char l1[ 64 ];
  char l2[ 64 ];

#ifdef _DEBUG
  fprintf(stderr, "-- %s ", __FILE__); naic_debug(naic);
#endif

  snprintf(l1, sizeof(l1), "__LABEL_%u", (naic->labelcount)++);
  snprintf(l2, sizeof(l2), "__LABEL_%u", (naic->labelcount)++);
  fprintf(naic->output,
    "  replace %s %s\n"
    "%s:\n"
    "  startreplace\n"
    , l1
    , l2
    , l1
  );
  ++(naic->capindex);
  ++a;
  while (1) {
    if (a->slot == SLOT_REPLACETERM_STRINGLITERAL) {
      CHECK(naic_process_string(naic));
    } else if (a->slot == SLOT_REPLACETERM_VARREFERENCE) {
      CHECK(naic_process_varreference(naic));
      ++(naic->capindex);
      ++a;
    } else {
      break;
    }
    ++(naic->capindex);
    ++a;
  }
  fprintf(naic->output,
    "  endreplace\n"
    "%s:\n"
    , l2
  );
  return NAIG_OK;
}
