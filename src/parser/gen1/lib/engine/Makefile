CFILES:=$(shell find . -type f | grep '\.c$$')
OBJECTS:=$(shell find . -type f | grep '\.c$$' | sort | sed -e 's/\.c$$/.o/')
LIB=libnaie.a
CC=$(ARCH)gcc
AR=$(ARCH)ar
CFLAGS=-g -Wall -Wextra $(DEBUG) -I$(BUILDROOT)/src/parser/include

all: $(LIB)

$(LIB): $(OBJECTS)
	$(AR) -rcs $(LIB) $(OBJECTS)

clean:
	@rm -f $(OBJECTS) $(LIB)

superclean: clean
