#ifndef _NAIC_DEFINES_H_
#define _NAIC_DEFINES_H_

#define NAIC_RULEVARMAP_SIZE    32
#define NAIC_SLOTMAP_SIZE       512

#define NAIC_NOTFOUND           (NAIG_ERR_T){ .code = 257 }
#define NAIC_ERR_TOKEN          (NAIG_ERR_T){ .code = 258 }
#define NAIC_ERR_QUANTIFIER     (NAIG_ERR_T){ .code = 259 }
#define NAIC_ERR_MACRO          (NAIG_ERR_T){ .code = 260 }
#define NAIC_ERR_VARMAPFULL     (NAIG_ERR_T){ .code = 261 }
#define NAIC_ERR_VARDOUBLE      (NAIG_ERR_T){ .code = 262 }
#define NAIC_ERR_SLOTMAPFULL    (NAIG_ERR_T){ .code = 263 }

#define NAIC_SET_BIT_SET(set,bit) {set[bit/8]|=(1<<(bit%8));}

#define NAIC_FLG_FIRSTRULE      (1<<0)
#define NAIC_FLG_IMPLICITPREFIX (1<<1)

#endif
