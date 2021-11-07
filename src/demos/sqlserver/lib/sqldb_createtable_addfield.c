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

#include "sqldb.h"

/**
 * Helper function to a 'CREATE TABLE' statement handler.
 * Adds a field to a table definition.
 *
 * \param db       Pointer to initialized database structure.
 * \param tableuid UID of the table to which the field must be added.
 * \param field    Parser object containing the field definition information.
 * \param result   On success, the result structure will be filled.
 *
 * \returns        Zero on success, non-zero on failure.
 */
int sqldb_createtable_addfield
  (sqldb_t* db, uint32_t tableuid, naio_resobj_t* field, sqldb_result_t* result)
{
  char* name;
  uint32_t type;
  uint32_t uid;

//naio_resobj_debug(field, 0);

  if (field->nchildren >= 1 && field->children[ 0 ]->type == SLOTMAP_FIELDNAME_) {
    name = field->children[ 0 ]->children[ 0 ]->string;
    if (field->nchildren >= 2 && field->children[ 1 ]->type == SLOTMAP_FIELDTYPE_) {
      switch (field->children[ 1 ]->children[ 0 ]->type) {
      case SLOTMAP_TIMESTAMPWTZ_:
        type = SQLDB_FIELDTYPE_TIMESTAMPWTZ;
        break;
      case SLOTMAP_KW_TIMESTAMP_:
        type = SQLDB_FIELDTYPE_TIMESTAMP;
        break;
      case SLOTMAP_KW_INTEGER_:
        type = SQLDB_FIELDTYPE_INTEGER;
        break;
      case SLOTMAP_KW_CHAR_:
        type = SQLDB_FIELDTYPE_CHAR;
        break;
      case SLOTMAP_KW_VARCHAR_:
        type = SQLDB_FIELDTYPE_CHAR;
        break;
      case SLOTMAP_KW_BOOLEAN_:
        type = SQLDB_FIELDTYPE_BOOLEAN;
        break;
      default:
        fprintf(stderr, "Unknown field type %s\n", field->children[1]->string);
        abort();
      }
      if (sqldb_field_create(db, tableuid, name, type, &uid)) {
        fprintf(stderr, "Could not create field '%s'\n", name);
        return ~0;
      }
      sqldb_result_push_log(result, "Field created '%s'; uid %u", name, uid);
    }
  }
  return 0;
}
