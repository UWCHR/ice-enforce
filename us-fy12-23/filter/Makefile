#
# :author: PN
# :date: 2022-09-23
# :license: GPL 2.0 or greater
#
# ice-ero-lesa/us/filter/src/Makefile
#
#

all: \
	output/arrests.csv.gz \
	output/encounters.csv.gz \
	output/removals.csv.gz
	
PHONY: all

output/arrests.csv.gz: \
	src/filter.R \
	input/arrests.csv.gz
	Rscript $< \
		--input=input/arrests.csv.gz \
		--log=output/filter-arrests.log \
		--output=$@

output/encounters.csv.gz: \
	src/filter.R \
	input/encounters.csv.gz
	Rscript $< \
		--input=input/encounters.csv.gz \
		--log=output/filter-encounters.log \
		--output=$@

output/removals.csv.gz: \
	src/filter.R \
	input/removals.csv.gz
	Rscript $< \
		--input=input/removals.csv.gz \
		--log=output/filter-removals.log \
		--output=$@

# End.