OBJECTS:=$(shell ls *.c | grep '\.c$$' | sort | sed -e 's/\.c$$/.o/')
LIB=libnaig.a
CC=$(ARCH)gcc
AR=$(ARCH)ar
CFLAGS=-g -Wall -Wextra $(DEBUG) -I$(BUILDROOT)/src/gen3/include

all: $(LIB)

$(LIB): $(OBJECTS)
	$(AR) -rcs $(LIB) $(OBJECTS)
	$(BUILDROOT)/bin/arjoin.pl libnaigama.a \
		libnaig.a \
		$(BUILDROOT)/src/gen3/lib/engine/libnaie.a \
		$(BUILDROOT)/src/gen3/lib/compiler/libnaic.a \
		$(BUILDROOT)/src/gen3/lib/assembler/libnaia.a \
		$(BUILDROOT)/src/gen3/lib/disassembler/libnaid.a \
		$(BUILDROOT)/src/gen3/lib/util/libutil.a \

clean:
	@rm -f $(OBJECTS) $(LIB) libnaigama.a

superclean: clean
