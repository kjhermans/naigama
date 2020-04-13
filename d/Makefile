all:
	perl ../bin/gen_doc_instructions.pl ../instructions.pl
	perl ./generate.pl ../instructions.pl .
	texi2pdf --batch compendium.tex >/dev/null || true

clean:
	rm -f compendium.aux compendium.lof compendium.log compendium.pdf compendium.toc compendium.lot
