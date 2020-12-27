all:
	texi2pdf --batch pegsecurity.tex >/dev/null || true

clean:
	rm -f pegsecurity.aux pegsecurity.log pegsecurity.lot \
		pegsecurity.pdf pegsecurity.toc 

archive: clean
	cd ../ && tar czvf ~/pegpaper.tar.gz pegpaper/
