/**
* \file
* \brief This file is an autogenerated function prototypes header file.
*
* Copyright 2018 K.J. Hermans
* WARNING: This file is automatically generated. Any changes will be lost.
*/

#ifndef _NAIC_FUNCTIONS_FUNCTIONS_H_
#define _NAIC_FUNCTIONS_FUNCTIONS_H_

/* declared in ./naie_actions.c */
extern
void naie_actionlist_debug
  (naie_actionlist_t* list);

/* declared in ./naie_ec_init.c */
extern
NAIG_ERR_T naie_ec_init
  (naie_ec_t* ec, unsigned char* input, unsigned input_length)
  __attribute__ ((warn_unused_result));

/* declared in ./naie_init.c */
extern
NAIG_ERR_T naie_init
  (naie_t* naie, unsigned char* bytecode, unsigned bytecode_length)
  __attribute__ ((warn_unused_result));

/* declared in ./naie_run.c */
extern
NAIG_ERR_T naie_run
  (naie_t* naie, naie_ec_t* ec)
  __attribute__ ((warn_unused_result));

/* declared in ./naie_stack.c */
extern
void naie_stack_get_furthest
  (naie_stack_t* stack, unsigned* index, naie_stackelt_t* elt);

/* declared in ./naie_variable.c */
extern
NAIG_ERR_T naie_variable
  (
    naie_t* naie,
    naie_ec_t* ec,
    uint32_t slot,
    unsigned char** value,
    unsigned* valuesize
  )
  __attribute__ ((warn_unused_result));



#endif