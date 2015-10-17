TEX_FILES:=$(wildcard *.tex)
PDF_FILES:=$(patsubst %.tex,%.pdf,${TEX_FILES})

LATEXMK_BACKEND ?= lualatex

all: ${PDF_FILES}
check: ${TEX_FILES}
	chktex -W
	chktex -q ${TEX_FILES}
%.pdf: %.tex
	latexmk --use-make -${LATEXMK_BACKEND} $<
%.chk: %.tex
	chktex -q $< &> $@

.PHONY: clean
clean:
	latexmk -C
