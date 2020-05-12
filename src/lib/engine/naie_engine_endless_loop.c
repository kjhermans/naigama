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
 *
 */
NAIG_ERR_T naie_engine_endless_loop
  (naie_engine_t* engine)
{
  unsigned i;

  if (engine->flags & NAIE_FLAG_ENDLESS) {
    for (i=0; i < engine->loopdetect.size; i++) {
fprintf(stderr, "Comparing %u %u %u %u\n", engine->loopdetect.entries[ i ].bytecode_pos, engine->bytecode_pos, engine->loopdetect.entries[ i ].bytecode_pos, engine->input_pos);

      if (engine->loopdetect.entries[ i ].bytecode_pos == engine->bytecode_pos
          && engine->loopdetect.entries[ i ].bytecode_pos == engine->input_pos)
      {
        RETURNERR(NAIE_ERR_ENDLESSLOOP);
      }
    }
    if (engine->loopdetect.size == NAIE_MAX_LOOPDETECT) {
      memmove(
        &(engine->loopdetect.entries[ 1 ]),
        &(engine->loopdetect.entries[ 0 ]),
        (sizeof(engine->loopdetect.entries[ 0 ]) * (NAIE_MAX_LOOPDETECT-1))
      );
    } else {
      if (engine->loopdetect.size) {
        memmove(
          &(engine->loopdetect.entries[ 1 ]),
          &(engine->loopdetect.entries[ 0 ]),
          (sizeof(engine->loopdetect.entries[ 0 ]) * engine->loopdetect.size)
        );
      }
      ++(engine->loopdetect.size);
    }
    engine->loopdetect.entries[ 0 ].bytecode_pos = engine->bytecode_pos;
    engine->loopdetect.entries[ 0 ].input_pos = engine->input_pos;
  }
  return NAIG_OK;
}
