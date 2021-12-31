TARGET=naia
CC=$(ARCH)gcc
CFLAGS=-g -O2 -Wall -Wextra $(DEBUG) -I$(CURGEN)/include
LIBS=\
	$(CURGEN)/lib/assembler/libnaia.a \
	$(CURGEN)/lib/engine/libnaie.a \
	$(CURGEN)/lib/util/libutil.a \
	$(CURGEN)/lib/memio/libnaio.a \
	-lm

all: $(TARGET)

$(TARGET): assembler.o $(LIBS)
	$(CC) -o $(TARGET) assembler.o $(LIBS)

clean:
	@rm -f $(TARGET) assembler.o

superclean: clean

$(CURGEN)/lib/assembler/libnaia.a:
	@cd $(CURGEN)/lib/assembler && make

$(CURGEN)/lib/engine/libnaie.a:
	@cd $(CURGEN)/lib/engine && make

$(CURGEN)/lib/util/libutil.a:
	@cd $(CURGEN)/lib/util && make
