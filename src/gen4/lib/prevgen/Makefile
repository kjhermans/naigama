CFLAGS=-g -Wall -Wextra $(DEBUG) -I$(PREVGEN)/include

all: libnaip.a

libnaip.a: naip.o $(PREVGEN)/lib/engine/libnaie.a
	ar -rcs libnaip.a \
	  $(PREVGEN)/lib/engine/naie_engine_init.o \
	  $(PREVGEN)/lib/engine/naie_engine_run.o \
	  $(PREVGEN)/lib/engine/naie_engine_loop.o \
	  $(PREVGEN)/lib/engine/naie_stack_p*.o \
	  $(PREVGEN)/lib/engine/naie_action_push.o \
	  $(PREVGEN)/lib/engine/naie_variable.o \
	  $(PREVGEN)/lib/engine/naie_engine_endless_loop.o \
	  $(PREVGEN)/lib/engine/naie_result_fill.o \
	  $(PREVGEN)/lib/engine/naie_register_*.o \
	  $(PREVGEN)/lib/engine/naie_engine_loop_replace.o \
	  $(PREVGEN)/lib/engine/naie_stack_call_size.o \
	  naip.o

naip.o: naip.c
	$(CC) $(CFLAGS) -c -o naip.o naip.c

clean:
	rm -f naip.o libnaip.a
