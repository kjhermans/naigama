#ifndef _NAIC_DEFINES_H_
#define _NAIC_DEFINES_H_

#define NAIC_RULEVARMAP_SIZE    32
#define NAIC_SLOTMAP_SIZE       512

#define NAIC_SET_BIT_SET(set,bit) {set[bit/8]|=(1<<(bit%8));}

#define NAIC_FLG_FIRSTRULE      (1<<0)
#define NAIC_FLG_IMPLICITPREFIX (1<<1)
#define NAIC_FLG_TRAPS          (1<<2)
#define NAIC_FLG_TERSE          (1<<3)
#define NAIC_FLG_DEBUG          (1<<4)
#define NAIC_FLG_LOOPS          (1<<5)
#define NAIC_FLG_TRADITIONAL    (1<<6)
#define NAIC_FLG_DEFAULTCAPTURE (1<<7)

#define NAIC_WRITE(...) CHECK(naio_buf_write_string(naic->current_buffer, __VA_ARGS__))
#define NAIC_RESERVE(...) CHECK(naic_reserve(naic, __VA_ARGS__))

#endif
