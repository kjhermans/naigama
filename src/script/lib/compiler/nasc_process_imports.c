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
NAIG_ERR_T nasc_process_imports
  (nasc_t* nasc, NAIG_ERR_T(*writer)(void*,char*,...), void* arg)
{
  NAIG_ERR_T e;
  naie_resact_t action;
  naie_rescrs_t cursor;

  CHECK(naie_result_cursor(nasc->captures, &cursor));
  while (1) {
    e = naie_result_cursor_next(&cursor, SLOT_TOPSTMT_IMPORTSTMT, &action);
    switch (e.code) {
    case NAIG_ERRCODE_NOTFOUND:
      return NAIG_OK;
    case 0:
      CHECK(nasc_process_import(nasc, &cursor, writer, arg));
      break;
    default:
      return e;
    }
  }
  return NAIG_OK;
}
