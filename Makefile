all: stage_0 stage_1 stage_2 stage_3 stage_4

debug:
	@export DEBUG=-D_DEBUG && make

arm_bare_metal:
	@export ARCH=arm-none-eabi- && make

stage_0:
	@cd src/grammar && make

stage_1:
	@cd src/precomp && make

stage_2:
	@cd src/include && make functions

stage_3:
	@cd src/lib && make

stage_4:
	@cd src/main && make

archive: clean
	RELEASE=$$(cat release); \
	/bin/echo "  [TAR] ~/naigama-src-$$RELEASE.tar.gz"; \
	cd .. && tar czf ~/naigama-src-$$RELEASE.tar.gz --exclude=\.git naigama/

clean:
	@MFS=`find src/ doc/ -name Makefile`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			make -C $$DIR clean; \
		done

superclean:
	@MFS=`find src -name Makefile`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			make -C $$DIR superclean; \
		done

test:
	@cd t/ && make

doc:
	@cd d/ && make

install:
	@sudo cp src/main/engine/naie \
		src/main/compiler/naic \
		src/main/assembler/naia \
		/usr/local/bin/

java:
	@cd src/java && make
