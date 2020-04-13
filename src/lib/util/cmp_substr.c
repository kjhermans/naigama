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

#include <string.h>

int cmp_substr
  (char* str, unsigned len, char* cmp)
{
  if (strlen(cmp) == len && 0 == memcmp(str, cmp, len)) {
    return 0;
  } else {
    //.. must be more precise
    return -1;
  }
}
