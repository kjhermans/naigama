/**
* \file
* \brief This file is an autogenerated function prototypes header file.
*
* Copyright 2018 K.J. Hermans
* WARNING: This file is automatically generated. Any changes will be lost.
*/

#ifndef __HOME_WORK_WORK_NAIGAMA_SRC_GEN3_LIB_ENGINE__FUNCTIONS_H_
#define __HOME_WORK_WORK_NAIGAMA_SRC_GEN3_LIB_ENGINE__FUNCTIONS_H_

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_action_push.c */
extern
NAIG_ERR_T naie_action_push
  (naie_engine_t* engine, naie_action_t action)
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_debug_actions.c */
extern
void naie_debug_actions
  (naie_engine_t* engine);

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_debug_instruction.c */
extern
void naie_debug_instruction
  (naie_engine_t* engine);

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_debug_state.c */
extern
void naie_debug_state
  (naie_engine_t* engine, int full);

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_engine_add_label.c */
extern
NAIG_ERR_T naie_engine_add_label
  (naie_engine_t* engine, char* string, uint32_t offset)
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_engine_call.c */
extern
NAIG_ERR_T naie_engine_call
  (
    naie_engine_t* engine,
    char* label,
    naie_result_t* result
  )
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_engine_call_offset.c */
extern
NAIG_ERR_T naie_engine_call_offset
  (
    naie_engine_t* engine,
    uint32_t offset,
    naie_result_t* result
  )
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_engine_endless_loop.c */
extern
NAIG_ERR_T naie_engine_endless_loop
  (naie_engine_t* engine)
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_engine_init.c */
extern
NAIG_ERR_T naie_engine_init
  (
    naie_engine_t* engine,
    const unsigned char* bytecode,
    unsigned bytecode_length,
    const unsigned char* input,
    unsigned input_length
  )
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_engine_loop.c */
extern
NAIG_ERR_T naie_engine_loop
  (
    naie_engine_t* engine,
    naie_result_t* result
  )
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_engine_loop_function.c */
extern
NAIG_ERR_T naie_engine_loop_function
  (naie_engine_t* engine)
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_engine_loop_replace.c */
extern
NAIG_ERR_T naie_engine_loop_replace
  (
    naie_engine_t* engine,
    uint32_t slot
  )
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_engine_run.c */
extern
NAIG_ERR_T naie_engine_run
  (
    naie_engine_t* engine,
    naie_result_t* result
  )
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_fstack_pop.c */
extern
NAIG_ERR_T naie_fstack_pop
  (naie_scalar_stack_t* stack, naie_scalar_t* scalar)
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_fstack_push.c */
extern
NAIG_ERR_T naie_fstack_push
  (naie_scalar_stack_t* stack, naie_scalar_t scalar)
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_instr_string.c */
extern
char* naie_instr_string
  (uint32_t opcode)
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_labelmap_get.c */
extern
NAIG_ERR_T naie_labelmap_get
  (
    naie_engine_t* engine,
    char* label,
    uint32_t* offset
  )
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_labelmap_reverse.c */
extern
char* naie_labelmap_reverse
  (
    naie_engine_t* engine,
    uint32_t offset
  )
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_output.c */
extern
NAIG_ERR_T naie_output
  (naie_result_t* result, FILE* output)
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_register_retrieve.c */
extern
NAIG_ERR_T naie_register_retrieve
  (naie_engine_t* engine, uint32_t reg, uint32_t* value)
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_register_store.c */
extern
NAIG_ERR_T naie_register_store
  (naie_engine_t* engine, uint32_t reg, uint32_t value)
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_result_cursor.c */
extern
NAIG_ERR_T naie_result_cursor
  (
    naie_result_t* result,
    naie_rescrs_t* cursor,
    unsigned index,
    int slot
  )
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_result_cursor_child.c */
extern
NAIG_ERR_T naie_result_cursor_child
  (
    naie_rescrs_t* cursor,
    int slot,
    naie_resact_t* action
  )
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_result_cursor_next.c */
extern
NAIG_ERR_T naie_result_cursor_next
  (
    naie_rescrs_t* cursor,
    int slot,
    naie_resact_t* action
  )
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_result_cursor_string.c */
extern
NAIG_ERR_T naie_result_cursor_string
  (naie_rescrs_t* cursor, char* input, char* buf, unsigned siz)
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_result_debug.c */
extern
void naie_result_debug
  (naie_result_t* result, unsigned char* data);

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_result_fill.c */
extern
NAIG_ERR_T naie_result_fill
  (
    naie_engine_t* engine,
    naie_result_t* result
  )
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_result_handle.c */
extern
NAIG_ERR_T naie_result_handle
  (
    naie_engine_t* engine,
    naie_result_t* result,
    naie_capture_t capturefnc,
    naie_delete_t deletefnc,
    naie_insert_t insertfnc,
    void* arg
  )
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_result_object.c */
extern
naie_resobj_t* naie_result_object
  (
    naie_engine_t* engine,
    naie_result_t* result
  )
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_result_object_debug.c */
extern
void naie_result_object_debug_
  (naie_resobj_t* object, unsigned indent);

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_result_object_debug.c */
extern
void naie_result_object_debug
  (naie_resobj_t* object);

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_result_object_free.c */
extern
void naie_result_object_free
  (naie_resobj_t* object);

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_result_query.c */
extern
NAIG_ERR_T naie_result_query
  (
    naie_result_t* result,
    unsigned* path,
    unsigned path_length,
    naie_resact_t* action
  )
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_result_query_scope.c */
extern
NAIG_ERR_T naie_result_query_scope
  (
    naie_result_t* result,
    unsigned result_index,
    unsigned result_scope,
    unsigned* path,
    unsigned path_length,
    unsigned path_index,
    naie_resact_t* action
  )
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_scalar_add.c */
extern
NAIG_ERR_T naie_scalar_add
  (naie_scalar_t s1, naie_scalar_t s2, naie_scalar_t* result)
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_set_labelmap.c */
extern
NAIG_ERR_T naie_set_labelmap
  (
    naie_engine_t* engine,
    const char* filename
  )
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_stack_call_size.c */
extern
unsigned naie_stack_call_size
  (naie_engine_t* engine)
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_stack_peek.c */
extern
NAIG_ERR_T naie_stack_peek
  (naie_engine_t* engine, naie_stackentry_t** entry)
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_stack_pop.c */
extern
NAIG_ERR_T naie_stack_pop
  (naie_engine_t* engine, naie_stackentry_t* entry)
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_stack_push.c */
extern
NAIG_ERR_T naie_stack_push
  (
    naie_engine_t* engine,
    uint32_t type,
    uint32_t address
  )
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/engine//naie_variable.c */
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