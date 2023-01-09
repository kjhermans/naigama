/**
* \file
* \brief This file is an autogenerated function prototypes header file.
*
* Copyright 2018 K.J. Hermans
* WARNING: This file is automatically generated. Any changes will be lost.
*/

#ifndef _NAIGAMA_ENGINE_FUNCTIONS_H_
#define _NAIGAMA_ENGINE_FUNCTIONS_H_

/* declared in ./lib/engine/naie_action_peek.c */
extern
NAIG_ERR_T naie_action_peek
  (naie_engine_t* engine, naie_action_t* action)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/engine/naie_action_push.c */
extern
NAIG_ERR_T naie_action_push
  (naie_engine_t* engine, naie_action_t action)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/engine/naie_capture.c */
extern
NAIG_ERR_T naie_capture
  (
    naie_engine_t* engine,
    unsigned char* input,
    unsigned input_length,
    int(*capture)(unsigned, unsigned char*, unsigned, unsigned, void*),
    void* ptr
  )
  __attribute__ ((warn_unused_result));

/* declared in ./lib/engine/naie_debug_actions.c */
extern
void naie_debug_actions
  (naie_engine_t* engine);

/* declared in ./lib/engine/naie_debug_instruction.c */
extern
void naie_debug_instruction
  (naie_engine_t* engine);

/* declared in ./lib/engine/naie_debug_state.c */
extern
void naie_debug_state
  (naie_engine_t* engine, int full, int hex);

/* declared in ./lib/engine/naie_engine_call.c */
extern
NAIG_ERR_T naie_engine_call
  (
    naie_engine_t* engine,
    char* label,
    naio_result_t* result
  )
  __attribute__ ((warn_unused_result));

/* declared in ./lib/engine/naie_engine_call_offset.c */
extern
NAIG_ERR_T naie_engine_call_offset
  (
    naie_engine_t* engine,
    uint32_t offset,
    naio_result_t* result
  )
  __attribute__ ((warn_unused_result));

/* declared in ./lib/engine/naie_engine_endless_loop.c */
extern
NAIG_ERR_T naie_engine_endless_loop
  (naie_engine_t* engine)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/engine/naie_engine_free.c */
extern
void naie_engine_free
  (naie_engine_t* engine);

/* declared in ./lib/engine/naie_engine_init.c */
extern
NAIG_ERR_T naie_engine_init
  (
    naie_engine_t* engine,
    const unsigned char* bytecode,
    unsigned bytecode_length
  )
  __attribute__ ((warn_unused_result));

/* declared in ./lib/engine/naie_engine_init_mem.c */
extern
NAIG_ERR_T naie_engine_init_mem
  (
    naie_engine_t*        engine,
    const unsigned char*  bytecode,
    unsigned              bytecode_length,
    const unsigned char*  input,
    unsigned              input_length,
    void*                 mem_stack,
    unsigned              mem_stack_size,
    void*                 mem_actions,
    unsigned              mem_actions_size,
    void*                 mem_reg,
    unsigned              mem_reg_size
  )
  __attribute__ ((warn_unused_result));

/* declared in ./lib/engine/naie_engine_loop.c */
extern
NAIG_ERR_T naie_engine_loop
  (
    naie_engine_t* engine,
    naio_result_t* result
  )
  __attribute__ ((warn_unused_result));

/* declared in ./lib/engine/naie_engine_loop_replace.c */
extern
NAIG_ERR_T naie_engine_loop_replace
  (
    naie_engine_t* engine,
    uint32_t slot
  )
  __attribute__ ((warn_unused_result));

/* declared in ./lib/engine/naie_engine_run.c */
extern
NAIG_ERR_T naie_engine_run
  (
    naie_engine_t* engine,
    unsigned char* input,
    unsigned input_length,
    naio_result_t* result
  )
  __attribute__ ((warn_unused_result));

/* declared in ./lib/engine/naie_instr_string.c */
extern
char* naie_instr_string
  (uint32_t opcode)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/engine/naie_output.c */
extern
NAIG_ERR_T naie_output
  (naio_result_t* result, FILE* output)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/engine/naie_register_retrieve.c */
extern
NAIG_ERR_T naie_register_retrieve
  (naie_engine_t* engine, uint32_t reg, uint32_t* value)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/engine/naie_register_store.c */
extern
NAIG_ERR_T naie_register_store
  (naie_engine_t* engine, uint32_t reg, uint32_t value)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/engine/naie_resobj_new.c */
extern
naio_resobj_t* naie_resobj_new
  (naie_engine_t* engine)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/engine/naie_result_cursor.c */
extern
NAIG_ERR_T naie_result_cursor
  (
    naio_result_t* result,
    naie_rescrs_t* cursor,
    unsigned index,
    int slot
  )
  __attribute__ ((warn_unused_result));

/* declared in ./lib/engine/naie_result_cursor_child.c */
extern
NAIG_ERR_T naie_result_cursor_child
  (
    naie_rescrs_t* cursor,
    int slot,
    naio_resact_t* action
  )
  __attribute__ ((warn_unused_result));

/* declared in ./lib/engine/naie_result_cursor_next.c */
extern
NAIG_ERR_T naie_result_cursor_next
  (
    naie_rescrs_t* cursor,
    int slot,
    naio_resact_t* action
  )
  __attribute__ ((warn_unused_result));

/* declared in ./lib/engine/naie_result_cursor_string.c */
extern
NAIG_ERR_T naie_result_cursor_string
  (naie_rescrs_t* cursor, char* input, char* buf, unsigned siz)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/engine/naie_result_debug.c */
extern
void naie_result_debug
  (naie_engine_t* engine);

/* declared in ./lib/engine/naie_result_fill.c */
extern
NAIG_ERR_T naie_result_fill
  (
    naie_engine_t* engine,
    naio_result_t* result
  )
  __attribute__ ((warn_unused_result));

/* declared in ./lib/engine/naie_result_free.c */
extern
void naie_result_free
  (naio_result_t* result);

/* declared in ./lib/engine/naie_result_handle.c */
extern
NAIG_ERR_T naie_result_handle
  (
    naie_engine_t* engine,
    naio_result_t* result,
    naie_capture_t capturefnc,
    naie_delete_t deletefnc,
    naie_insert_t insertfnc,
    void* arg
  )
  __attribute__ ((warn_unused_result));

/* declared in ./lib/engine/naie_result_query.c */
extern
NAIG_ERR_T naie_result_query
  (
    naio_result_t* result,
    unsigned* path,
    unsigned path_length,
    naio_resact_t* action
  )
  __attribute__ ((warn_unused_result));

/* declared in ./lib/engine/naie_result_query_scope.c */
extern
NAIG_ERR_T naie_result_query_scope
  (
    naio_result_t* result,
    unsigned result_index,
    unsigned result_scope,
    unsigned* path,
    unsigned path_length,
    unsigned path_index,
    naio_resact_t* action
  )
  __attribute__ ((warn_unused_result));

/* declared in ./lib/engine/naie_stack_call_size.c */
extern
unsigned naie_stack_call_size
  (naie_engine_t* engine)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/engine/naie_stack_peek.c */
extern
NAIG_ERR_T naie_stack_peek
  (naie_engine_t* engine, naie_stackentry_t** entry)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/engine/naie_stack_pop.c */
extern
NAIG_ERR_T naie_stack_pop
  (naie_engine_t* engine, naie_stackentry_t* entry)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/engine/naie_stack_push.c */
extern
NAIG_ERR_T naie_stack_push
  (
    naie_engine_t* engine,
    uint32_t type,
    uint32_t address,
    unsigned inputlen
  )
  __attribute__ ((warn_unused_result));

/* declared in ./lib/engine/naie_variable.c */
extern
NAIG_ERR_T naie_variable
  (
    naie_engine_t* engine,
    const unsigned char* data,
    uint32_t slot,
    unsigned char** value,
    unsigned* valuesize
  )
  __attribute__ ((warn_unused_result));



#endif