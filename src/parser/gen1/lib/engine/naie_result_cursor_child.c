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
NAIG_ERR_T naie_result_cursor_child
  (
    naie_rescrs_t* cursor,
    int slot,
    naie_resact_t* action
  )
{
  if (cursor->scope_begin == cursor->scope_end) {
    return NAIG_ERR_NOTFOUND;
  }
  if (cursor->scope_begin + 1 >= cursor->parent_scope_end) {
    return NAIG_ERR_NOTFOUND;
  }
  cursor->parent_scope_begin = cursor->scope_begin;
  cursor->parent_scope_end = cursor->scope_end;
  ++(cursor->scope_begin);
  CHECK(
    naie_result_cursor_scope(
      cursor->result,
      cursor->scope_begin,
      cursor->parent_scope_end,
      &(cursor->scope_end)
    )
  );
  if (slot < 0) {
    *action = cursor->result->actions[ cursor->scope_begin ];
    return NAIG_OK;
  } else if ((unsigned)slot
             == cursor->result->actions[ cursor->scope_begin ].slot)
  {
    *action = cursor->result->actions[ cursor->scope_begin ];
    return NAIG_OK;
  } else {
    CHECK(naie_result_cursor_next(cursor, slot, action));
    return NAIG_OK;
  }
}
