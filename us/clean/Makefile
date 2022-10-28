#
# :author: PN
# :date: 2019-12-26
# :license: GPL 2.0 or greater
#
# ice-ero-lesa/us/clean/src/Makefile
#
#

all: \
	output/arrests.csv.gz \
	output/encounters.csv.gz \
	output/removals.csv.gz
	
PHONY: all

output/arrests.csv.gz: \
	src/clean.py \
	hand/clean_rules.yaml \
	hand/arrest_dtypes.yaml \
	input/arrests.csv.gz
	python $< \
		--dtypes=hand/arrest_dtypes.yaml \
		--cleanrules=hand/clean_rules.yaml \
		--input=input/arrests.csv.gz \
		--log=output/clean_arrests.log \
		--output=$@

output/encounters.csv.gz: \
	src/clean.py \
	hand/clean_rules.yaml \
	hand/encounter_dtypes.yaml \
	input/encounters.csv.gz
	python $< \
		--dtypes=hand/encounter_dtypes.yaml \
		--cleanrules=hand/clean_rules.yaml \
		--input=input/encounters.csv.gz \
		--log=output/clean_encounters.log \
		--output=$@

output/removals.csv.gz: \
	src/clean.py \
	hand/clean_rules.yaml \
	hand/removal_dtypes.yaml \
	input/removals.csv.gz
	python $< \
		--dtypes=hand/removal_dtypes.yaml \
		--cleanrules=hand/clean_rules.yaml \
		--input=input/removals.csv.gz \
		--log=output/clean_removals.log \
		--output=$@

# End.