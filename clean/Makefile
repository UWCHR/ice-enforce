#
# :author: PN
# :date: 2019-12-26
# :license: GPL 2.0 or greater
#
# ice-ero-lesa/clean/src/Makefile
#
#

all: \
	output/ice_arrests_fy12-23ytd.csv.gz \
	output/ice_encounters_fy12-23ytd.csv.gz \
	output/ice_removals_fy12-23yd.csv.gz
	
PHONY: all

output/ice_arrests_fy12-23ytd.csv.gz: \
	src/clean.py \
	hand/clean_rules.yaml \
	hand/arrest_dtypes.yaml \
	input/ice_arrests_fy12-23ytd.csv.gz
	python $< \
		--dtypes=hand/arrest_dtypes.yaml \
		--cleanrules=hand/clean_rules.yaml \
		--input=input/ice_arrests_fy12-23ytd.csv.gz \
		--log=output/clean-arrests.log \
		--output=$@

output/ice_encounters_fy12-23ytd.csv.gz: \
	src/clean.py \
	hand/clean_rules.yaml \
	hand/encounter_dtypes.yaml \
	input/ice_encounters_fy12-23ytd.csv.gz
	python $< \
		--dtypes=hand/encounter_dtypes.yaml \
		--cleanrules=hand/clean_rules.yaml \
		--input=input/ice_encounters_fy12-23ytd.csv.gz \
		--log=output/clean-encounters.log \
		--output=$@

output/ice_removals_fy12-23yd.csv.gz: \
	src/clean.py \
	hand/clean_rules.yaml \
	hand/removal_dtypes.yaml \
	input/ice_removals_fy12-23yd.csv.gz
	python $< \
		--dtypes=hand/removal_dtypes.yaml \
		--cleanrules=hand/clean_rules.yaml \
		--input=input/ice_removals_fy12-23yd.csv.gz \
		--log=output/clean-removals.log \
		--output=$@

# End.