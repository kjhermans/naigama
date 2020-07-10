all:
	perl ../bin/gen_doc_instructions.pl ../src/instructions.pl
	perl ./generate.pl ../src/instructions.pl .
	texi2pdf --batch compendium.tex >/dev/null || true

clean:
	rm -f compendium.aux compendium.lof compendium.log compendium.pdf compendium.toc compendium.lot
