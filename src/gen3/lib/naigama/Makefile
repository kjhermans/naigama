OBJECTS:=$(shell ls *.c | sort | sed -e 's/\.c$$/.o/')
LIB=libnaig.a
CC=$(ARCH)gcc
AR=$(ARCH)ar
CFLAGS=-g -Wall -Wextra $(DEBUG) -I$(CURGEN)/include

all: $(LIB) biglib

$(LIB): $(OBJECTS)
	$(AR) -rcs $(LIB) $(OBJECTS)

biglib:
	../../bin/arjoin libnaigama.a \
	  ../util/libutil.a \
	  ../memio/libnaio.a \
	  ../compiler/libnaic.a \
	  ../assembler/libnaia.a \
	  ../disassembler/libnaid.a \
	  ../engine/libnaie.a \
	  ../naigama/libnaig.a

clean:
	@rm -f $(OBJECTS) $(LIB) libnaigama.a

superclean: clean
