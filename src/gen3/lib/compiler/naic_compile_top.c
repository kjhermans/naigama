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

#include <time.h>

#include "naic_private.h"

/**
 *
 */
NAIG_ERR_T naic_compile_top
  (naic_t* naic, naio_resobj_t* top)
{
  //unsigned i;
  char timestring[ 64 ];
  time_t t;
  struct tm* tm;

  t = time(0);
  tm = localtime(&t);
  strftime(timestring, sizeof(timestring)-1, "%a, %d %b %Y %T %z", tm);
  NAIC_WRITE(
    "--\n-- Naigama compiler library; gen %s; release %s\n-- At %s\n--\n\n"
    , NAIG_GENERATION
    , NAIGAMA_RELEASE
    , timestring
  );

  /** first pass **/
  CHECK(naic_fp(naic, top, &(naic->globalscope)));

  if (naic->global_buffer.len) {
    NAIC_WRITE("\n%s\n", naic->global_buffer.ptr);
  }

  switch (naic->firsttype) {
  case NAIC_FIRST_RULE:
  case NAIC_FIRST_MAINRULE:
    NAIC_WRITE("  call %s\n  end 0\n", naic->first);
    break;
  case NAIC_FIRST_IMPLICITRULE:
    break;
  default:
#ifdef _DEBUG
    fprintf(stderr, "WARNING: No initial calling target defined.\n");
#endif
    break;
  }

  /** second pass **/
  CHECK(naic_sp(naic, top));
  if (naic->postfix.fill) {
    NAIC_WRITE("\n  end 0 -- postfix\n");
    NAIC_WRITE("%s", naic->postfix.string);
  } else {
    NAIC_WRITE(
      "\n  end 0\n"
    );
  }
  return NAIG_OK;
}
