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
NAIG_ERR_T naic_compile_quantified_matcher
  (naic_t* naic, naie_resobj_t* matcher, int range[ 2 ])
{
  int i, diff;
  unsigned slotretain = naic->slot;
  char counterlabel[ 64 ];
  char forgivelabel[ 64 ];
  char foreverlabel[ 64 ];
  unsigned counter;

  snprintf(forgivelabel, sizeof(forgivelabel), "__FORGIVE_%u", ++(naic->labelcount));
  snprintf(foreverlabel, sizeof(foreverlabel), "__FOREVER_%u", ++(naic->labelcount));
  if (naic->flags & NAIC_FLG_LOOPS) {
    for (i=0; i < range[ 0 ]; i++) {
      naic->slot = slotretain;
      CHECK(naic_compile_matcher(naic, matcher));
    }
  } else if (range[ 0 ] > 0) {
    counter = (naic->counter)++;
    snprintf(counterlabel, sizeof(counterlabel), "__COUNTER_%u", ++(naic->labelcount));
    CHECK(naic->write(naic->write_arg, "  counter %u %d\n", counter, range[ 0 ]));
    CHECK(naic->write(naic->write_arg, "%s:\n", counterlabel));
    naic->slot = slotretain;
    CHECK(naic_compile_matcher(naic, matcher));
    CHECK(naic->write(naic->write_arg, "  condjump %u %s\n", counter, counterlabel));
  }
  if (range[ 1 ] == -1) {
    CHECK(naic->write(naic->write_arg, "  catch %s\n", forgivelabel));
    CHECK(naic->write(naic->write_arg, "%s:\n", foreverlabel));
    naic->slot = slotretain;
    CHECK(naic_compile_matcher(naic, matcher));
    CHECK(naic->write(naic->write_arg, "  partialcommit %s\n", foreverlabel));
    CHECK(naic->write(naic->write_arg, "%s:\n", forgivelabel));
  } else if (range[ 1 ] > range[ 0 ]) {
    diff = range[ 1 ] - range[ 0 ];
    if (diff > 1) {
      if (naic->flags & NAIC_FLG_LOOPS) {
        CHECK(naic->write(naic->write_arg, "  catch %s\n", forgivelabel));
        for (i=0; i < diff; i++) {
          naic->slot = slotretain;
          CHECK(naic_compile_matcher(naic, matcher));
          CHECK(naic->write(naic->write_arg, "  partialcommit\n", forgivelabel));
        }
        CHECK(naic->write(naic->write_arg, "  commit\n"));
        CHECK(naic->write(naic->write_arg, "%s:\n", forgivelabel));
      } else {
        counter = (naic->counter)++;
        snprintf(counterlabel, sizeof(counterlabel), "__COUNTER_%u", ++(naic->labelcount));
        CHECK(naic->write(naic->write_arg, "  catch %s\n", forgivelabel));
        CHECK(naic->write(naic->write_arg, "  counter %u %d\n", counter, range[ 1 ]));
        CHECK(naic->write(naic->write_arg, "%s:\n", counterlabel));
        naic->slot = slotretain;
        CHECK(naic_compile_matcher(naic, matcher));
        CHECK(naic->write(naic->write_arg, "  partialcommit\n", forgivelabel));
        CHECK(naic->write(naic->write_arg, "  condjump %u %s\n", counter, counterlabel));
        CHECK(naic->write(naic->write_arg, "  commit\n"));
        CHECK(naic->write(naic->write_arg, "%s:\n", forgivelabel));
      }
    } else if (diff == 1) {
      CHECK(naic->write(naic->write_arg, "  catch %s\n", forgivelabel));
      naic->slot = slotretain;
      CHECK(naic_compile_matcher(naic, matcher));
      CHECK(naic->write(naic->write_arg, "  commit\n"));
      CHECK(naic->write(naic->write_arg, "%s:\n", forgivelabel));
    }
  }
  return NAIG_OK;
}
