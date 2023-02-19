/**
 * This file is part of Oroszlan, a parsing and scripting environment

Copyright (c) 2023, Kees-Jan Hermans <kees.jan.hermans@gmail.com>
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

#include "naic_private.h"
#include <naigama/engine/naie_type_actions.h>
#include <naigama/naigama/naig_type_resobj.h>
#include <naigama/prevgen/naip.h>
#include <naigama/naigama/naig_functions.h>

#include <naigama/prevgen/naip.h>

static unsigned char grammar_bytecode[] = {
#include "../../grammar/grammar.h"
};

/**
 *
 */
NAIG_ERR_T naic_compile
  (naic_t* naic)
{
  naip_t naip;
  naip_actionlist_t actions;
  int r;

  r = naip_parse(
    &naip,
    grammar_bytecode,
    sizeof(grammar_bytecode),
    naic->grammar,
    &actions
  );

  if (r) {
//.. something something naip.data
    RETURNERR(NAIG_ERR_PARSER);
  }

  naig_resobj_t* resobj = naig_result_object((unsigned char*)(naic->grammar), strlen(naic->grammar), &actions);

  naig_result_object_clean(resobj, SLOTMAP_S_);
  naig_result_object_clean(resobj, SLOTMAP_COMMENT_);
  naig_result_object_clean(resobj, SLOTMAP_MULTILINECOMMENT_);
  naig_result_object_clean(resobj, SLOTMAP___prefix_);
  naig_result_object_clean(resobj, SLOTMAP_BOPEN_);
  naig_result_object_clean(resobj, SLOTMAP_BCLOSE_);
  naig_result_object_clean(resobj, SLOTMAP_CBOPEN_);
  naig_result_object_clean(resobj, SLOTMAP_CBCLOSE_);
  naig_result_object_clean(resobj, SLOTMAP_COLON_);
  naig_result_object_clean(resobj, SLOTMAP_LEFTARROW_);
  naig_result_object_clean(resobj, SLOTMAP_OR_);
/*
  naig_result_object_clean(resobj, SLOTMAP_END_);
  naig_result_object_clean(resobj, SLOTMAP_ABOPEN_);
  naig_result_object_clean(resobj, SLOTMAP_ABCLOSE_);
*/

  naig_result_object_debug(resobj, 0);

  return NAIG_OK;
}
