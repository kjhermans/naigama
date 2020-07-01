TARGET=naia
CC=$(ARCH)gcc
CFLAGS=-g -O2 -Wall -Wextra $(DEBUG) -I$(BUILDROOT)/src/gen2/include
LIBS=\
	$(BUILDROOT)/src/gen2/lib/assembler/libnaia.a \
	$(BUILDROOT)/src/gen2/lib/engine/libnaie.a \
	$(BUILDROOT)/src/gen2/lib/util/libutil.a

all: $(TARGET)

$(TARGET): assembler.o $(LIBS)
	$(CC) -o $(TARGET) assembler.o $(LIBS)

clean:
	@rm -f $(TARGET) assembler.o

superclean: clean

$(BUILDROOT)/src/gen2/lib/assembler/libnaia.a:
	@cd $(BUILDROOT)/src/gen2/lib/assembler && make

$(BUILDROOT)/src/gen2/lib/engine/libnaie.a:
	@cd $(BUILDROOT)/src/gen2/lib/engine && make

$(BUILDROOT)/src/gen2/lib/util/libutil.a:
	@cd $(BUILDROOT)/src/gen2/lib/util && make
