/**
 * This file is part of NAIG.
 * Copyright 2019, KJ Hermans
 * Written by KJ Hermans <kees.jan.hermans@gmail.com>
 *
 * LICENSE:
 * Withheld
 *
 * \file
 * \brief
 */

#include <naigama/engine/naie.h>

NAIG_ERR_T naie_engine_init
  (
    naie_engine_t* engine,
    const unsigned char* bytecode,
    unsigned bytecode_length,
    const unsigned char* input,
    unsigned input_length
  )
{
  memset(engine, 0, sizeof(naie_engine_t));
  engine->bytecode = bytecode;
  engine->bytecode_length = bytecode_length;
  engine->input = input;
  engine->input_length = input_length;
  //engine->flags = NAIE_FLAG_ENDLESS;
  return NAIG_OK;
}
