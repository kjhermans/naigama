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

#include <time.h>
#include <sys/select.h>

#include "nais_private.h"

static
int maxfd
  (int* fds, unsigned nfds)
{
  unsigned i;
  int r = -1;

  for (i=0; i < nfds; i++) {
    if (fds[ i ] > r) {
      r = fds[ i ];
    }
  }
  return r + 1;
}

/**
 *
 */
NAIG_ERR_T nais_loop
  (nais_t* nais)
{
  fd_set readset;
  struct timeval tv;
  int r;
  time_t t0 = time(0), t1 = 0;
  int max = maxfd(
    (int[]){
      nais->contexts[ 0 ].fd,
      nais->contexts[ 1 ].fd,
      nais->fdmg
    },
    3
  );

  nais->running = 1;
  while (nais->running) {
    FD_ZERO(&readset);
    FD_SET(nais->contexts[ 0 ].fd, &readset);
    FD_SET(nais->contexts[ 1 ].fd, &readset);
    FD_SET(nais->fdmg, &readset);
    tv = (struct timeval){ 0, 1000000 };
    switch (r = select(max, &readset, 0, 0, &tv)) {
    case -1:
      nais->running = 0;
      return NAIG_ERR_SERVICELOOP;
    case 0:
      break;
    default:
      if (FD_ISSET(nais->contexts[ 0 ].fd, &readset)) {
        CATCHALL(nais_process_data(nais, &(nais->contexts[ 0 ])));
      }
      if (FD_ISSET(nais->contexts[ 1 ].fd, &readset)) {
        CATCHALL(nais_process_data(nais, &(nais->contexts[ 1 ])));
      }
      if (FD_ISSET(nais->fdmg, &readset)) {
        CATCHALL(nais_process_mgmt(nais));
      }
    }
    if ((t1 = time(0)) > t0) {
      CATCHALL(nais_scheduler(nais, t1));
      t0 = t1;
    }
  }
  return NAIG_OK;
}
