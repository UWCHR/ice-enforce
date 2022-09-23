#
# :author: PN
# :date: 2022-09-23
# :license: GPL 2.0 or greater
#
# ice-ero-lesa/us/filter/src/Makefile
#
#

all: \
	output/enforcement.csv.gz

clean:
	rm -r output/*	

.PHONY: all clean

output/enforcement.csv.gz: \
	src/export.R \
	input/arrests.csv.gz \
	input/encounters.csv.gz \
	input/removals.csv.gz
	Rscript $< \
		--arrests=input/arrests.csv.gz \
		--encounters=input/encounters.csv.gz \
		--removals=input/removals.csv.gz \
		--log=output/export.log \
		--output=$@

# End.
