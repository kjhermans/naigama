OBJECTS:=$(shell ls *.c firstpass/*.c rule/*.c namespace/*.c script/*.c | sort | sed -e 's/\.c$$/.o/')
LIB=libnaic.a
CC=$(ARCH)gcc
AR=$(ARCH)ar
CFLAGS=-g -Wall -Wextra $(DEBUG) -I$(CURGEN)/include

all: $(LIB)

$(LIB): $(OBJECTS)
	$(AR) -rcs $(LIB) $(OBJECTS)

clean:
	@rm -f $(OBJECTS) $(LIB)

superclean: clean
