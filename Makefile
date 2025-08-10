all: index.html

ubuntu-dependencies:
	apt-get update -y
	apt install -y pandoc

index.html: README.md style.css
	pandoc -o $@ --standalone --css=style.css $<

clean:
	rm -f *.html
