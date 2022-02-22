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

#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

#include <naigama/engine/naie.h>
#include <naigama/naig_private.h>
#include "../naic_private.h"

static
NAIG_ERR_T naic_fp_import_path
  (naic_t* naic, naio_resobj_t* rule, char* path)
{
  char* buf = 0;
  unsigned len = 0;
  naio_resobj_t* parsetree;

  fprintf(stderr, "Importing '%s'\n", path);
  if (naic->importrecursion >= NAIG_IMPORTRECURSION_MAX) {
    return NAIG_ERR_IMPORTRECURSION;
  }
  if (absorb_file(path, (unsigned char**)(&buf), &len)) {
    return NAIG_ERR_IMPORT;
  }
  CHECK(naic_parsetree(buf, &parsetree, naic->flags & NAIC_FLG_DEBUG));
  for (unsigned i=0; i < rule->nchildren; i++) {
    naio_result_object_free(rule->children[ i ]);
  }
  rule->nchildren = 1;
  rule->children[ 0 ] = parsetree;
  ++(naic->importrecursion);
  CHECK(naic_fp(naic, parsetree, &(naic->globalscope)));
  --(naic->importrecursion);
  return NAIG_OK;
}

/**
 *
 */
NAIG_ERR_T naic_fp_import
  (naic_t* naic, naio_resobj_t* rule)
{
  char* string = rule->children[ 1 ]->children[ 0 ]->children[ 0 ]->string;
  char path[ 256 ];
  unsigned i;
  struct stat s;

  if (stat(string, &s) == 0 && (s.st_mode & S_IFMT) == S_IFREG) {
    CHECK(naic_fp_import_path(naic, rule, string));
    return NAIG_OK;
  } else {
    for (i=0; i < naic->paths.length; i++) {
      snprintf(path, sizeof(path), "%s/%s", naic->paths.string[ i ], string);
      if (stat(path, &s) == 0 && (s.st_mode & S_IFMT) == S_IFREG) {
        CHECK(naic_fp_import_path(naic, rule, path));
        return NAIG_OK;
      }
    }
  }
  return NAIG_ERR_IMPORT;
}
