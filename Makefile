TEX = pdflatex -shell-escape -interaction=nonstopmode -file-line-error
BIB = bibtex

.PHONY: all

all : report.pdf

report: report.pdf

report.pdf : report.tex report.bbl report.blg
	$(TEX) report.tex

report.bbl report.blg : report.bib report.aux
	$(BIB) report

report.aux : report.tex
	$(TEX) report.tex

report.bib : report.tex
	$(TEX) report.tex

inotify: all
	while true; do inotifywait -e modify *.tex *.bib; make; done
