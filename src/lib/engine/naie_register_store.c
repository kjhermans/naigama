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

#include "naie_private.h"

/**
 *
 */
NAIG_ERR_T naie_register_store
  (naie_engine_t* engine, uint32_t reg, uint32_t value)
{
  unsigned i;

  for (i=0; i < NAIG_MAX_REGISTER; i++) {
    if (engine->reg[ i ].value == 0 ||
          (engine->reg[ i ].reg == reg &&
           engine->reg[ i ].stacklen == engine->stack.size))
    {
      engine->reg[ i ].reg = reg;
      engine->reg[ i ].stacklen = engine->stack.size;
      engine->reg[ i ].value = value;
      return NAIG_OK;
    }
  }
  return NAIE_ERR_REGFULL;
}
