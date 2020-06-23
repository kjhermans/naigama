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
NAIG_ERR_T nasc_process_import
  (
    nasc_t* nasc,
    naie_rescrs_t* cursor,
    NAIG_ERR_T(*writer)(void*,char*,...),
    void* arg
  )
{
  naie_resact_t action;

  CHECK(naie_result_cursor_child(cursor, SLOT_IMPORTSTMT_STRINGLITERAL, &action));
  CHECK(writer(arg, "  import %-.*s\n", action.length - 2 , nasc->code + action.start + 1));
  //..
  return NAIG_OK;
}
