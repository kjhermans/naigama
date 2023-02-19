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

#include "naio_private.h"

#include <naigama/instructions.h>

/**
 *
 */
char* naio_slotmap_string
  (naio_slotmap_t* slotmap, unsigned slot)
{
  unsigned i;

  for (i=0; i < slotmap->count; i++) {
    if (slot == slotmap->table[ i ].slot) {
      return slotmap->table[ i ].name;
    }
  }
  return "Slot not found";
}
