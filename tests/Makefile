TEX_FILES:=$(wildcard *.tex)
PDF_FILES:=$(patsubst %.tex,%.pdf,${TEX_FILES})

LATEXMK_BACKEND?=lualatex

all: ${PDF_FILES}
check: ${TEX_FILES} ../tex/fk*.sty
	chktex -W
	chktex -q $^
lacheck: ${TEX_FILES}
	../tools/lacheck.sh $^
%.pdf: %.tex ../tex/fk*.sty
	TEXMFHOME=.. latexmk -interaction=nonstopmode --use-make -${LATEXMK_BACKEND} $<

.PHONY: clean
clean:
	latexmk -C
