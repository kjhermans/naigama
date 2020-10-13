/**
* \file
* \brief This file is an autogenerated function prototypes header file.
*
* Copyright 2018 K.J. Hermans
* WARNING: This file is automatically generated. Any changes will be lost.
*/

#ifndef __HOME_WORK_WORK_NAIGAMA_SRC_GEN3_LIB_COMPILER__FUNCTIONS_H_
#define __HOME_WORK_WORK_NAIGAMA_SRC_GEN3_LIB_COMPILER__FUNCTIONS_H_

/* declared in /home/work/work/naigama/src/gen3/lib/compiler//naic_compile.c */
extern
NAIG_ERR_T naic_compile
  (
    char* grammar,
    naic_slotmap_t* slots,
    unsigned flags,
    NAIG_ERR_T(*fnc)(void*,char*,...),
    void* arg
  )
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/compiler//naic_compile_expr.c */
extern
NAIG_ERR_T naic_compile_expr
  (naic_t* naic, naie_resobj_t* expr)
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/compiler//naic_compile_expr_call.c */
extern
NAIG_ERR_T naic_compile_expr_call
  (naic_t* naic, naie_resobj_t* stmt)
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/compiler//naic_compile_expr_literal.c */
extern
NAIG_ERR_T naic_compile_expr_literal
  (naic_t* naic, naie_resobj_t* lit)
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/compiler//naic_compile_expr_reference.c */
extern
NAIG_ERR_T naic_compile_expr_reference
  (naic_t* naic, naie_resobj_t* lit)
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/compiler//naic_compile_function.c */
extern
NAIG_ERR_T naic_compile_function
  (naic_t* naic, naie_resobj_t* func)
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/compiler//naic_compile_function_body.c */
extern
NAIG_ERR_T naic_compile_function_body
  (naic_t* naic, naie_resobj_t* body)
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/compiler//naic_compile_function_stmt.c */
extern
NAIG_ERR_T naic_compile_function_stmt
  (naic_t* naic, naie_resobj_t* stmt)
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/compiler//naic_compile_rule.c */
extern
NAIG_ERR_T naic_compile_rule
  (naic_t* naic, naie_resobj_t* top)
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/compiler//naic_compile_top.c */
extern
NAIG_ERR_T naic_compile_top
  (naic_t* naic, naie_resobj_t* top)
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/compiler//naic_slotmap_write.c */
extern
NAIG_ERR_T naic_slotmap_write
  (naic_slotmap_t* slotmap, FILE* out)
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen3/lib/compiler//naic_slotmap_write_h.c */
extern
NAIG_ERR_T naic_slotmap_write_h
  (naic_slotmap_t* slotmap, FILE* out)
  __attribute__ ((warn_unused_result));



#endif