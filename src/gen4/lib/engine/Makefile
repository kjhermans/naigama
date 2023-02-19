OBJECTS:=$(shell ls *.c | sort | sed -e 's/\.c$$/.o/')
LIB=libnaie.a
CC=$(ARCH)gcc
AR=$(ARCH)ar
CURGEN?=../..
CFLAGS=-g -Wall -Wextra $(DEBUG) -I$(CURGEN)/include

all: functionsheader $(LIB)

functionsheader: ../../include/naigama/engine/naie_functions.h

../../include/naigama/engine/naie_functions.h: *.c
	$(CURGEN)/bin/genfnchdr -t NAIG_ERR_T -i NAIC_FUNCTIONS . > \
	  ../../include/naigama/engine/naie_functions.h

$(LIB): $(OBJECTS)
	$(AR) -rcs $(LIB) $(OBJECTS)

clean:
	@rm -f $(OBJECTS) $(LIB)

superclean: clean
