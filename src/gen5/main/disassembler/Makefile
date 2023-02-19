TARGET=naid
CC=$(ARCH)gcc
CFLAGS=-g -O2 -Wall -Wextra $(DEBUG) -I$(CURGEN)/include
LIBS=\
	$(CURGEN)/lib/disassembler/libnaid.a \
	$(CURGEN)/lib/engine/libnaie.a \
	$(CURGEN)/lib/util/libutil.a

all: $(TARGET)

$(TARGET): disassembler.o $(LIBS)
	$(CC) -o $(TARGET) disassembler.o $(LIBS)

clean:
	@rm -f $(TARGET) disassembler.o

superclean: clean

$(CURGEN)/lib/disassembler/libnaid.a:
	@cd $(CURGEN)/lib/disassembler && make

$(CURGEN)/lib/engine/libnaie.a:
	@cd $(CURGEN)/lib/engine && make

$(CURGEN)/lib/util/libutil.a:
	@cd $(CURGEN)/lib/util && make
