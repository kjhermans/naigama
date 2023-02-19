TARGET=nais
CC=$(ARCH)gcc
CFLAGS=-g -O2 -Wall -Wextra $(DEBUG) -I$(CURGEN)/include
LIBS=\
	$(CURGEN)/lib/service/libnais.a \
	$(CURGEN)/lib/compiler/libnaic.a \
	$(CURGEN)/lib/engine/libnaie.a \
	$(CURGEN)/lib/assembler/libnaia.a \
	$(CURGEN)/lib/util/libutil.a \
	$(CURGEN)/lib/memio/libnaio.a \
	$(CURGEN)/lib/naigama/libnaig.a \
	-lm

all: $(TARGET)

OBJECTS=service.o

$(TARGET): $(OBJECTS) $(LIBS)
	$(CC) -o $(TARGET) $(OBJECTS) $(LIBS)

clean:
	@rm -f $(TARGET) $(OBJECTS)

superclean: clean
