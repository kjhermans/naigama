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

#include <naigama/util/util_functions.h>

#include "../lib/sqldb.h"

/**
 *
 */
int main
  (int argc, char* argv[])
{
  unsigned char* buf = 0;
  unsigned buflen = 0;
  char* dbpath = "/tmp/db";
  sqldb_t db;
  sqldb_result_t res;

  fprintf(stderr, "SQL DB. ");
#ifdef _USE_SLEEPYCAT
  fprintf(stderr, "Using sleepycat\n");
#else
  fprintf(stderr, "Using sdbm_tree\n");
#endif

  if (sqldb_init(&db, dbpath)) { return ~0; }
  if (argc == 2) {
    if (absorb_file(argv[ 1 ], &buf, &buflen) == 0) {
      if (sqldb_query(&db, (char*)buf, &res)) {
        fprintf(stderr, "Error.\n");
      }
    }
  }
  sqldb_debug(&db);
#ifdef _USE_SLEEPYCAT
  db.db->close(db.db);
#else
  db.db.close(&(db.db));
#endif
  return 0;
}
