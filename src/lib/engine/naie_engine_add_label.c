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

NAIG_ERR_T naie_engine_add_label
  (naie_engine_t* engine, char* string, uint32_t offset)
{
  if (engine->labelmap.size < NAIG_MAX_LABELMAP) {
    snprintf(
      engine->labelmap.entries[ engine->labelmap.size ].label,
      NAIG_MAX_LABEL,
      "%s",
      string
    );
    engine->labelmap.entries[ engine->labelmap.size ].offset = offset;
    ++(engine->labelmap.size);
#ifdef _DEBUG
    fprintf(stderr, "Adding label '%s' -> %u\n", string, offset);
#endif
    return NAIG_OK;
  }
  return NAIE_ERR_LABELMAP;
}
