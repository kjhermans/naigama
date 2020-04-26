TARGET=naie
CC=$(ARCH)gcc
CFLAGS=-I../../include -g -O2 -Wall -Wextra $(DEBUG)
LIBS=\
	../../lib/engine/libnaie.a \
	../../lib/util/libutil.a

all: $(TARGET)

OBJECTS=engine.o engine_replace.o

$(TARGET): $(OBJECTS) $(LIBS)
	$(CC) -o $(TARGET) $(OBJECTS) $(LIBS)

clean:
	@rm -f $(TARGET) $(OBJECTS)

superclean: clean

../../lib/engine/libnaie.a:
	@cd ../../lib/engine && make

../../lib/util/libutil.a:
	@cd ../../lib/util && make
