all:
	texi2pdf --batch paper.tex >/dev/null || true
	texi2pdf --batch compendium.tex >/dev/null || true

clean:
	rm -f *.log *.pdf *.lot *.toc *.aux
