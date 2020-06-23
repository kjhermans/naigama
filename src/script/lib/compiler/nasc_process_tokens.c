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
NAIG_ERR_T nasc_process_tokens
  (nasc_t* nasc, NAIG_ERR_T(*writer)(void*,char*,...), void* arg)
{
  CHECK(nasc_process_imports(nasc, writer, arg));
  CHECK(nasc_process_functions(nasc, writer, arg));
  return NAIG_OK;
}
