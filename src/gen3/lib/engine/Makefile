CFILES:=$(shell find . -type l | grep '\.c$$')
OBJECTS:=$(shell find . -type l | grep '\.c$$' | sort | sed -e 's/\.c$$/.o/')
LIB=libnaie.a
CC=$(ARCH)gcc
AR=$(ARCH)ar
CFLAGS=-g -Wall -Wextra $(DEBUG) -I$(BUILDROOT)/src/gen3/include

all: $(LIB)

$(LIB): $(OBJECTS)
	$(AR) -rcs $(LIB) $(OBJECTS)

clean:
	@rm -f $(OBJECTS) $(LIB)

superclean: clean
