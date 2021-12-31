TARGET=naie
CC=$(ARCH)gcc
CFLAGS=-g -O2 -Wall -Wextra $(DEBUG) -I$(CURGEN)/include
LIBS=\
	$(CURGEN)/lib/engine/libnaie.a \
	$(CURGEN)/lib/util/libutil.a \
	$(CURGEN)/lib/memio/libnaio.a \
	$(CURGEN)/lib/naigama/libnaig.a \
	-lm

all: $(TARGET)

OBJECTS=engine.o engine_replace.o engine_debug.o engine_debug_fuzz.o engine_debug_report.o

$(TARGET): $(OBJECTS) $(LIBS)
	$(CC) -o $(TARGET) $(OBJECTS) $(LIBS)

clean:
	@rm -f $(TARGET) $(OBJECTS)

superclean: clean
