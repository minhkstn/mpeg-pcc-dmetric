
all: mpeg-pcc-dmetric-sw-manual.pdf

MD_SRC=\
	README.about.md \
	README.clone.md \
	README.build.md \
	README.options.md \
	README.usage.md \
	$(NULL)

TEX_SRC=\
	mpeg-pcc-dmetric-sw-manual.tex \
	$(patsubst %.md,%.tex,$(MD_SRC)) \
	$(NULL)


clean:
	rm -rf *.log *.pdf *.toc *.out *.blg $(patsubst %.md,%.tex,$(MD_SRC)) 
	
mpeg-pcc-dmetric-sw-manual.pdf: $(TEX_SRC)

LATEX:=$(shell which xelatex || which pdflatex || which latex)

# for bibtex
%.aux: %.tex
	$(LATEX) $(LATEXFLAGS) $<

# normally this has a rule to use bibtool to pull in mpeg bib entries
%.bib: %.tex
	touch $@

%.bbl: %.tex %.aux %.bib
	-bibtex $(*F)

ifneq ($(notdir $(LATEX)),latex)
# for direct pdf generation
%.pdf: %.tex %.bbl
	$(LATEX) $(LATEXFLAGS) $<
	$(LATEX) $(LATEXFLAGS) $<
endif

%.pdf: %.dvi
	dvipdfm $*.dvi

%.dvi: %.tex %.bbl
	$(LATEX) $(LATEXFLAGS) $<
	$(LATEX) $(LATEXFLAGS) $<

# convert markdown text to latex for document generation
%.tex: %.md
	pandoc -f markdown -t latex -o $@ $<
