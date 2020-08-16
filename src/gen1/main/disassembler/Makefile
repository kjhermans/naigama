TARGET=naid
CC=$(ARCH)gcc
CFLAGS=-g -O2 -Wall -Wextra $(DEBUG) -I$(BUILDROOT)/src/gen1/include
LIBS=\
	$(BUILDROOT)/src/gen1/lib/disassembler/libnaid.a \
	$(BUILDROOT)/src/gen1/lib/engine/libnaie.a \
	$(BUILDROOT)/src/gen1/lib/util/libutil.a

all: $(TARGET)

$(TARGET): disassembler.o $(LIBS)
	$(CC) -o $(TARGET) disassembler.o $(LIBS)

clean:
	@rm -f $(TARGET) disassembler.o

superclean: clean

$(BUILDROOT)/src/gen1/lib/disassembler/libnaid.a:
	@cd $(BUILDROOT)/src/gen1/lib/disassembler && make

$(BUILDROOT)/src/gen1/lib/engine/libnaie.a:
	@cd $(BUILDROOT)/src/gen1/lib/engine && make

$(BUILDROOT)/src/gen1/lib/util/libutil.a:
	@cd $(BUILDROOT)/src/gen1/lib/util && make
