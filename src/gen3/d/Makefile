all:
	perl ./gen_doc_instructions.pl ../precomp/instructions.pl ../grammar/assembly.naig
	perl ./generate.pl ../precomp/instructions.pl .
	texi2pdf --batch compendium.tex >/dev/null || true

clean:
	rm -f compendium.aux compendium.lof compendium.log compendium.pdf compendium.toc compendium.lot
