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
NAIG_ERR_T nasc_process_expr_level1
  (
    nasc_t* nasc,
    naie_rescrs_t cursor,
    NAIG_ERR_T(*writer)(void*,char*,...),
    void* arg
  )
{
  naie_resact_t action;

  return NAIG_OK;
}
