INCLUDE=$(NAIGROOT)/src/$(DEPGEN)/include
OBJECTS:=$(shell ls *.c | sort | sed -e 's/\.c$$/.o/')
LIB=libsqldb.a
CC=$(ARCH)gcc
AR=$(ARCH)ar
CFLAGS=-g -Wall -Wextra $(DEBUG) -I$(INCLUDE)

all: functionsh $(LIB)

functionsh: functions.h

functions.h: *.c
	$(NAIGROOT)/src/$(DEPGEN)/bin/genfnchdr . > functions.h

$(LIB): $(OBJECTS)
	$(AR) -rcs $(LIB) $(OBJECTS)

clean:
	@rm -f $(OBJECTS) $(LIB)

superclean: clean
