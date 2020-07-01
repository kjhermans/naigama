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
NAIG_ERR_T nasc_process_expression
  (
    nasc_t* nasc,
    naie_rescrs_t cursor,
    NAIG_ERR_T(*writer)(void*,char*,...),
    void* arg
  )
{
  naie_resact_t action;

  CATCHOUT(naie_result_cursor_child(&cursor, -1, &action), NAIG_ERR_NOTFOUND);
  if (action.slot == SLOT_EXPRESSION_EXPR) {
    CHECK(nasc_process_expr_level1(nasc, cursor, writer, arg));
  }

  return NAIG_OK;
}
