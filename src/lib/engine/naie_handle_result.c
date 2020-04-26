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
NAIG_ERR_T naie_handle_result
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
            engine->input,
            r.actions[ i ].start,
            r.actions[ i ].length,
            arg
          )
        );
      }
      break;
    case NAIG_ACTION_REPLACE_CHAR:
    case NAIG_ACTION_REPLACE_QUAD:
      slot = r.actions[ i ].slot;
      for (j=i; j > 0; j--) {
        if (r.actions[ j-1 ].action == NAIG_ACTION_OPENCAPTURE
            && r.actions[ j-1 ].slot == slot)
        {
          delta = r.actions[ j-1 ].length;
          r.actions[ j-1 ].action = 0;
          if (deletefnc) {
            CHECK(
              deletefnc(
                engine->input,
                r.actions[ j-1 ].start, 
                delta,
                arg
              )
            );
            for (j=i+1; j < r.size; j++) {
              r.actions[ j ].start -= delta;
            }
          }
          break;
        }
      }
      for(; i < r.size; i++) {
        if ((r.actions[ i ].action == NAIG_ACTION_REPLACE_CHAR
             || r.actions[ i ].action == NAIG_ACTION_REPLACE_QUAD)
            && r.actions[ i ].slot == slot)
        {
          if (insertfnc) {
            CHECK(
              insertfnc(
                engine->input,
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
          break;
        }
      }
      break;
    }
  }
  return NAIG_OK;
}
