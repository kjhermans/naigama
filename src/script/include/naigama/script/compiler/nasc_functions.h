/**
* \file
* \brief This file is an autogenerated function prototypes header file.
*
* Copyright 2018 K.J. Hermans
* WARNING: This file is automatically generated. Any changes will be lost.
*/

#ifndef ___LIB_COMPILER_FUNCTIONS_H_
#define ___LIB_COMPILER_FUNCTIONS_H_

/* declared in ./lib/compiler/nasc_compile.c */
extern
NAIG_ERR_T nasc_compile
  (char* code, NAIG_ERR_T(*writer)(void*,char*,...), void* arg)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/compiler/nasc_process_function.c */
extern
NAIG_ERR_T nasc_process_function
  (
    nasc_t* nasc,
    naie_rescrs_t cursor,
    NAIG_ERR_T(*writer)(void*,char*,...),
    void* arg
  )
  __attribute__ ((warn_unused_result));

/* declared in ./lib/compiler/nasc_process_function_body.c */
extern
NAIG_ERR_T nasc_process_function_body
  (
    nasc_t* nasc,
    naie_rescrs_t cursor,
    NAIG_ERR_T(*writer)(void*,char*,...),
    void* arg
  )
  __attribute__ ((warn_unused_result));

/* declared in ./lib/compiler/nasc_process_function_params.c */
extern
NAIG_ERR_T nasc_process_function_params
  (
    nasc_t* nasc,
    naie_rescrs_t cursor,
    NAIG_ERR_T(*writer)(void*,char*,...),
    void* arg
  )
  __attribute__ ((warn_unused_result));

/* declared in ./lib/compiler/nasc_process_functions.c */
extern
NAIG_ERR_T nasc_process_functions
  (nasc_t* nasc, NAIG_ERR_T(*writer)(void*,char*,...), void* arg)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/compiler/nasc_process_if.c */
extern
NAIG_ERR_T nasc_process_if
  (
    nasc_t* nasc,
    naie_rescrs_t cursor,
    NAIG_ERR_T(*writer)(void*,char*,...),
    void* arg
  )
  __attribute__ ((warn_unused_result));

/* declared in ./lib/compiler/nasc_process_import.c */
extern
NAIG_ERR_T nasc_process_import
  (
    nasc_t* nasc,
    naie_rescrs_t* cursor,
    NAIG_ERR_T(*writer)(void*,char*,...),
    void* arg
  )
  __attribute__ ((warn_unused_result));

/* declared in ./lib/compiler/nasc_process_imports.c */
extern
NAIG_ERR_T nasc_process_imports
  (nasc_t* nasc, NAIG_ERR_T(*writer)(void*,char*,...), void* arg)
  __attribute__ ((warn_unused_result));

/* declared in ./lib/compiler/nasc_process_tokens.c */
extern
NAIG_ERR_T nasc_process_tokens
  (nasc_t* nasc, NAIG_ERR_T(*writer)(void*,char*,...), void* arg)
  __attribute__ ((warn_unused_result));



#endif