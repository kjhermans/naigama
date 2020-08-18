/**
 * This file is part of Naigama, a parser engine.

Copyright (c) 2020, Kees-Jan Hermans <kees.jan.hermans@gmail.com>
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the <organization> nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

 *
 * \file
 * \brief
 */

#include "naic_private.h"

static
const unsigned char bytecode[] = GRAMMAR_BYTECODE;

/**
 *
 */
NAIG_ERR_T naic_compile
  (
    char* grammar,
    naic_slotmap_t* slots,
    int debug,
    int traps,
    NAIG_ERR_T(*fnc)(void*,char*,...),
    void* arg
  )
{
  naie_engine_t engine;
  naie_result_t result;
  NAIG_ERR_T e;

fprintf(stderr, "BYTECODE SIZE IS %u\n", sizeof(bytecode));

  CHECK(
    naie_engine_init(
      &engine,
      bytecode,
      sizeof(bytecode),
      (const unsigned char*)grammar,
      strlen(grammar)
    )
  );
  if (debug) { engine.flags |= NAIE_FLAG_DEBUG; }
  e = naie_engine_run(&engine, &result);
  if (e.code == 1) { //NAIG_FAILURE) {
    unsigned yx[ 2 ];
    if (strxypos(grammar, engine.input_pos, yx) == 0) {
      fprintf(stderr, "Grammar parsing error line %u, off %u\n", yx[0], yx[1]);
    } else {
      fprintf(stderr, "Grammar parsing error.\n");
    }
    exit(-1);
  }
  naic_t naic = {
    .grammar     = grammar,
    .captures    = &result,
    .capindex    = 0,
    .slotmap     = slots,
    .labelcount  = 0,
    .write       = fnc,
    .write_arg   = arg
  };
  if (traps) {
    naic.flags |= NAIC_FLG_TRAPS;
  }
  CHECK(naic_process_tokens(&naic));
  return NAIG_OK;
}
