TARGET=naig
CC=$(ARCH)gcc
CFLAGS=-g -O2 -Wall -Wextra $(DEBUG) -I$(CURGEN)/include
LIBS=\
	$(CURGEN)/lib/compiler/libnaic.a \
	$(CURGEN)/lib/assembler/libnaia.a \
	$(CURGEN)/lib/engine/libnaie.a \
	$(CURGEN)/lib/disassembler/libnaid.a \
	$(CURGEN)/lib/memio/libnaio.a \
	$(CURGEN)/lib/naigama/libnaig.a \
	$(CURGEN)/lib/util/libutil.a \
	-lm

all: $(TARGET)

OBJECTS=naigama.o

$(TARGET): $(OBJECTS) $(LIBS)
	$(CC) -o $(TARGET) $(OBJECTS) $(LIBS)

clean:
	@rm -f $(TARGET) $(OBJECTS)

superclean: clean
