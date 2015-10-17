TEX_FILES:=$(wildcard *.tex)
PDF_FILES:=$(patsubst %.tex,%.pdf,${TEX_FILES})

LATEXMK_BACKEND ?= lualatex

all: ${PDF_FILES}
check: ${TEX_FILES} ../fkoehler.sty
	chktex -W
	chktex -q ${TEX_FILES}
lacheck:
	../tools/lacheck.sh $^
%.pdf: %.tex ../fkoehler.sty
	latexmk --use-make -${LATEXMK_BACKEND} $<

.PHONY: clean
clean:
	latexmk -C
