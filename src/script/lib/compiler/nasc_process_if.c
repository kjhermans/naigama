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
NAIG_ERR_T nasc_process_if
  (
    nasc_t* nasc,
    naie_rescrs_t cursor,
    NAIG_ERR_T(*writer)(void*,char*,...),
    void* arg
  )
{
  naie_resact_t action;

  CHECK(naie_result_cursor_child(&cursor, SLOT_ST_IF_EXPRESSION, &action));
fprintf(stderr, "EXPRESSION %u %u\n", cursor.scope_begin, cursor.scope_end);

  return NAIG_OK;
}
