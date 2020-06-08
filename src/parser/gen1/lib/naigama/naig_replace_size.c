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

#include "naig_private.h"

static
NAIG_ERR_T nrsdel
  (const unsigned char* input, unsigned start, unsigned len, void* arg)
{
  int* delta = (int*)arg;
  (void)input;
  (void)start;

  (*delta) += len;
  return NAIG_OK;
}

static
NAIG_ERR_T nrsins
  (const unsigned char* input, unsigned typ, unsigned start, uint32_t c, void* arg)
{
  int* delta = (int*)arg;
  (void)input;
  (void)start;
  (void)c;

  if (typ == NAIG_ACTION_REPLACE_CHAR) {
    (*delta) += 1;
  } else if (typ == NAIG_ACTION_REPLACE_QUAD) {
    (*delta) += 4;
  }
  return NAIG_OK;
}

/**
 * Returns the delta size of the buffer needed to process replacements.
 */
int naig_replace_size
  (naig_result_t* result)
{
  int delta = 0;
  NAIG_ERR_T e;

  e = naie_handle_result(0, &(result->result), 0, nrsdel, nrsins, &delta);
  if (e.code) {
    return 0;
  } else {
    return delta;
  }
}
