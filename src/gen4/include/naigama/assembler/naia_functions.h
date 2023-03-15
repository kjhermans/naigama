/**
* \file
* \brief This file is an autogenerated function prototypes header file.
*
* Copyright 2018 K.J. Hermans
* WARNING: This file is automatically generated. Any changes will be lost.
*/

#ifndef _NAIA_FUNCTIONS_FUNCTIONS_H_
#define _NAIA_FUNCTIONS_FUNCTIONS_H_

/* declared in ./naia_assemble.c */
extern
NAIG_ERR_T naia_assemble
  (naia_t* naia, char* path)
  __attribute__ ((warn_unused_result));

/* declared in ./naia_fp.c */
extern
NAIG_ERR_T naia_fp
  (naia_t* naia, naig_resobj_t* obj)
  __attribute__ ((warn_unused_result));

/* declared in ./naia_fp_instruction.c */
extern
NAIG_ERR_T naia_fp_instruction
  (naia_t* naia, naig_resobj_t* obj)
  __attribute__ ((warn_unused_result));

/* declared in ./naia_fp_labeldef.c */
extern
NAIG_ERR_T naia_fp_labeldef
  (naia_t* naia, naig_resobj_t* obj)
  __attribute__ ((warn_unused_result));

/* declared in ./naia_fp_namespace.c */
extern
NAIG_ERR_T naia_fp_namespace
  (naia_t* naia, naig_resobj_t* obj)
  __attribute__ ((warn_unused_result));

/* declared in ./naia_labelmap_write.c */
extern
NAIG_ERR_T naia_labelmap_write
  (naia_t* naia, char* path)
  __attribute__ ((warn_unused_result));

/* declared in ./naia_slot2opcode.c */
extern
NAIG_ERR_T naia_slot2opcode
  (unsigned slot, uint32_t* opcode)
  __attribute__ ((warn_unused_result));

/* declared in ./naia_sp.c */
extern
NAIG_ERR_T naia_sp
  (naia_t* naia, naig_resobj_t* obj)
  __attribute__ ((warn_unused_result));

/* declared in ./naia_sp_instruction.c */
extern
NAIG_ERR_T naia_sp_instruction
  (naia_t* naia, naig_resobj_t* obj)
  __attribute__ ((warn_unused_result));

/* declared in ./naia_sp_instruction_char.c */
extern
NAIG_ERR_T naia_sp_instruction_char
  (naia_t* naia, char* string)
  __attribute__ ((warn_unused_result));

/* declared in ./naia_sp_instruction_decimal.c */
extern
NAIG_ERR_T naia_sp_instruction_decimal
  (naia_t* naia, char* numberstring)
  __attribute__ ((warn_unused_result));

/* declared in ./naia_sp_instruction_double_decimal.c */
extern
NAIG_ERR_T naia_sp_instruction_double_decimal
  (naia_t* naia, uint32_t opcode, char* numberstring)
  __attribute__ ((warn_unused_result));

/* declared in ./naia_sp_instruction_double_labeled.c */
extern
NAIG_ERR_T naia_sp_instruction_double_labeled
  (naia_t* naia, uint32_t opcode, char* label)
  __attribute__ ((warn_unused_result));

/* declared in ./naia_sp_instruction_hexadecimal.c */
extern
NAIG_ERR_T naia_sp_instruction_hexadecimal
  (naia_t* naia, char* string)
  __attribute__ ((warn_unused_result));

/* declared in ./naia_sp_instruction_labeled.c */
extern
NAIG_ERR_T naia_sp_instruction_labeled
  (naia_t* naia, uint32_t opcode, char* label)
  __attribute__ ((warn_unused_result));

/* declared in ./naia_sp_instruction_maskedchar.c */
extern
NAIG_ERR_T naia_sp_instruction_maskedchar
  (naia_t* naia, char* hex1, char* hex2)
  __attribute__ ((warn_unused_result));

/* declared in ./naia_sp_instruction_quad.c */
extern
NAIG_ERR_T naia_sp_instruction_quad
  (naia_t* naia, char* string)
  __attribute__ ((warn_unused_result));

/* declared in ./naia_sp_instruction_set.c */
extern
NAIG_ERR_T naia_sp_instruction_set
  (naia_t* naia, uint32_t opcode, char* string)
  __attribute__ ((warn_unused_result));

/* declared in ./naia_sp_instruction_single.c */
extern
NAIG_ERR_T naia_sp_instruction_single
  (naia_t* naia, uint32_t opcode)
  __attribute__ ((warn_unused_result));

/* declared in ./naia_sp_instruction_triple_decimal.c */
extern
NAIG_ERR_T naia_sp_instruction_triple_decimal
  (naia_t* naia, uint32_t opcode, char* num1string, char* num2string)
  __attribute__ ((warn_unused_result));

/* declared in ./naia_sp_instruction_triple_decimal_label.c */
extern
NAIG_ERR_T naia_sp_instruction_triple_decimal_label
  (naia_t* naia, uint32_t opcode, char* numstring, char* label)
  __attribute__ ((warn_unused_result));



#endif