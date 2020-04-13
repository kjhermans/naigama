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

#include <stdlib.h>
#include <stdio.h>

unsigned atoi_substr
  (char* str, unsigned offset, unsigned len)
{
  char substr[ 32 ];

  snprintf(substr, sizeof(substr), "%-.*s", len, str + offset);
  return atoi(substr);
}
