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
 * Allows you to query the action list for captures along a path of
 * slot numbers.
 */
NAIG_ERR_T naie_result_query
  (
    naie_result_t* result,
    unsigned* path,
    unsigned path_length,
    naie_resact_t* action
  )
{
  CHECK(
    naie_result_query_scope(
      result,
      0,
      result->size,
      path,
      path_length,
      0,
      action
    )
  );
  return NAIG_OK;
}
