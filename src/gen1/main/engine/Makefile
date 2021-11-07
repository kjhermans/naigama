TARGET=naie
CC=$(ARCH)gcc
CFLAGS=-g -O2 -Wall -Wextra $(DEBUG) -I../../include
LIBS=\
	../../lib/engine/libnaie.a \
	../../lib/util/libutil.a \

all: $(TARGET)

OBJECTS=engine.o engine_replace.o engine_debug.o engine_debug_fuzz.o

$(TARGET): $(OBJECTS) $(LIBS)
	$(CC) -o $(TARGET) $(OBJECTS) $(LIBS)

clean:
	@rm -f $(TARGET) $(OBJECTS)

superclean: clean
