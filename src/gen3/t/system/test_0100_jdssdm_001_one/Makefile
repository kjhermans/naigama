all:
	perl $(SYSTEMTESTROOT)/bin/xsdcompile ./xsd/JDSSDM-1.1-Root.xsd \
		> /tmp/test.px || exit -1
	perl $(SYSTEMTESTROOT)/bin/perl2xmlpeg /tmp/test.px \
		> /tmp/test.naig || exit -1
	cat /tmp/test.naig
	$(SYSTEMTESTROOT)/bin/naic -i /tmp/test.naig \
		-o /tmp/test.asm || exit -1
	cat /tmp/test.asm
	$(SYSTEMTESTROOT)/bin/naia -i /tmp/test.asm \
		-o /tmp/test.byc || exit -1
	hexdump -C /tmp/test.byc
	$(SYSTEMTESTROOT)/bin/naie -t -c /tmp/test.byc \
		-i ./xml/Presencejdssdm.xml -t || exit -1
	@echo "SUCCESS"
