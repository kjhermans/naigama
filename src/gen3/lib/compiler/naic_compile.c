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

#include "naic_private.h"

/**
 *
 */
NAIG_ERR_T naic_compile
  (
    naic_t* naic,
    char* grammar,
    naio_slotmap_t* slots,
    unsigned flags,
    char** paths,
    unsigned npaths,
    NAIG_ERR_T(*fnc)(void*,char*,...),
    void* arg
  )
{
  naio_resobj_t* object;
  NAIG_ERR_T e;

  memset(naic, 0, sizeof(naic_t));
  naic->grammar        = grammar;
  naic->slotmap        = slots;
  naic->labelcount     = 0;
  naic->write          = fnc;
  naic->write_arg      = arg;
  naic->flags          = flags;
  naic->paths.string   = paths;
  naic->paths.length   = npaths;
  naic->globalscope    = NEW(naic_nspnod_t);
  naic->currentscope   = naic->globalscope;
  naic->current_buffer = &(naic->write_buffer);
  CHECK(naic_parsetree(grammar, &object, flags & NAIC_FLG_DEBUG));
  e = naic_compile_top(naic, object);
  if (e.code) {
    if (strlen(naic->error)) {
      fprintf(stderr, "Compiler error (%d): %s\n", e.code, naic->error);
    } else {
      fprintf(stderr, "Compiler error (%d).\n", e.code);
    }
    return e;
  }
  CHECK(naic->write(naic->write_arg, "%s", naic->write_buffer.ptr));
  free(naic->write_buffer.ptr);
  naic_nsp_free(naic->globalscope);
  naio_result_object_free(object);
  TODO("Free the capture and rule maps and trees");
  return NAIG_OK;
}
