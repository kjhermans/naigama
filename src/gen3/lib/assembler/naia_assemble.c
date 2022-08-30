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

#include <naigama/assembler/naia_grammar.h>

static
const unsigned char bytecode[] = { _BYTECODE_ASSEMBLY };

static
NAIG_ERR_T naia_write_buf
  (void* ptr, unsigned size, void* arg)
{
  naio_buf_t* w = (naio_buf_t*)arg;

  if (w->len + size > w->alc) {
    w->alc = w->len + size + 1024;
    w->ptr = realloc(w->ptr, w->alc);
  }
  memcpy(w->ptr + w->len, ptr, size);
  w->len += size;
  return NAIG_OK;
}

static
NAIG_ERR_T naia_engine_debug_cont
  (naie_engine_t* engine, uint32_t opcode, void* ptr)
{
  (void)ptr;

  if (opcode == 0xffffffff) {
    fprintf(stderr, "======== FAIL\n");
  } else {
    naie_debug_state(engine, 0, 0);
  }
  return NAIG_OK;
}

/**
 *
 */
NAIG_ERR_T naia_assemble
  (
    char* assembly,
    naio_labelmap_t* labelmap,
    int debug,
    NAIG_ERR_T(*naia_write)(void* ptr, unsigned size, void* arg),
    void* arg
  )
{
  naie_engine_t engine;
  naio_result_t result;
  naio_resobj_t* object;
  NAIG_ERR_T e;

  CHECK(
    naie_engine_init(
      &engine,
      bytecode,
      sizeof(bytecode)
    )
  );
  if (debug) {
    engine.flags |= NAIE_FLAG_DEBUG;
    engine.debugger = naia_engine_debug_cont;
  }
  e = naie_engine_run(
    &engine,
    (const unsigned char*)assembly,
    strlen(assembly),
    &result
  );
  if (e.code) {
    unsigned yx[ 2 ];
    if (strxypos(assembly, engine.input_pos, yx) == 0) {
      fprintf(stderr, "Assembly parsing error line %u, off %u\n", yx[0], yx[1]);
    } else {
      fprintf(stderr, "Assembly parsing error.\n");
    }
    exit(-1);
  }

  naia_t naia = {
    .assembly       = assembly,
    .captures       = &result,
    .labels.entries = malloc(sizeof(naio_labent_t) * 1024),
    .labels.count   = 0,
    .labels.length  = 1024,
    .buffer         = NAIO_BUF_INIT,
    .write          = naia_write_buf,
    .write_arg      = &(naia.buffer)
  };

#ifdef _DEBUG
  fprintf(stderr, "Assembly parsed Ok.\n");
#endif
  object = naio_result_object(engine.input, engine.input_length, &result);
  naie_engine_free(&engine);
  naie_result_free(&result);
  CHECK(naia_process_tokens(&naia, object));
#ifdef _DEBUG
  fprintf(stderr, "Assembler: %u labels\n", naia.labels.count);
  fprintf(stderr, "Writing %u bytes bytecode.\n", naia.buffer.len);
#endif
  if (naia.buffer.len == 0) {
    fprintf(stderr, "Warning: writing zero bytes of bytecode.\n");
  }
  CHECK(naia_write(naia.buffer.ptr, naia.buffer.len, arg));
  free(naia.buffer.ptr);

  if (labelmap) {
    *labelmap = naia.labels;
  } else {
    for (unsigned i=0; i < naia.labels.count; i++) {
      free(naia.labels.entries[ i ].str);
    }
    free(naia.labels.entries);
  }
  naio_result_object_free(object);
  return NAIG_OK;
}
