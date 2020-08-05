all:
	@make stages 2>&1 | tee /tmp/make.log

debug:
	@export DEBUG=-D_DEBUG && make stages 2>&1 | tee /tmp/make.log

stages: \
  stage_00 \
  stage_01 stage_2 stage_3 stage_4 \
  stage_5 stage_6 stage_7 stage_8 \
  stage_9 stage_10

arm_bare_metal:
	@export ARCH=arm-none-eabi- && make

instructions: superclean
	@perl ./bin/gen_instructions.pl > ./src/instructions.pl

## stage_00: library functions.h generation
## stage_01: gen1 grammar.byc etc generation (using gen0 compiler)
## stage_2: gen1 bytecode.h etc generation
## stage_3: gen1 library building
## stage_4: gen1 mains building
## stage_5: gen2 grammar.byc etc generation (using gen1 compiler)
## stage_6: gen2 bytecode.h etc generation
## stage_7: gen2 library building
## stage_8: gen2 mains building

stage_00:
	@echo "---- Building stage 0"
	@MFS=`find src/ -name Makefile | xargs grep -l stage_00`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			BUILDROOT=`pwd` make -C $$DIR stage_00; \
		done

stage_01:
	@echo "---- Building stage 1"
	@MFS=`find src/ -name Makefile | xargs grep -l stage_01`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			BUILDROOT=`pwd` make -C $$DIR stage_01; \
		done

stage_2:
	@echo "---- Building stage 2"
	@MFS=`find src/ -name Makefile | xargs grep -l stage_2`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			BUILDROOT=`pwd` make -C $$DIR stage_2; \
		done

stage_3:
	@echo "---- Building stage 3"
	@MFS=`find src/ -name Makefile | xargs grep -l stage_3`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			BUILDROOT=`pwd` make -C $$DIR stage_3; \
		done

stage_4:
	@echo "---- Building stage 4"
	@MFS=`find src/ -name Makefile | xargs grep -l stage_4`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			BUILDROOT=`pwd` make -C $$DIR stage_4; \
		done

stage_5:
	@echo "---- Building stage 5"
	@MFS=`find src/ -name Makefile | xargs grep -l stage_5`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			BUILDROOT=`pwd` make -C $$DIR stage_5; \
		done

stage_6:
	@echo "---- Building stage 6"
	@MFS=`find src/ -name Makefile | xargs grep -l stage_6`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			BUILDROOT=`pwd` make -C $$DIR stage_6; \
		done

stage_7:
	@echo "---- Building stage 7"
	@MFS=`find src/ -name Makefile | xargs grep -l stage_7`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			BUILDROOT=`pwd` make -C $$DIR stage_7; \
		done

stage_8:
	@echo "---- Building stage 8"
	@MFS=`find src/ -name Makefile | xargs grep -l stage_8`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			BUILDROOT=`pwd` make -C $$DIR stage_8; \
		done

stage_9:
	@echo "---- Building stage 9"
	@MFS=`find src/ -name Makefile | xargs grep -l stage_9`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			BUILDROOT=`pwd` make -C $$DIR stage_9; \
		done

stage_10:
	@echo "---- Building stage 10"
	@MFS=`find src/ -name Makefile | xargs grep -l stage_10`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			BUILDROOT=`pwd` make -C $$DIR stage_10; \
		done

stage_11:
	@echo "---- Building stage 11"
	@MFS=`find src/ -name Makefile | xargs grep -l stage_11`; \
		for MF in $$MFS; do \
			DIR=`dirname $$MF`; \
			BUILDROOT=`pwd` make -C $$DIR stage_11; \
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

test: all
	@BUILDROOT=`pwd` make -C t/ all
	@BUILDROOT=`pwd` make -C src/gen3/t/ all

doc:
	@BUILDROOT=`pwd` make -C d/ all

install:
	@sudo cp src/main/engine/naie \
		src/main/compiler/naic \
		src/main/assembler/naia \
		/usr/local/bin/

java:
	@cd src/java && make
