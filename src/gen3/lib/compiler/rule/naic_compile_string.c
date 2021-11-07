/**
 * This file is part of Naigama, a parser engine.

Copyright (c) 2020, Kees-Jan Hermans <kees.jan.hermans@gmail.com>
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the <organization> nor the
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

#include "../naic_private.h"

static
NAIG_ERR_T naic_compile_char
  (naic_t* naic, unsigned chr, int last)
{
  (void)last;

  NAIC_WRITE("  char %.2x\n", chr);
  return NAIG_OK;
}

static
NAIG_ERR_T naic_compile_char_alts
  (naic_t* naic, unsigned chr, unsigned alt)
{
  char labelchr[ 64 ], labelalt[ 64 ];

  snprintf(labelchr, sizeof(labelchr), "__CI_CHR_%u", ++(naic->labelcount));
  snprintf(labelalt, sizeof(labelalt), "__CI_ALT_%u", ++(naic->labelcount));
  NAIC_WRITE("  catch %s\n"
             "  char %.2x\n"
             "  commit %s\n"
             "%s:\n"
             "  char %.2x\n"
             "%s:\n"
             , labelalt
             , chr
             , labelchr
             , labelalt
             , alt
             , labelchr
  );
  return NAIG_OK;
}

static
NAIG_ERR_T naic_compile_char_i
  (naic_t* naic, unsigned chr, int last)
{
  (void)last;
  unsigned alt;

  if (chr >= 'a' && chr <= 'z') {
    alt = 'A' + (chr - 'a');
    CHECK(naic_compile_char_alts(naic, chr, alt));
  } else if (chr >= 'A' && chr <= 'Z') {
    alt = 'a' + (chr - 'A');
    CHECK(naic_compile_char_alts(naic, chr, alt));
  } else {
    NAIC_WRITE("  char %.2x\n", chr);
  }
  return NAIG_OK;
}

/**
 * This function can be called both with string->type == SLOT_STRING
 * or string->type == SLOT_STRINGLITERAL (which is under circumstances
 * a child of SLOT_STRING). SLOT_STRING carries with it, whether the
 * string must be interpreted case insensitively. SLOT_STRINGLITERAL
 * doesn't, and is therefore always interpreted case sensitively.
 */
NAIG_ERR_T naic_compile_string
  (naic_t* naic, naio_resobj_t* string)
{
  int caseinsensitive = 0;

  ASSERT(naic != NULL)
  ASSERT(string != NULL)

  if (string->type == SLOT_STRING) {
    if (string->string[ strlen(string->string)-1 ] == 'i') {
      caseinsensitive = 1;
    }
    string = string->children[ 0 ];
  } else if (string->type != SLOT_STRINGLITERAL) {
    abort();
  }

  if (caseinsensitive) {
    string = string->children[ 0 ];
    CHECK(
      naic_string_unescape(
        naic,
        string->origoffset,
        string->origoffset + string->stringlen,
        naic_compile_char_i
      )
    );
  } else {
    string = string->children[ 0 ];
    CHECK(
      naic_string_unescape(
        naic,
        string->origoffset,
        string->origoffset + string->stringlen,
        naic_compile_char
      )
    );
  }
  return NAIG_OK;
}
