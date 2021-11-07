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
 * Topmost function
 */
NAIG_ERR_T naia_process_tokens
  (naia_t* naia, naio_resobj_t* object)
{
  (void)object;
#ifdef _DEBUG
  naio_result_object_debug(object, 0);
#endif

  CHECK(naia_process_labels(naia, object));
  CHECK(naia_process_instructions(naia, object));
  return NAIG_OK;
}
