CFILES:=$(shell ls *.c')
OBJECTS:=$(shell ls *.c | sort | sed -e 's/\.c$$/.o/')
LIB=libnaia.a
CC=$(ARCH)gcc
AR=$(ARCH)ar
CFLAGS=-g -Wall -Wextra $(DEBUG) -I$(BUILDROOT)/src/gen3/include

all: $(LIB)

$(LIB): $(OBJECTS)
	$(AR) -rcs $(LIB) $(OBJECTS)

clean:
	@rm -f $(OBJECTS) $(LIB)

superclean: clean
