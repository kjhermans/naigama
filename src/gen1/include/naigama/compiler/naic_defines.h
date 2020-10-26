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
#define NAIC_ERR_NAMESPACE      (NAIG_ERR_T){ .code = 264 }
#define NAIC_ERR_TYPE           (NAIG_ERR_T){ .code = 265 }

#define NAIC_SET_BIT_SET(set,bit) {set[bit/8]|=(1<<(bit%8));}

#define NAIC_FLG_FIRSTRULE      (1<<0)
#define NAIC_FLG_IMPLICITPREFIX (1<<1)
#define NAIC_FLG_TRAPS          (1<<2)
#define NAIC_FLG_TERSE          (1<<3)
#define NAIC_FLG_DEBUG          (1<<4)
#define NAIC_FLG_LOOPS          (1<<5)

#define NAIC_WRITE(...) CHECK(naic->write(naic->write_arg, __VA_ARGS__))

#endif
