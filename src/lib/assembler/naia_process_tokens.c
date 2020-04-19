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

#include <naigama/assembler/naia.h>

/**
 * Topmost function
 */
NAIG_ERR_T naia_process_tokens
  (char* assembly, naie_result_t* captures, FILE* output, FILE* labelmap)
{
  naia_t naia = {
    .assembly     = assembly,
    .captures     = captures,
    .output       = output,
    .labels.size  = 0
  };

#ifdef _DEBUG
  unsigned i;
  for (i=0; i < captures->size; i++) {
    fprintf(stderr, "Token %u: %u-%u %s '%-.*s'\n"
      , i
      , captures->actions[ i ].start
      , captures->actions[ i ].stop
      , naia_slotmap_string(captures->actions[ i ].slot)
      , captures->actions[ i ].stop - captures->actions[ i ].start
      , assembly + captures->actions[ i ].start
    );
  }
#endif

  CHECK(naia_process_labels(&naia));
  CHECK(naia_process_instructions(&naia));
  if (labelmap) {
    CHECK(naia_label_map_write(&naia, labelmap));
    fclose(labelmap);
  }
  return NAIG_OK;
}
