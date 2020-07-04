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
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
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

#include "naic_private.h"

/**
 *
 */
NAIG_ERR_T naic_process_replaceterms
  (naic_t* naic, unsigned slot)
{
  naie_resact_t* a = &(naic->captures->actions[ naic->capindex ]);
  char l1[ 64 ];

#ifdef _DEBUG
  fprintf(stderr, "-- %s ", __FILE__); naic_debug(naic);
#endif

  snprintf(l1, sizeof(l1), "__REPL_JMP_OVER_%u", (naic->labelcount)++);
  CHECK(naic->write(naic->write_arg,
    "  replace %u %s\n"
    , slot
    , l1
  ));
  ++(naic->capindex);
  ++a;
  while (1) {
    if (a->slot == SLOT_REPLACETERM_STRINGLITERAL) {
      CHECK(naic_process_string(naic));
    } else if (a->slot == SLOT_REPLACETERM_HEXLITERAL) {
      CHECK(naic->write(naic->write_arg,
        "  char %-.*s\n"
        , 2
        , naic->grammar + naic->captures->actions[ naic->capindex ].start + 2
      ));
    } else if (a->slot == SLOT_REPLACETERM_VARREFERENCE) {
      CHECK(naic_process_varreference(naic));
      ++(naic->capindex);
      ++a;
    } else {
      break;
    }
    ++(naic->capindex);
    ++a;
  }
  CHECK(naic->write(naic->write_arg,
    "  endreplace\n"
    "%s:\n"
    , l1
  ));
  return NAIG_OK;
}
