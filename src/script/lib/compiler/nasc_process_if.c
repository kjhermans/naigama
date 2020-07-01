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
  char label[ 512 ];

  snprintf(label, sizeof(label), "__if_%u", nasc->counter);
  CHECK(naie_result_cursor_child(&cursor, SLOT_ST_IF_EXPRESSION, &action));
  CHECK(writer(arg, "%s\n", label));
  ++(nasc->counter);
  CHECK(nasc_process_expression(nasc, cursor, writer, arg));
  CHECK(writer(arg, ""));
  while (1) {
    CATCHOUT(naie_result_cursor_next(&cursor, -1, &action), NAIG_ERR_NOTFOUND);
    switch (action.slot) {
    case SLOT_ST_IF_IFELSEIF:
      break;
    case SLOT_ST_IF_IFELSE:
      break;
    default:
      ;
    }
  }

  return NAIG_OK;
}
