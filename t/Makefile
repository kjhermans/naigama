all:
	@echo "Multi tests"
	@ls multi_*.tst | sort -n | xargs -i ../bin/multitest.pl \
		{} \
		'../src/main/compiler/naic -i GRAMMAR -o ASM' \
		'../src/main/assembler/naia -i ASM -o BYTECODE' \
		'../src/main/engine/naie -D -X -I -b BYTECODE -d INPUT >/dev/null'
	@echo "Single tests"
	@ls single_*.tst | sort -n | xargs -i ../bin/singletest.pl \
		{} \
		'../src/main/compiler/naic -i GRAMMAR -o ASM' \
		'../src/main/assembler/naia -i ASM -o BYTECODE' \
		'../src/main/engine/naie -b BYTECODE -d INPUT >/dev/null'
