/**
* \file
* \brief This file is an autogenerated function prototypes header file.
*
* Copyright 2018 K.J. Hermans
* WARNING: This file is automatically generated. Any changes will be lost.
*/

#ifndef ____LIB_COMPILER__FUNCTIONS_H_
#define ____LIB_COMPILER__FUNCTIONS_H_

/* declared in ../lib/compiler//naic_compile.c */
extern
NAIG_ERR_T naic_compile
  (char* grammar, FILE* output, naic_slotmap_t* slots, int debug)
  __attribute__ ((warn_unused_result));

/* declared in ../lib/compiler//naic_debug.c */
extern
void naic_debug
  (naic_t* naic);

/* declared in ../lib/compiler//naic_process_any.c */
extern
NAIG_ERR_T naic_process_any
  (naic_t* naic)
  __attribute__ ((warn_unused_result));

/* declared in ../lib/compiler//naic_process_bitmask.c */
extern
NAIG_ERR_T naic_process_bitmask
  (naic_t* naic)
  __attribute__ ((warn_unused_result));

/* declared in ../lib/compiler//naic_process_capture.c */
extern
NAIG_ERR_T naic_process_capture
  (naic_t* naic)
  __attribute__ ((warn_unused_result));

/* declared in ../lib/compiler//naic_process_expression.c */
extern
NAIG_ERR_T naic_process_expression
  (naic_t* naic)
  __attribute__ ((warn_unused_result));

/* declared in ../lib/compiler//naic_process_group.c */
extern
NAIG_ERR_T naic_process_group
  (naic_t* naic)
  __attribute__ ((warn_unused_result));

/* declared in ../lib/compiler//naic_process_hexliteral.c */
extern
NAIG_ERR_T naic_process_hexliteral
  (naic_t* naic)
  __attribute__ ((warn_unused_result));

/* declared in ../lib/compiler//naic_process_macro.c */
extern
NAIG_ERR_T naic_process_macro
  (naic_t* naic)
  __attribute__ ((warn_unused_result));

/* declared in ../lib/compiler//naic_process_matcher.c */
extern
NAIG_ERR_T naic_process_matcher
  (naic_t* naic)
  __attribute__ ((warn_unused_result));

/* declared in ../lib/compiler//naic_process_reference.c */
extern
NAIG_ERR_T naic_process_reference
  (naic_t* naic)
  __attribute__ ((warn_unused_result));

/* declared in ../lib/compiler//naic_process_rule.c */
extern
NAIG_ERR_T naic_process_rule
  (naic_t* naic)
  __attribute__ ((warn_unused_result));

/* declared in ../lib/compiler//naic_process_set.c */
extern
NAIG_ERR_T naic_process_set
  (naic_t* naic)
  __attribute__ ((warn_unused_result));

/* declared in ../lib/compiler//naic_process_string.c */
extern
NAIG_ERR_T naic_process_string
  (naic_t* naic)
  __attribute__ ((warn_unused_result));

/* declared in ../lib/compiler//naic_process_string_caseinsensitive.c */
extern
NAIG_ERR_T naic_process_string_caseinsensitive
  (naic_t* naic)
  __attribute__ ((warn_unused_result));

/* declared in ../lib/compiler//naic_process_term.c */
extern
NAIG_ERR_T naic_process_term
  (naic_t* naic)
  __attribute__ ((warn_unused_result));

/* declared in ../lib/compiler//naic_process_term_get_quantifier.c */
extern
NAIG_ERR_T naic_process_term_get_quantifier
  (naic_t* naic, unsigned end, int quantifier[ 2 ])
  __attribute__ ((warn_unused_result));

/* declared in ../lib/compiler//naic_process_terms.c */
extern
NAIG_ERR_T naic_process_terms
  (naic_t* naic)
  __attribute__ ((warn_unused_result));

/* declared in ../lib/compiler//naic_process_terms_or_expression.c */
extern
NAIG_ERR_T naic_process_terms_or_expression
  (naic_t* naic)
  __attribute__ ((warn_unused_result));

/* declared in ../lib/compiler//naic_process_terms_or_nothing.c */
extern
NAIG_ERR_T naic_process_terms_or_nothing
  (naic_t* naic)
  __attribute__ ((warn_unused_result));

/* declared in ../lib/compiler//naic_process_tokens.c */
extern
NAIG_ERR_T naic_process_tokens
  (char* grammar, naie_result_t* captures, FILE* output, naic_slotmap_t* slots)
  __attribute__ ((warn_unused_result));

/* declared in ../lib/compiler//naic_process_varcapture.c */
extern
NAIG_ERR_T naic_process_varcapture
  (naic_t* naic)
  __attribute__ ((warn_unused_result));

/* declared in ../lib/compiler//naic_process_varreference.c */
extern
NAIG_ERR_T naic_process_varreference
  (naic_t* naic)
  __attribute__ ((warn_unused_result));

/* declared in ../lib/compiler//naic_slotmap_add.c */
extern
NAIG_ERR_T naic_slotmap_add
  (
    naic_slotmap_t* slotmap,
    char* grammar,
    naie_resact_t* rule,
    naie_resact_t* capture,
    unsigned slot
  )
  __attribute__ ((warn_unused_result));

/* declared in ../lib/compiler//naic_slotmap_string.c */
extern
char* naic_slotmap_string
  (unsigned slot)
  __attribute__ ((warn_unused_result));

/* declared in ../lib/compiler//naic_slotmap_write.c */
extern
NAIG_ERR_T naic_slotmap_write
  (naic_slotmap_t* slotmap, FILE* out)
  __attribute__ ((warn_unused_result));

/* declared in ../lib/compiler//naic_string_unescape.c */
extern
NAIG_ERR_T naic_string_unescape
  (
    naic_t* naic,
    unsigned start,
    unsigned stop,
    NAIG_ERR_T(*fnc)(naic_t*,unsigned)
  )
  __attribute__ ((warn_unused_result));

/* declared in ../lib/compiler//naic_token_first_child.c */
extern
NAIG_ERR_T naic_token_first_child
  (naic_t* naic, unsigned* index)
  __attribute__ ((warn_unused_result));

/* declared in ../lib/compiler//naic_token_is_child.c */
extern
int naic_token_is_child
  (naic_t* naic, unsigned index)
  __attribute__ ((warn_unused_result));

/* declared in ../lib/compiler//naic_token_next_sibling.c */
extern
NAIG_ERR_T naic_token_next_sibling
  (naic_t* naic, unsigned* index)
  __attribute__ ((warn_unused_result));

/* declared in ../lib/compiler//naic_var_get.c */
extern
NAIG_ERR_T naic_var_get
  (naic_t* naic, char* str, unsigned len, unsigned* slot)
  __attribute__ ((warn_unused_result));

/* declared in ../lib/compiler//naic_var_put.c */
extern
NAIG_ERR_T naic_var_put
  (naic_t* naic, char* str, unsigned len, unsigned slot)
  __attribute__ ((warn_unused_result));



#endif