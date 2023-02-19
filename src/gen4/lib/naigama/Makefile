OBJECTS:=$(shell ls *.c | sort | sed -e 's/\.c$$/.o/')
LIB=libnaig.a
CC=$(ARCH)gcc
AR=$(ARCH)ar
CURGEN?=../..
CFLAGS=-g -Wall -Wextra $(DEBUG) -I$(CURGEN)/include

all: functionsheader $(LIB)

functionsheader: ../../include/naigama/naigama/naig_functions.h

../../include/naigama/naigama/naig_functions.h: *.c
	$(CURGEN)/bin/genfnchdr -t NAIG_ERR_T -t naig_resobj_t -i NAIG_FUNCTIONS . > \
	  ../../include/naigama/naigama/naig_functions.h

$(LIB): $(OBJECTS)
	$(AR) -rcs $(LIB) $(OBJECTS)

clean:
	rm -f $(OBJECTS) $(LIB)

superclean: clean
	rm -f ../../include/naigama/naigama/naig_functions.h
