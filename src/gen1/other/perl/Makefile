all:
	./bin/gen_instr.pl ../../precomp/instructions.pl > ./lib/Naigama/Instructions.pm

superclean:
	rm -f ./lib/Naigama/Instructions.pm

test:
	SCRIPTS=$$(ls t/*.pl | sort -n); \
	for SCRIPT in $$SCRIPTS; do \
	  echo $$SCRIPT; \
	  perl -I lib ./$$SCRIPT; \
	done
