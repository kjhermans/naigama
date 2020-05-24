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

/**
 * Compares a piece of memory with a zero terminated string,
 * without comparing the ending zero.
 *
 * \param mem   Piece of memory to compare with
 * \oaram len   Size of the piece of memory
 * \oaram cmp   Zero terminated string to compare memory with
 *
 * \returns zero on success.
 *          Function fails when either the lengths do not compare
 *          or when the pieces of memory (excluding the terminating zero)
 *          are different.
 */
int cmp_substr
  (char* mem, unsigned len, char* cmp)
{
  if (strlen(cmp) == len && 0 == memcmp(mem, cmp, len)) {
    return 0;
  } else {
    //.. must be more precise
    return -1;
  }
}
