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

#include <naigama/engine/naie.h>

/**
 * Runs the engine, instead of from the beginning, from a certain
 * symbol in the bytecode, against the input. Precondition is that
 * the labelmap must be loaded, so that the starting bytecode offset
 * can be resolved.
 */
NAIG_ERR_T naie_labelmap_get
  (
    naie_engine_t* engine,
    char* label,
    uint32_t* offset
  )
{
  unsigned i;

  for (i=0; i < engine->labelmap.size; i++) {
    if (0 == strcmp(label, engine->labelmap.entries[ i ].label)) {
      *offset = engine->labelmap.entries[ i ].offset;
      return NAIG_OK;
    }
  }
  return NAIG_ERR_NOTFOUND;
}
