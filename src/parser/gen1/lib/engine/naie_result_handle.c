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
NAIG_ERR_T naie_result_handle
  (
    naie_engine_t* engine,
    naie_result_t* result,
    naie_capture_t capturefnc,
    naie_delete_t deletefnc,
    naie_insert_t insertfnc,
    void* arg
  )
{
  unsigned i, j;
  naie_result_t r = *result;
  int delta;
  uint32_t slot;

  for (i=0; i < r.size; i++) {
    switch (r.actions[ i ].action) {
    case NAIG_ACTION_OPENCAPTURE:
      if (capturefnc) {
        CHECK(
          capturefnc(
            (engine ? engine->input : 0),
            r.actions[ i ].start,
            r.actions[ i ].length,
            arg
          )
        );
      }
      break;
    case NAIG_ACTION_DELETE:
      if (deletefnc) {
        delta = r.actions[ i ].length;
        CHECK(
          deletefnc(
            (engine ? engine->input : 0),
            r.actions[ i ].start,
            r.actions[ i ].length,
            arg
          )
        );
        for (j=i+1; j < r.size; j++) {
          r.actions[ j ].start -= delta;
        }
      }
      break;
    case NAIG_ACTION_REPLACE_CHAR:
    case NAIG_ACTION_REPLACE_QUAD:
      slot = r.actions[ i ].slot;
      for(; i < r.size; i++) {
        if ((r.actions[ i ].action == NAIG_ACTION_REPLACE_CHAR
             || r.actions[ i ].action == NAIG_ACTION_REPLACE_QUAD)
            && r.actions[ i ].slot == slot)
        {
          if (insertfnc) {
fprintf(stderr, "INSERT %u: %u %u\n", i, r.actions[ i ].start, r.actions[ i ].length);
            CHECK(
              insertfnc(
                (engine ? engine->input : 0),
                r.actions[ i ].action,
                r.actions[ i ].start,
                r.actions[ i ].length,
                arg
              )
            );
            for (j=i+1; j < r.size; j++) {
              r.actions[ j ].start +=
                (r.actions[ i ].action == NAIG_ACTION_REPLACE_CHAR ? 1 : 4);
            }
          }
        } else {
          --i;
          break;
        }
      }
      break;
    }
  }
  return NAIG_OK;
}
