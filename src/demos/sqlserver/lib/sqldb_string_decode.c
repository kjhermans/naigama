/**
 * This file is part of Oroszlan, a parsing and scripting environment

Copyright (c) 2021, Kees-Jan Hermans <kees.jan.hermans@gmail.com>
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the organization nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL Kees-Jan Hermans BE LIABLE FOR ANY
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

#include "sqldb.h"

static
unsigned hex
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

/**
 * Decodes a string literal, which will be given with surrounding
 * quotes, and which may contain escape sequences. These sequences
 * will be decoded to a string in node->value.
 * 
 * \param expr The parser capture containing the string literal.
 * \param node The node which, on success, will contain the unescaped
 *             string.
 * \returns    Zero on success, non zero on escape sequence parsing errors.
 */
int sqldb_string_decode
  (naio_resobj_t* expr, sqldb_node_t* node)
{
  unsigned i;
  char* so;

  node->value = malloc(expr->stringlen - 2);
  so = node->value;
  for (i=1; i < expr->stringlen - 1; i++) {
    switch (expr->string[ i ]) {
    case '\\':
      if (++i < expr->stringlen - 1) {
        switch (expr->string[ i ]) {
        case 'x':
          if (i < expr->stringlen - 3) {
            *so++ = hex(expr->string[ i + 1 ], expr->string[ i + 2 ]);
            i += 2;
          } else {
            return ~0;
          }
          break;
        case 'n': *so++ = '\n'; break;
        case 'r': *so++ = '\r'; break;
        case 't': *so++ = '\t'; break;
        case 'v': *so++ = '\v'; break;
        default: *so++ = expr->string[ i ];
        }
      }
      break;
    default:
      *so++ = expr->string[ i ];
    }
  }
  node->valuelen = ((void*)so - node->value);
  return 0;
}
