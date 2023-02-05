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

/**
 *
 */
NAIG_ERR_T naic_compile_reference
  (naic_t* naic, naio_resobj_t* ref)
{
  naic_nspnod_t* entry;
  char* rulename = ref->string;


  unsigned parentruleid = ref->aux.num;
  ulist_t parentrules;
  unsigned childruleid;

/*
  if (rule_map_get(&(naic->rule.map), rulename, &childruleid)) {
fprintf(stderr, "Can't resolve rule '%s'\n", rulename);
  }
  if (rule_tree_get(&(naic->rule.tree), parentruleid, &parentrules)) {
    ulist_init(&parentrules);
  }
  if (!ulist_has(&parentrules, childruleid)) {
    ulist_push(&parentrules, childruleid);
  }
fprintf(stderr, "Putting %u -> %u\n", childruleid, parentruleid);
  rule_tree_put(&(naic->rule.tree), parentruleid, parentrules);
*/

  CHECK_AND(
    naic_nsp_get(naic->currentscope, rulename, &entry, 0),
    snprintf(naic->error, sizeof(naic->error),
      "Could not resolve rule '%s'.", rulename
    )
  );

  NAIC_WRITE("  call %s\n", rulename);
  return NAIG_OK;
}
