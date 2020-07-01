all: stage_0 stage_1 stage_2 stage_3 stage_4 stage_5 stage_6 stage_7 stage_8

debug:
	@export DEBUG=-D_DEBUG && make

arm_bare_metal:
	@export ARCH=arm-none-eabi- && make

## stage_0: library functions.h generation
## stage_1: gen1 grammar.byc etc generation (using gen0 compiler)
## stage_2: gen1 bytecode.h etc generation
## stage_3: gen1 library building
## stage_4: gen1 mains building
## stage_5: gen2 grammar.byc etc generation (using gen1 compiler)
## stage_6: gen2 bytecode.h etc generation
## stage_7: gen2 library building
## stage_8: gen2 mains building

stage_0:
	@MFS=`find src/ -name Makefile | xargs grep -l stage_0`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			BUILDROOT=`pwd` make -C $$DIR stage_0; \
		done

stage_1:
	@MFS=`find src/ -name Makefile | xargs grep -l stage_1`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			BUILDROOT=`pwd` make -C $$DIR stage_1; \
		done

stage_2:
	@MFS=`find src/ -name Makefile | xargs grep -l stage_2`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			BUILDROOT=`pwd` make -C $$DIR stage_2; \
		done

stage_3:
	@MFS=`find src/ -name Makefile | xargs grep -l stage_3`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			BUILDROOT=`pwd` make -C $$DIR stage_3; \
		done

stage_4:
	@MFS=`find src/ -name Makefile | xargs grep -l stage_4`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			BUILDROOT=`pwd` make -C $$DIR stage_4; \
		done

stage_5:
	@MFS=`find src/ -name Makefile | xargs grep -l stage_5`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			BUILDROOT=`pwd` make -C $$DIR stage_5; \
		done

stage_6:
	@MFS=`find src/ -name Makefile | xargs grep -l stage_6`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			BUILDROOT=`pwd` make -C $$DIR stage_6; \
		done

stage_7:
	@MFS=`find src/ -name Makefile | xargs grep -l stage_7`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			BUILDROOT=`pwd` make -C $$DIR stage_7; \
		done

stage_8:
	@MFS=`find src/ -name Makefile | xargs grep -l stage_8`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			BUILDROOT=`pwd` make -C $$DIR stage_8; \
		done

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
	@BUILDROOT=`pwd` make -C t/ all

doc:
	@BUILDROOT=`pwd` make -C d/ all

install:
	@sudo cp src/main/engine/naie \
		src/main/compiler/naic \
		src/main/assembler/naia \
		/usr/local/bin/

java:
	@cd src/java && make
