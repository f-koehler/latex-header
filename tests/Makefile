TEX_FILES:=$(wildcard *.tex)
PDF_FILES:=$(patsubst %.tex,%.pdf,${TEX_FILES})

all: ${PDF_FILES}
check: ${TEX_FILES}
	chktex -W
	chktex -q ${TEX_FILES}
%.pdf: %.tex
	latexmk --use-make -lualatex $<
%.chk: %.tex
	chktex -q $< &> $@

.PHONY: clean
clean:
	latexmk -C
