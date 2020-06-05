TARGET=naig
CC=$(ARCH)gcc
CFLAGS=-I../../include -g -O2 -Wall -Wextra $(DEBUG)
LIBS=../../lib/naigama/libnaigama.a

all: $(TARGET)

OBJECTS=naigama.o

$(TARGET): $(OBJECTS) $(LIBS)
	$(CC) -o $(TARGET) $(OBJECTS) $(LIBS)

clean:
	@rm -f $(TARGET) $(OBJECTS)

superclean: clean

../../lib/naigama/libnaigama.a:
	@cd ../../lib/naigama && make
