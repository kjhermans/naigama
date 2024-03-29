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

#include "naia_private.h"

static
int naia_labelmap_write_name
  (str2int_map_t* map, unsigned i, char* name, unsigned value, void* ptr)
{
  FILE* file = ptr;

  fprintf(file, "    \"%s\": %u", name, value);
  if (i+1 < map->count) {
    fprintf(file, ",");
  }
  fprintf(file, "\n");
  return 0;
}

/**
 * Writes the labelmap as a JSON hash literal to a file.
 * The labelmap is the result of the assembler's first pass.
 * It contains a mapping from label names to bytecode offsets.
 * The JSON structure is as follows:

{
  "type": "labelmap",
  "names": {
    "LABEL1": offset1,
    "LABEL2": offset2
  }
}

 *
 * \param naia  Initialized assembler structure.
 * \param path  Path of the file to contain the JSON labelmap hash literal.
 * \returns     NAIG_OK on success, and a NAIG_ERR_T code on failure.
 */
NAIG_ERR_T naia_labelmap_write
  (naia_t* naia, char* path)
{
  FILE* file = fopen(path, "w+");

  if (file) {
    fprintf(file, "{\n  \"type\": \"labelmap\",\n  \"names\": {\n");
    str2int_map_iterate(&(naia->labelmap), naia_labelmap_write_name, file);
    fprintf(file, "  }\n}\n");
    fclose(file);
    return NAIG_OK;
  }
  RETURNERR(NAIG_ERR_IO);
}
