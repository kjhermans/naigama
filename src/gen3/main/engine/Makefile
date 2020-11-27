TARGET=naie
CC=$(ARCH)gcc
CFLAGS=-g -O2 -Wall -Wextra $(DEBUG) -I$(BUILDROOT)/src/gen3/include
LIBS=\
	$(BUILDROOT)/src/gen3/lib/engine/libnaie.a \
	$(BUILDROOT)/src/gen3/lib/naigama/libnaigama.a \
	$(BUILDROOT)/src/gen3/lib/util/libutil.a 

all: $(TARGET)

OBJECTS=engine.o engine_replace.o engine_debug.o engine_debug_fuzz.o

$(TARGET): $(OBJECTS) $(LIBS)
	$(CC) -o $(TARGET) $(OBJECTS) $(LIBS)

clean:
	@rm -f $(TARGET) $(OBJECTS)

superclean: clean

$(BUILDROOT)/src/gen3/lib/engine/libnaie.a:
	@cd $(BUILDROOT)/src/gen3/lib/engine && make

$(BUILDROOT)/src/gen3/lib/util/libutil.a:
	@cd $(BUILDROOT)/src/gen3/lib/util && make
