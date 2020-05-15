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
  (naic_t* naic, unsigned slot)
{
  naie_resact_t* a = &(naic->captures->actions[ naic->capindex ]);
  char l1[ 64 ];

#ifdef _DEBUG
  fprintf(stderr, "-- %s ", __FILE__); naic_debug(naic);
#endif

  snprintf(l1, sizeof(l1), "__REPL_JMP_OVER_%u", (naic->labelcount)++);
  CHECK(naic->write(naic->write_arg,
    "  replace %u %s\n"
    , slot
    , l1
  ));
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
  CHECK(naic->write(naic->write_arg,
    "  endreplace\n"
    "%s:\n"
    , l1
  ));
  return NAIG_OK;
}
