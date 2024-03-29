/**
* \file
* \brief This file is an autogenerated function prototypes header file.
*
* Copyright 2018 K.J. Hermans
* WARNING: This file is automatically generated. Any changes will be lost.
*/

#ifndef ___FUNCTIONS_H_
#define ___FUNCTIONS_H_

/* declared in ./sqldb_createsequence.c */
extern
int sqldb_createsequence
  (sqldb_t* db, naio_resobj_t* stmt, sqldb_result_t* result)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_createtable.c */
extern
int sqldb_createtable
  (sqldb_t* db, naio_resobj_t* stmt, sqldb_result_t* result)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_createtable_addfield.c */
extern
int sqldb_createtable_addfield
  (sqldb_t* db, uint32_t tableuid, naio_resobj_t* field, sqldb_result_t* result)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_debug.c */
extern
void sqldb_debug
  (sqldb_t* db);

/* declared in ./sqldb_droptable.c */
extern
int sqldb_droptable
  (sqldb_t* db, naio_resobj_t* stmt, sqldb_result_t* result)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_expr2.c */
extern
int sqldb_expr2
  (sqldb_t* db, naio_resobj_t* expr, sqldb_node_t* node)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_expr3.c */
extern
int sqldb_expr3
  (sqldb_t* db, naio_resobj_t* expr, sqldb_node_t* node)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_expr4.c */
extern
int sqldb_expr4
  (sqldb_t* db, naio_resobj_t* expr, sqldb_node_t* node)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_expr5.c */
extern
int sqldb_expr5
  (sqldb_t* db, naio_resobj_t* expr, sqldb_node_t* node)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_expr6.c */
extern
int sqldb_expr6
  (sqldb_t* db, naio_resobj_t* expr, sqldb_node_t* node)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_expression.c */
extern
int sqldb_expression
  (sqldb_t* db, naio_resobj_t* expr, sqldb_node_t* node)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_field_create.c */
extern
int sqldb_field_create
  (sqldb_t* db, uint32_t tableuid, char* name, uint32_t type, uint32_t* uid)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_field_list.c */
extern
int sqldb_field_list
  (sqldb_t* db, uint32_t tableuid, sqldb_uidvec_t* list)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_field_resolve.c */
extern
int sqldb_field_resolve
  (sqldb_t* db, uint32_t tableuid, char* name, uint32_t* uid, uint32_t* type)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_init.c */
extern
int sqldb_init
  (sqldb_t* db, char* path)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_insert.c */
extern
int sqldb_insert
  (sqldb_t* db, naio_resobj_t* stmt, sqldb_result_t* result)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_insert_assignvalues.c */
extern
int sqldb_insert_assignvalues
  (sqldb_t* db, naio_resobj_t* valuelist, sqldb_row_t* row)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_insert_fieldlist.c */
extern
int sqldb_insert_fieldlist
  (sqldb_t* db, uint32_t tableuid, naio_resobj_t* fieldlist, sqldb_row_t* row)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_literal.c */
extern
int sqldb_literal
  (sqldb_t* db, naio_resobj_t* expr, sqldb_node_t* node)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_namespace_get.c */
extern
int sqldb_namespace_get
  (sqldb_t* db, char* name, uint32_t* uid, uint32_t* type)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_namespace_get_h.c */
extern
int sqldb_namespace_get_h
  (sqldb_t* db, uint32_t parent, char* name, uint32_t* uid, uint32_t* type)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_namespace_put.c */
extern
int sqldb_namespace_put
  (sqldb_t* db, char* name, uint32_t* uid, uint32_t type)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_namespace_put_h.c */
extern
int sqldb_namespace_put_h
  (sqldb_t* db, uint32_t parent, char* name, uint32_t* uid, uint32_t type)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_query.c */
extern
int sqldb_query
  (sqldb_t* db, char* query, sqldb_result_t* result)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_result_push.c */
extern
void sqldb_result_push
  (sqldb_result_t* res);

/* declared in ./sqldb_result_push_log.c */
extern
void sqldb_result_push_log
  (sqldb_result_t* res, char* fmt, ...);

/* declared in ./sqldb_row_add_field.c */
extern
void sqldb_row_add_field
  (sqldb_row_t* row, char* fieldname, uint32_t uid, uint32_t type);

/* declared in ./sqldb_row_debug.c */
extern
void sqldb_row_debug
  (sqldb_row_t* row);

/* declared in ./sqldb_row_free.c */
extern
void sqldb_row_free
  (sqldb_row_t* row);

/* declared in ./sqldb_row_insert.c */
extern
int sqldb_row_insert
  (sqldb_t* db, sqldb_row_t* row, sqldb_result_t* result)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_row_new.c */
extern
void sqldb_row_new
  (sqldb_row_t* row, uint32_t rownumber);

/* declared in ./sqldb_rowagr_fetch.c */
extern
int sqldb_rowagr_fetch
  (sqldb_rowagr_t* agr, sqldb_row_t* row)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_rowagr_init.c */
extern
void sqldb_rowagr_init
  (sqldb_t* db, sqldb_rowagr_t* agr, sqldb_uidvec_t* fieldlist);

/* declared in ./sqldb_select.c */
extern
int sqldb_select
  (sqldb_t* db, naio_resobj_t* stmt, sqldb_result_t* result)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_select_fieldlist.c */
extern
int sqldb_select_fieldlist
  (
    sqldb_t* db,
    naio_resobj_t* what,
    sqldb_uidvec_t* tables,
    sqldb_uidvec_t* fields
  )
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_select_from.c */
extern
int sqldb_select_from
  (sqldb_t* db, naio_resobj_t* from, sqldb_uidvec_t* tables)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_sequence_create.c */
extern
int sqldb_sequence_create
  (sqldb_t* db, char* name, unsigned value, uint32_t* uid)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_statement.c */
extern
int sqldb_statement
  (sqldb_t* db, naio_resobj_t* stmt, sqldb_result_t* result)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_string_decode.c */
extern
int sqldb_string_decode
  (naio_resobj_t* expr, sqldb_node_t* node)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_table_create.c */
extern
int sqldb_table_create
  (sqldb_t* db, char* name, uint32_t* uid)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_table_resolve.c */
extern
int sqldb_table_resolve
  (sqldb_t* db, char* name, uint32_t* uid, uint32_t* nrows)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_table_update.c */
extern
int sqldb_table_update
  (sqldb_t* db, uint32_t uid, uint32_t nrows)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_term.c */
extern
int sqldb_term
  (sqldb_t* db, naio_resobj_t* expr, sqldb_node_t* node)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_uid_new.c */
extern
int sqldb_uid_new
  (sqldb_t* db, uint32_t* uid)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_uidvec_has.c */
extern
int sqldb_uidvec_has
  (sqldb_uidvec_t* vec, uint32_t uid)
  __attribute__ ((warn_unused_result));

/* declared in ./sqldb_uidvec_new.c */
extern
void sqldb_uidvec_new
  (sqldb_uidvec_t* vec);

/* declared in ./sqldb_uidvec_push.c */
extern
int sqldb_uidvec_push
  (sqldb_uidvec_t* vec, uint32_t uid)
  __attribute__ ((warn_unused_result));



#endif