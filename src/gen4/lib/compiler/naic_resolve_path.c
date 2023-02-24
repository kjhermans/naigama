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

#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

#include "naic_private.h"

static
char ipath[ 1024 ];

static
char* rpath = 0;

static
int naic_resolve_path_
  (stringlist_t* list, unsigned index, char** dir, void* arg)
{
  struct stat s;
  char* file = arg;
  (void)list;
  (void)index;

  snprintf(ipath, sizeof(ipath), "%s/%s", *dir, file);
  if (stat(ipath, &s) == 0 && (s.st_mode & S_IFMT) == S_IFREG) {
    rpath = ipath;
  }
  return 0;
}

/**
 *
 */
NAIG_ERR_T naic_resolve_path
  (naic_t* naic, char* path, char** resolvedpath)
{
  struct stat s;

  if (stat(path, &s) == 0 && (s.st_mode & S_IFMT) == S_IFREG) {
    *resolvedpath = path;
    return NAIG_OK;
  }
  
  rpath = 0;
  stringlist_reverse(&(naic->paths), naic_resolve_path_, 0);
  if (rpath) {
    *resolvedpath = rpath;
    return NAIG_OK;
  }
  
  return NAIG_ERR_NOTFOUND;
}
