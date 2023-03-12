OBJECTS:=$(shell ls *.c | sort | sed -e 's/\.c$$/.o/')
LIB=libnaia.a
CC=$(ARCH)gcc
AR=$(ARCH)ar
CURGEN?=../..
CFLAGS=-g -Wall -Wextra $(DEBUG) -I$(CURGEN)/include

all: functionsheader $(LIB)

functionsheader: ../../include/naigama/assembler/naia_functions.h

../../include/naigama/assembler/naia_functions.h: *.c
	$(CURGEN)/bin/genfnchdr -t NAIG_ERR_T -i NAIA_FUNCTIONS . > \
	  ../../include/naigama/assembler/naia_functions.h

$(LIB): $(OBJECTS)
	$(AR) -rcs $(LIB) $(OBJECTS) ../parser/naip.o

clean:
	rm -f $(OBJECTS) $(LIB)

superclean: clean
