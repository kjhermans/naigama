TARGET=naia
CC=$(ARCH)gcc
CFLAGS=-g -O2 -Wall -Wextra $(DEBUG) -I$(BUILDROOT)/src/parser/include
LIBS=\
	$(BUILDROOT)/src/parser/gen1/lib/assembler/libnaia.a \
	$(BUILDROOT)/src/parser/gen1/lib/engine/libnaie.a \
	$(BUILDROOT)/src/parser/gen1/lib/util/libutil.a

all: $(TARGET)

$(TARGET): assembler.o $(LIBS)
	$(CC) -o $(TARGET) assembler.o $(LIBS)

clean:
	@rm -f $(TARGET) assembler.o

superclean: clean

$(BUILDROOT)/src/parser/gen1/lib/assembler/libnaia.a:
	@cd $(BUILDROOT)/src/parser/gen1/lib/assembler && make

$(BUILDROOT)/src/parser/gen1/lib/engine/libnaie.a:
	@cd $(BUILDROOT)/src/parser/gen1/lib/engine && make

$(BUILDROOT)/src/parser/gen1/lib/util/libutil.a:
	@cd $(BUILDROOT)/src/parser/gen1/lib/util && make
