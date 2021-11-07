/**
* \file
* \brief This file is an autogenerated function prototypes header file.
*
* Copyright 2018 K.J. Hermans
* WARNING: This file is automatically generated. Any changes will be lost.
*/

#ifndef ___LIB_ASSEMBLER_FUNCTIONS_H_
#define ___LIB_ASSEMBLER_FUNCTIONS_H_

/* declared in ./lib/assembler/naia_assemble.c */
extern
NAIG_ERR_T naia_assemble
  (
    char* assembly,
    FILE* labelmap,
    int debug,
    NAIG_ERR_T(*naia_write)(void* ptr, unsigned size, void* arg),
    void* arg
  )
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_instruction_length.c */
extern
uint32_t naia_instruction_opcode
  (naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_instruction_length.c */
extern
unsigned naia_instruction_length
  (naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_backcommit.c */
extern
NAIG_ERR_T naia_process_backcommit
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_call.c */
extern
NAIG_ERR_T naia_process_call
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_catch.c */
extern
NAIG_ERR_T naia_process_catch
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_char.c */
extern
NAIG_ERR_T naia_process_char
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_closecapture.c */
extern
NAIG_ERR_T naia_process_closecapture
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_commit.c */
extern
NAIG_ERR_T naia_process_commit
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_condjump.c */
extern
NAIG_ERR_T naia_process_condjump
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_counter.c */
extern
NAIG_ERR_T naia_process_counter
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_end.c */
extern
NAIG_ERR_T naia_process_end
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_instructions.c */
extern
NAIG_ERR_T naia_process_instructions
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_intrpcapture.c */
extern
NAIG_ERR_T naia_process_intrpcapture
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_isolate.c */
extern
NAIG_ERR_T naia_process_isolate
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_jump.c */
extern
NAIG_ERR_T naia_process_jump
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_labels.c */
extern
NAIG_ERR_T naia_process_labels
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_maskedchar.c */
extern
NAIG_ERR_T naia_process_maskedchar
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_mode.c */
extern
NAIG_ERR_T naia_process_mode
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_opencapture.c */
extern
NAIG_ERR_T naia_process_opencapture
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_partialcommit.c */
extern
NAIG_ERR_T naia_process_partialcommit
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_quad.c */
extern
NAIG_ERR_T naia_process_quad
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_replace.c */
extern
NAIG_ERR_T naia_process_replace
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_scr_builtin.c */
extern
NAIG_ERR_T naia_process_scr_builtin
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_scr_call.c */
extern
NAIG_ERR_T naia_process_scr_call
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_scr_condjump.c */
extern
NAIG_ERR_T naia_process_scr_condjump
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_scr_push.c */
extern
NAIG_ERR_T naia_process_scr_push
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_scr_shift.c */
extern
NAIG_ERR_T naia_process_scr_shift
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_scr_string.c */
extern
NAIG_ERR_T naia_process_scr_string
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_set.c */
extern
NAIG_ERR_T naia_process_set
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_single.c */
extern
NAIG_ERR_T naia_process_single
  (naia_t* naia, unsigned o)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_skip.c */
extern
NAIG_ERR_T naia_process_skip
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_span.c */
extern
NAIG_ERR_T naia_process_span
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_testany.c */
extern
NAIG_ERR_T naia_process_testany
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_testchar.c */
extern
NAIG_ERR_T naia_process_testchar
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_testquad.c */
extern
NAIG_ERR_T naia_process_testquad
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_testset.c */
extern
NAIG_ERR_T naia_process_testset
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_tokens.c */
extern
NAIG_ERR_T naia_process_tokens
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_process_var.c */
extern
NAIG_ERR_T naia_process_var
  (naia_t* naia, naio_resobj_t* object)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/assembler/naia_slotmap_string.c */
extern
char* naia_slotmap_string
  (unsigned slot)
  __attribute__ ((warn_unused_result));



#endif