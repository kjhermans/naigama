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

/**
 *
 */
unsigned hexcodon
  (unsigned high, unsigned low)
{
  unsigned result = 0;

  if (high >= '0' && high <= '9') { result = ((high - '0') << 4); }
  if (high >= 'a' && high <= 'f') { result = ((high + 10 - 'a') << 4); }
  if (high >= 'A' && high <= 'F') { result = ((high + 10 - 'A') << 4); }
  if (low >= '0' && low <= '9') { result |= (low - '0'); }
  if (low >= 'a' && low <= 'f') { result |= (low + 10 - 'a'); }
  if (low >= 'A' && low <= 'F') { result |= (low + 10 - 'A'); }

  return result;
}
