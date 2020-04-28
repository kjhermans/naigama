CFILES:=$(shell find . -type f | grep '\.c$$')
OBJECTS:=$(shell find . -type f | grep '\.c$$' | sort | sed -e 's/\.c$$/.o/')
LIB=libnaig.a
CC=$(ARCH)gcc
AR=$(ARCH)ar
CFLAGS=-g -Wall -Wextra $(DEBUG) -I../../include

all: $(LIB)

$(LIB): $(OBJECTS)
	$(AR) -rcs $(LIB) $(OBJECTS)
	../../../bin/arjoin.pl libnaigama.a \
		libnaig.a \
		../engine/libnaie.a \
		../compiler/libnaic.a \
		../assembler/libnaia.a \
		../util/libutil.a \

clean:
	@rm -f $(OBJECTS) $(LIB) libnaigama.a

superclean: clean
