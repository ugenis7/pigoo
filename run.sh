#!/usr/bin/env bash

# First step: download the csv
wget -P input http://www.pigoo.gob.mx/Informes/Formatos_Pigoo/BasePIGOO2018.csv

# Then convert to utf-8
iconv -f windows-1254 -t  utf8//TRANSLIT input/BasePIGOO2018.csv > input/Base.csv

# "Clean" a bit 
cat input/Base.csv |\
	sed 's/ //g' |\
	sed 's/^[A-Za-z[:space:]\.\,()ñ-]*/"&",/g' |\
	sed 's/),"/)"/g' |\
	sed 's/"org",_/org/g' |\
	sed 's/,,//g' |\
	sed 's/,$//g' > input/pigoo.csv

rm input/BasePIGOO2018.csv input/Base.csv

# Tidy a bit
Rscript src/cleaning-pigoo.R

# Remove duplicates
cat input/pigoo.csv |\
	uniq > input/pigoo2.csv

mv input/pigoo2.csv output/pigoo.csv
