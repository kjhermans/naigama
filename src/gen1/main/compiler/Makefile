TARGET=naic
CC=$(ARCH)gcc
CFLAGS=-g -O2 -Wall -Wextra $(DEBUG) -I$(CURGEN)/include
LIBS=\
	$(CURGEN)/lib/compiler/libnaic.a \
	$(CURGEN)/lib/engine/libnaie.a \
	$(CURGEN)/lib/assembler/libnaia.a \
	$(CURGEN)/lib/util/libutil.a \

all: $(TARGET)

OBJECTS=compiler.o

$(TARGET): $(OBJECTS) $(LIBS)
	$(CC) -o $(TARGET) $(OBJECTS) $(LIBS)

clean:
	@rm -f $(TARGET) $(OBJECTS)

superclean: clean
