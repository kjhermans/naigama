CFILES:=$(shell find . -type f | grep '\.c$$')
OBJECTS:=$(shell find . -type f | grep '\.c$$' | sort | sed -e 's/\.c$$/.o/')
LIB=libnaig.a
CC=$(ARCH)gcc
AR=$(ARCH)ar
CFLAGS=-g -Wall -Wextra $(DEBUG) -I$(BUILDROOT)/src/gen1/include

all: $(LIB)

$(LIB): $(OBJECTS)
	$(AR) -rcs $(LIB) $(OBJECTS)
	$(BUILDROOT)/bin/arjoin.pl libnaigama.a \
		libnaig.a \
		$(BUILDROOT)/src/gen1/lib/engine/libnaie.a \
		$(BUILDROOT)/src/gen1/lib/compiler/libnaic.a \
		$(BUILDROOT)/src/gen1/lib/assembler/libnaia.a \
		$(BUILDROOT)/src/gen1/lib/disassembler/libnaid.a \
		$(BUILDROOT)/src/gen1/lib/util/libutil.a \

clean:
	@rm -f $(OBJECTS) $(LIB) libnaigama.a

superclean: clean
