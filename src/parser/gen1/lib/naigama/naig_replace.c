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

struct engine_repl
{
  unsigned char* copy;
  unsigned size;
};

static
NAIG_ERR_T engine_repl_delete
  (const unsigned char* orig, unsigned start, unsigned length, void* arg)
{
  struct engine_repl* e = (struct engine_repl*)arg;
  (void)orig;

  memmove(
    e->copy + start,
    e->copy + start + length,
    e->size - (start + length)
  );
  e->size -= length;
  return NAIG_OK;
}

static
NAIG_ERR_T engine_repl_insert
  (const unsigned char* orig, unsigned typ, unsigned start, uint32_t chr, void* arg)
{
  struct engine_repl* e = (struct engine_repl*)arg;
  (void)orig;

  e->copy = (unsigned char*)realloc(e->copy, e->size + 4);
  switch (typ) {
  case NAIG_ACTION_REPLACE_CHAR:
    memmove(
      e->copy + start + 1,
      e->copy + start,
      e->size - start
    );
    e->copy[ start ] = (unsigned char)chr;
    e->size += 1;
    break;
  case NAIG_ACTION_REPLACE_QUAD:
    memmove(
      e->copy + start + 4,
      e->copy + start,
      e->size - start
    );
    memcpy(e->copy + start, &chr, 4);
    e->size += 4;
    break;
  }
  return NAIG_OK;
}

/**
 * Returns a malloc'ed buffer which has processed the replacements
 * inside the result list.
 */
NAIG_ERR_T naig_replace
  (
    naig_t* naig,
    unsigned char* input,
    unsigned input_length,
    naig_result_t* result,
    unsigned char** output,
    unsigned* output_length
  )
{
  struct engine_repl e = {
    malloc(input_length),
    input_length
  };
  (void)naig;

  memcpy(e.copy, input, input_length);
  CHECK(
    naie_handle_result(
      0,
      &(result->result),
      NULL,
      engine_repl_delete,
      engine_repl_insert,
      &e
    )
  );
  *output = e.copy;
  *output_length = e.size;
  return NAIG_OK;
}
