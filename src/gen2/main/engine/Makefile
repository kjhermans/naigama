TARGET=naie
CC=$(ARCH)gcc
CFLAGS=-g -O2 -Wall -Wextra $(DEBUG) -I$(BUILDROOT)/src/gen2/include
LIBS=\
	$(BUILDROOT)/src/gen2/lib/engine/libnaie.a \
	$(BUILDROOT)/src/gen2/lib/util/libutil.a

all: $(TARGET)

OBJECTS=engine.o engine_replace.o engine_debug.o

$(TARGET): $(OBJECTS) $(LIBS)
	$(CC) -o $(TARGET) $(OBJECTS) $(LIBS)

clean:
	@rm -f $(TARGET) $(OBJECTS)

superclean: clean

$(BUILDROOT)/src/gen2/lib/engine/libnaie.a:
	@cd $(BUILDROOT)/src/gen2/lib/engine && make

$(BUILDROOT)/src/gen2/lib/util/libutil.a:
	@cd $(BUILDROOT)/src/gen2/lib/util && make
