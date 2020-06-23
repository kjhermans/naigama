TARGET=nasc
CC=$(ARCH)gcc
CFLAGS=-g -O2 -Wall -Wextra $(DEBUG) \
  -I$(BUILDROOT)/src/parser/include \
  -I$(BUILDROOT)/src/script/include

LIBS=\
	$(BUILDROOT)/src/script/lib/compiler/libnasc.a \
	$(BUILDROOT)/src/parser/gen1/lib/naigama/libnaigama.a \

stage_8: all

all: $(TARGET)

$(TARGET): compiler.o $(LIBS)
	$(CC) -o $(TARGET) compiler.o $(LIBS)

clean:
	@rm -f $(TARGET) compiler.o

superclean: clean

$(BUILDROOT)/src/parser/gen1/lib/compiler/libnaic.a:
	@cd $(BUILDROOT)/src/parser/gen1/lib/compiler && make

$(BUILDROOT)/src/parser/gen1/lib/engine/libnaie.a:
	@cd $(BUILDROOT)/src/parser/gen1/lib/engine && make

$(BUILDROOT)/src/parser/gen1/lib/util/libutil.a:
	@cd $(BUILDROOT)/src/parser/gen1/lib/util && make

$(BUILDROOT)/src/script/lib/compiler/libnasc.a:
	@cd $(BUILDROOT)/src/script/lib/compiler && make
