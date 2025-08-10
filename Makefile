all: index.html index.pdf

ubuntu-dependencies:
	apt-get update -y
	apt install -y pandoc texlive-latex-base texlive-fonts-recommended  texlive-fonts-extra texlive-latex-extra

index.html: index.md style.css
	pandoc -o $@ --standalone --css=style.css $<

index.pdf: index.md
	pandoc -V geometry:margin=3cm -o $@ $<

clean:
	rm -f *.pdf *.html
