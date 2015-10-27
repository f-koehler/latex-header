TEX_FILES:=$(wildcard *.tex)
PDF_FILES:=$(patsubst %.tex,%.pdf,${TEX_FILES})

LATEXMK_BACKEND?=lualatex

all: ${PDF_FILES}
check: ${TEX_FILES} ../tex/fkoehler.sty
	chktex -W
	chktex -q $^
lacheck: ${TEX_FILES}
	../tools/lacheck.sh $^
%.pdf: %.tex ../tex/fkoehler.sty
	latexmk -interaction=nonstopmode --use-make -${LATEXMK_BACKEND} $<

.PHONY: clean
clean:
	latexmk -C
