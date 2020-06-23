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

#ifndef _NASC_TYPES_H_
#define _NASC_TYPES_H_

typedef struct
{
  char* code;
  naie_result_t* captures;
}
nasc_t;

#endif
