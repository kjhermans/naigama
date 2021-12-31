all:
	texi2pdf --batch document.tex >/dev/null || true

text:
	detex document.tex | sed -e '/^[[:space:]]*$$/d' > document.txt

clean:
	rm -f document.aux \
	  document.idx \
	  document.lof \
	  document.log \
	  document.lot \
	  document.toc \

superclean: clean
	rm -f document.pdf
