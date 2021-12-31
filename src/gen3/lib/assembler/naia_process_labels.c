/**
 * This file is part of Raksaka / NAIG,
 * which is a network guard / message parser solution.
 * Copyright 2020, KJ Hermans
 * Written by KJ Hermans <kees.jan.hermans@gmail.com>
 *
 * LICENSE:
 * Withheld
 *
 * \file
 * \brief
 */

#include "naia_private.h"

/**
 * First pass; gather positions of labels.
 */
NAIG_ERR_T naia_process_labels
  (naia_t* naia, naio_resobj_t* object)
{
  unsigned i, offset = 0;

  for (i=0; i < object->nchildren; i++) {
    switch (object->children[ i ]->type) {
    case ASMSLOT_INSTRUCTION_RULEINSTR:
      offset += naia_instruction_length(object->children[ i ]);
      break;
    case ASMSLOT_INSTRUCTION_LABELDEF:
      CHECK(
        naio_labelmap_put(
          &(naia->labels),
          object->children[ i ]->children[ 0 ]->string,
          object->children[ i ]->children[ 0 ]->stringlen,
          offset
        )
      );
      break;
    }
  }
  return NAIG_OK;
}
