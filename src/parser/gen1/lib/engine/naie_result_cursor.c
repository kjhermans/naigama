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

#include "naie_private.h"

/**
 *
 */
NAIG_ERR_T naie_result_cursor
  (
    naie_result_t* result,
    naie_rescrs_t* cursor
  )
{
  memset(cursor, 0, sizeof(*cursor));
  cursor->result = result;
  cursor->parent_scope_begin = 0;
  cursor->parent_scope_end = cursor->result->size;
  cursor->scope_begin = 0;
  cursor->scope_end = 0;
//  CHECK(naie_result_cursor_scope(cursor->result, 0, &(cursor->scope_end)));
  return NAIG_OK;
}
