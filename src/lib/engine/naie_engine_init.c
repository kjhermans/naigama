/**
 * This file is part of NAIG.
 * Copyright 2019, KJ Hermans
 * Written by KJ Hermans <kees.jan.hermans@gmail.com>
 *
 * LICENSE:
 * Withheld
 *
 * \file
 * \brief
 */

#include <naigama/engine/naie.h>

NAIG_ERR_T naie_engine_init
  (naie_engine_t* engine)
{
  memset(engine, 0, sizeof(naie_engine_t));
  return NAIG_OK;
}
