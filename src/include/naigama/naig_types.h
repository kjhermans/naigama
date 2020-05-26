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

#ifndef _NAIG_TYPES_H_
#define _NAIG_TYPES_H_

typedef struct
{
  int                                   code;
}
NAIG_ERR_T;

typedef struct
{
  char*                         grammar;
  unsigned char*                bytecode;
  unsigned                      bytecode_length;
}
naig_t;

#include <naigama/engine/naie_types.h>

typedef struct
{
  naie_result_t                 result;
}
naig_result_t;

#endif // !_NAIG_TYPES_H_
