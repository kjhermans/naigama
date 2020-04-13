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
NAIG_ERR_T naic_process_matcher
  (naic_t* naic)
{
#ifdef _DEBUG
  fprintf(stderr, "-- %s ", __FILE__); naic_debug(naic);
#endif

  switch (naic->captures->actions[ naic->capindex ].slot) {
  case SLOT_MATCHER_ANY:
    CHECK(naic_process_any(naic));
    break;
  case SLOT_MATCHER_SET:
    CHECK(naic_process_set(naic));
    break;
  case SLOT_MATCHER_STRING:
    CHECK(naic_process_string(naic));
    break;
  case SLOT_MATCHER_BITMASK:
    CHECK(naic_process_bitmask(naic));
    break;
  case SLOT_MATCHER_HEXLITERAL:
    CHECK(naic_process_hexliteral(naic));
    break;
  case SLOT_MATCHER_MACRO:
    CHECK(naic_process_macro(naic));
    break;
  case SLOT_MATCHER_VARREFERENCE:
    CHECK(naic_process_varreference(naic));
    break;
  case SLOT_MATCHER_REFERENCE:
    CHECK(naic_process_reference(naic));
    break;
  case SLOT_MATCHER_VARCAPTURE:
    CHECK(naic_process_varcapture(naic));
    break;
  case SLOT_MATCHER_CAPTURE:
    CHECK(naic_process_capture(naic));
    break;
  case SLOT_MATCHER_GROUP:
    CHECK(naic_process_group(naic));
    break;
  default:
    RETURNERR(NAIC_ERR_TOKEN);
  }
  return NAIG_OK;
}
