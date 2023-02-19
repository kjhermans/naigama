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

#include "naie_private.h"

struct naie_varfind_helper
{
  int found_start;
  int found_stop;
  uint32_t slot;
  unsigned offset_start;
  unsigned offset_stop;
};

static
int naie_variable_find
  (naie_actionlist_t* list, unsigned index, naie_action_t* action, void* arg)
{
  struct naie_varfind_helper* h = arg;
  (void)list;
  (void)index;

  if (h->found_start && h->found_stop) {
    return 0;
  }
  if (action->slot == h->slot) {
    if (action->type == NAIE_ACTION_OPENCAPTURE && h->found_stop) {
      h->offset_start = action->input_offset;
      h->found_start = 1;
    } else if (action->type == NAIE_ACTION_CLOSECAPTURE) {
      h->offset_stop = action->input_offset;
      h->found_stop = 1;
    }
  }

  return 0;
}

/**
 *
 */
NAIG_ERR_T naie_variable
  (
    naie_t* naie,
    naie_ec_t* ec,
    uint32_t slot,
    unsigned char** value,
    unsigned* valuesize
  )
{
  struct naie_varfind_helper h = {
    .found_start = 0,
    .found_stop = 0,
    .slot = slot,
    .offset_start = 0,
    .offset_stop = 0
  };
  int r;
  (void)naie;

  ASSERT(naie);
  ASSERT(ec);

  r = naie_actionlist_reverse(&(ec->actions), naie_variable_find, &h);
  (void)r;
  if (h.found_start && h.found_stop && h.offset_start <= h.offset_stop) {
    *valuesize = h.offset_stop - h.offset_start;
    *value = ec->input.data + h.offset_start;
    return NAIG_OK;
  } else {
    return NAIG_ERR_NOTFOUND;
  }
}
