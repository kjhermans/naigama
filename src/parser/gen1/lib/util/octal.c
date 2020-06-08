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

/**
 *
 */
unsigned octal
  (unsigned c1, unsigned c2, unsigned c3)
{
  return ((c1 - '0') * 64) + ((c2 - '0') * 8) + (c3 - '0');
}
