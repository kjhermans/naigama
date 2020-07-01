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

void naie_result_debug
  (naie_result_t* result, unsigned char* data)
{
  unsigned i;

  fprintf(stderr, "End code: %d\n", result->code);
  fprintf(stderr, "%u actions total\n", result->size);
  for (i=0; i < result->size; i++) {
    switch (result->actions[ i ].action) {
    case NAIG_ACTION_OPENCAPTURE:
      fprintf(stderr, "Action #%u: capture slot %u, %u->%u '%-.*s'\n"
        , i
        , result->actions[ i ].slot
        , result->actions[ i ].start
        , result->actions[ i ].length
        , result->actions[ i ].length
        , data + result->actions[ i ].start
      );
      break;
    case NAIG_ACTION_CLOSECAPTURE:
      break;
    case NAIG_ACTION_DELETE:
      fprintf(stderr, "Action #%u: delete slot %u, %u->%u\n"
        , i
        , result->actions[ i ].slot
        , result->actions[ i ].start
        , result->actions[ i ].length
      );
      break;
    case NAIG_ACTION_REPLACE_CHAR:
      fprintf(stderr, "Action #%u: insert slot %u, at %u char %.2x\n"
        , i
        , result->actions[ i ].slot
        , result->actions[ i ].start
        , result->actions[ i ].length
      );
      break;
    case NAIG_ACTION_REPLACE_QUAD:
      fprintf(stderr, "Action #%u: insert slot %u, at %u quad %.8x\n"
        , i
        , result->actions[ i ].slot
        , result->actions[ i ].start
        , result->actions[ i ].length
      );
      break;
    }
  }
}

