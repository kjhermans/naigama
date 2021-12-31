all:
	$(SYSTEMTESTROOT)/bin/naic -i ./test.naig \
		-a /tmp/test.asm -o /tmp/test.byc || exit -1
	./execute.sh && \
		echo "SUCCESS"
