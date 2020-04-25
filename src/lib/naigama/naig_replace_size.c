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

#include <naigama/naigama.h>

/**
 * Returns the delta size of the buffer needed to process replacements.
 */
int naig_replace_size
  (naig_result_t* result)
{
  unsigned i, j, slot;
  int delta = 0;
  naie_result_t copy = result->result;
  
  for (i=0; i < copy.size; i++) {
    switch (copy.actions[ i ].action) {
    case NAIG_ACTION_REPLACE_CHAR:
    case NAIG_ACTION_REPLACE_QUAD:
      slot = copy.actions[ i ].slot;
      for (j=i; j > 0; j--) {
        if (copy.actions[ j ].action == NAIG_ACTION_OPENCAPTURE
            && copy.actions[ j ].slot == slot)
        {
          delta -= (copy.actions[ j ].stop - copy.actions[ j ].start);
          memmove(
            &(copy.actions[ j ]),
            &(copy.actions[ j+1 ]),
            sizeof(naie_resact_t) * (copy.size - (j+1))
          );
          --i;
          --(copy.size);
        }
      }
      for (; i < copy.size; i++) {
        if (copy.actions[ i ].slot != slot) {
          break;
        }
        switch (copy.actions[ i ].action) {
        case NAIG_ACTION_REPLACE_CHAR:
          delta += 1;
          break;
        case NAIG_ACTION_REPLACE_QUAD:
          delta += 4;
          break;
        }
      }
    }
  }
  return delta;
}
