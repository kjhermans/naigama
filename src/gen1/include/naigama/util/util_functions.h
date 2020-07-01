/**
* \file
* \brief This file is an autogenerated function prototypes header file.
*
* Copyright 2018 K.J. Hermans
* WARNING: This file is automatically generated. Any changes will be lost.
*/

#ifndef __HOME_WORK_WORK_NAIGAMA_SRC_GEN1_LIB_UTIL__FUNCTIONS_H_
#define __HOME_WORK_WORK_NAIGAMA_SRC_GEN1_LIB_UTIL__FUNCTIONS_H_

/* declared in /home/work/work/naigama/src/gen1/lib/util//absorb_file.c */
extern
int absorb_file
  (char* path, unsigned char** buf, unsigned* buflen)
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen1/lib/util//atoi_substr.c */
extern
unsigned atoi_substr
  (char* str, unsigned offset, unsigned len)
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen1/lib/util//cmp_substr.c */
extern
int cmp_substr
  (char* mem, unsigned len, char* cmp)
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen1/lib/util//hexcodon.c */
extern
unsigned hexcodon
  (unsigned high, unsigned low)
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen1/lib/util//logmem.c */
extern
void logmem
  (void* _mem, unsigned int size);

/* declared in /home/work/work/naigama/src/gen1/lib/util//octal.c */
extern
unsigned octal
  (unsigned c1, unsigned c2, unsigned c3)
  __attribute__ ((warn_unused_result));

/* declared in /home/work/work/naigama/src/gen1/lib/util//strxypos.c */
extern
int strxypos
  (char* string, unsigned pos, unsigned vector[ 2 ])
  __attribute__ ((warn_unused_result));



#endif