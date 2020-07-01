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
NAIG_ERR_T nasc_process_function_body
  (
    nasc_t* nasc,
    naie_rescrs_t cursor,
    NAIG_ERR_T(*writer)(void*,char*,...),
    void* arg
  )
{
  naie_resact_t action;

  CATCHOUT(naie_result_cursor_child(&cursor, -1, &action), NAIG_ERR_NOTFOUND);
  while (1) {
    switch (action.slot) {
    case SLOT_LOWSTMT_STIF:
      CHECK(nasc_process_if(nasc, cursor, writer, arg));
      break;
    case SLOT_LOWSTMT_STWHILE:
fprintf(stderr, "WHILE\n");
      break;
    case SLOT_LOWSTMT_STRETURN:
      CHECK(nasc_process_return(nasc, cursor, writer, arg));
      break;
    case SLOT_LOWSTMT_STOTHER:
fprintf(stderr, "OTHER\n");
      break;
    case SLOT_LOWSTMT_VARDECL:
fprintf(stderr, "VARDECL\n");
      break;
    case SLOT_LOWSTMT_ASSIGNMENT:
fprintf(stderr, "ASSIGNMENT\n");
      break;
    case SLOT_EXPRESSION_EXPR:
fprintf(stderr, "EXPRESSION\n");
      break;
    default:
fprintf(stderr, "OTHER %u\n", action.slot);
    }
    CATCHOUT(naie_result_cursor_next(&cursor, -1, &action), NAIG_ERR_NOTFOUND);
  }
  return NAIG_OK;
}
