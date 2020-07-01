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
NAIG_ERR_T naie_result_query_scope
  (
    naie_result_t* result,
    unsigned result_index,
    unsigned result_scope,
    unsigned* path,
    unsigned path_length,
    unsigned path_index,
    naie_resact_t* action
  )
{
  unsigned occurence_index, current_scope, i;

  if (path_index > path_length - 2) {
    return NAIG_ERR_NOTFOUND;
  }
  occurence_index = path[ path_index + 1 ];
  while (result_index < result_scope) {
    current_scope = result_index + 1;
    for (i = result_index + 1; i < result_scope; i++) {
      current_scope = i;
      if (result->actions[ i ].start >=
          result->actions[ result_index ].start
          + result->actions[ result_index ].length)
      {
        break;
      }
    }
    if (result->actions[ result_index ].slot == path[ path_index ]) {
      if (occurence_index == 0) {
        if (path_index == path_length - 2) {
          *action = result->actions[ result_index ];
          return NAIG_OK;
        } else {
          return naie_result_query_scope(
            result,
            result_index + 1,
            current_scope,
            path,
            path_length,
            path_index + 2,
            action
          );
        }
      } else {
        --occurence_index;
      }
    }
    result_index = current_scope;
  }
  return NAIG_ERR_NOTFOUND;
}
