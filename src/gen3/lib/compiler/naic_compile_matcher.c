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
NAIG_ERR_T naic_compile_matcher
  (naic_t* naic, naie_resobj_t* matcher)
{
  switch (matcher->type) {
  case SLOT_MATCHER_ANY:
    CHECK(naic_compile_any(naic));
    break;
  case SLOT_MATCHER_SET:
    CHECK(naic_compile_set(naic, matcher));
    break;
  case SLOT_MATCHER_STRING:
    CHECK(naic_compile_string(naic, matcher));
    break;
  case SLOT_MATCHER_BITMASK:
    break;
  case SLOT_MATCHER_HEXLITERAL:
    CHECK(naic_compile_hexliteral(naic, matcher));
    break;
  case SLOT_MATCHER_VARCAPTURE:
    break;
  case SLOT_MATCHER_CAPTURE:
    break;
  case SLOT_MATCHER_GROUP:
    CHECK(naic_compile_group(naic, matcher));
    break;
  case SLOT_MATCHER_MACRO:
    CHECK(naic_compile_macro(naic, matcher));
    break;
  case SLOT_MATCHER_ENDFORCE:
    CHECK(naic_compile_endforce(naic, matcher));
    break;
  case SLOT_MATCHER_VARREFERENCE:
    break;
  case SLOT_MATCHER_REFERENCE:
    CHECK(naic_compile_reference(naic, matcher));
    break;
  }
  return NAIG_OK;
}
