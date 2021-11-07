all: dirs biglib

dirs:
	@cd util && make
	@cd compiler && make
	@cd assembler && make
	@cd disassembler && make
	@cd engine && make
	@cd naigama && make

biglib:
	@../bin/arjoin naigama/libnaigama.a \
	  util/libutil.a \
	  compiler/libnaic.a \
	  assembler/libnaia.a \
	  disassembler/libnaid.a \
	  engine/libnaie.a \
	  naigama/libnaig.a

clean:
	@rm -f naigama/libnaigama.a
