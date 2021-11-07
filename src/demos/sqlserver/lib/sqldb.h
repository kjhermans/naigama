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

#ifndef _SQLDB_H_
#define _SQLDB_H_

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include <db_185.h>

#include <naigama/engine/naie.h>

#include "slotmap.h"

typedef struct
{
  int                   init;
  DB*                   db;
  naie_engine_t         parser;
}
sqldb_t;

typedef struct
{
  int                   code;
  char                  log[ 128 ];
}
sqldb_outcome_t;

typedef struct
{
  unsigned              noutcomes;
  sqldb_outcome_t*      outcomes;
}
sqldb_result_t;

typedef struct
{
  char*                 fieldname; /* non freeable */
  uint32_t              fielduid;
  uint32_t              fieldtype;
  unsigned              valuelen;
  void*                 value;     /* malloced */
}
sqldb_node_t;

typedef struct
{
  uint32_t              rownumber;
  unsigned              nnodes;
  sqldb_node_t*         nodes;     /* malloced */
}
sqldb_row_t;

typedef struct
{
  unsigned              nuids;
  uint32_t*             uids;
}
sqldb_uidvec_t;

#define SQL_CHECK_NAIG(fnc) if (!NAIG_ISOK(fnc)) { return ~0; }

#define SQLDB_TYPE_TABLE        1
#define SQLDB_TYPE_FIELD        2
#define SQLDB_TYPE_SEQUENCE     3
#define SQLDB_TYPE_INDEX        4
#define SQLDB_TYPE_VIEW         5

#define SQLDB_FIELDTYPE_TIMESTAMPWTZ    1
#define SQLDB_FIELDTYPE_TIMESTAMP       2
#define SQLDB_FIELDTYPE_INTEGER         3
#define SQLDB_FIELDTYPE_CHAR            4
#define SQLDB_FIELDTYPE_VARCHAR         5
#define SQLDB_FIELDTYPE_BOOLEAN         6

#ifdef TODO
#undef TODO
#endif
#define TODO(str) fprintf(stderr, "TODO: %s\n", str);

#ifdef ASSERT
#undef ASSERT
#endif
#define ASSERT(cnd) if (!(cnd)) { fprintf(stderr, "Assertion failed at %s line %d\n", __FILE__, __LINE__); abort(); }

#include "functions.h"
#endif
