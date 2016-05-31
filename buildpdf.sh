#!/bin/bash

# run : ./buildpdf.sh main

pdflatex $1.tex
bibtex   $1.aux
pdflatex $1.tex
pdflatex $1.tex

open -a Adobe\ Acrobat\ Pro.app ${1}.pdf

rm ${1}.fff ${1}.log ${1}.aux ${1}.ttt ${1}.bbl ${1}.lof ${1}.blg ${1}.spl ${1}.out

clear

