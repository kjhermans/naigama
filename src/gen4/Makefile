all: instructions
	cd grammar && make
	cd lib && make
	cd main && make
	cd lib && make curgen
	cd main && make curgen

debug:
	cd grammar && make DEBUG="-D_DEBUG=1"
	cd lib && make DEBUG="-D_DEBUG=1"
	cd main && make DEBUG="-D_DEBUG=1"
	cd lib && make curgen DEBUG="-D_DEBUG=1"
	cd main && make curgen DEBUG="-D_DEBUG=1"

clean:
	cd grammar && make clean
	cd lib && make clean
	cd main && make clean

test:
	cd t && make

instructions:
	./bin/geninstr ./precomp/instructions.pl > \
	  ./include/naigama/naigama/naig_instructions.h

