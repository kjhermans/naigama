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
NAIG_ERR_T nasc_process_function
  (
    nasc_t* nasc,
    naie_rescrs_t cursor,
    NAIG_ERR_T(*writer)(void*,char*,...),
    void* arg
  )
{
  naie_resact_t action;

  CHECK(naie_result_cursor_child(&cursor, SLOT_IDENT_AZAZAZAZ, &action));
  CHECK(writer(arg, "func_%-.*s:\n", action.length, nasc->code + action.start));
  CHECK(
    naie_result_cursor_next(
      &cursor,
      SLOT_FUNCPARAMDECL_IDENTCOMMAIDENT,
      &action
    )
  );
  CHECK(nasc_process_function_params(nasc, cursor, writer, arg));
  CHECK(naie_result_cursor_next(&cursor, SLOT_FUNCBODY_LOWSTMT, &action));
  CHECK(nasc_process_function_body(nasc, cursor, writer, arg));
  CHECK(writer(arg, "  push 0\n  ret\n"));
  return NAIG_OK;
}
