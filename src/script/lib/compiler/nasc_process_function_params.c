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

#include "nasc_private.h"

/**
 *
 */
NAIG_ERR_T nasc_process_function_params
  (
    nasc_t* nasc,
    naie_rescrs_t cursor,
    NAIG_ERR_T(*writer)(void*,char*,...),
    void* arg
  )
{
  naie_resact_t action;

  CATCHOUT(
    naie_result_cursor_child(&cursor, SLOT_IDENT_AZAZAZAZ, &action),
    NAIG_ERR_NOTFOUND
  );
  while (1) {
    CHECK(
      writer(arg, "  param %-.*s\n", action.length, nasc->code + action.start)
    );
    CATCHOUT(
      naie_result_cursor_next(&cursor, SLOT_IDENT_AZAZAZAZ, &action),
      NAIG_ERR_NOTFOUND
    );
  }
  return NAIG_OK;
}
