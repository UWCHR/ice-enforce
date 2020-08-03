#
# :author: PN
# :date: 2019-12-20
# :license: GPL 2.0 or greater
#
# ice-ero-lesa/us/concat/src/Makefile
#
#

all: \
	output/arrests.csv.gz \
	output/encounters.csv.gz \
	output/removals.csv.gz
	
PHONY: all

output/arrests.csv.gz: \
	src/concat.py \
	hand/arrest_dtypes.yaml \
	input/EROArrests_FY2016.csv.gz \
	input/EROArrests_FY2017.csv.gz \
	input/EROArrests_FY2018.csv.gz \
	input/EROArrests_FY2019.csv.gz
	python $< \
		--dtypes=hand/arrest_dtypes.yaml \
		--input_fy16=input/EROArrests_FY2016.csv.gz \
		--input_fy17=input/EROArrests_FY2017.csv.gz \
		--input_fy18=input/EROArrests_FY2018.csv.gz \
		--input_fy19=input/EROArrests_FY2019.csv.gz \
		--output=$@

output/encounters.csv.gz: \
	src/concat.py \
	hand/encounter_dtypes.yaml \
	input/EROEncounters_FY2016.csv.gz \
	input/EROEncounters_FY2017.csv.gz \
	input/EROEncounters_FY2018.csv.gz \
	input/EROEncounters_FY2019.csv.gz
	python $< \
		--dtypes=hand/encounter_dtypes.yaml \
		--input_fy16=input/EROEncounters_FY2016.csv.gz \
		--input_fy17=input/EROEncounters_FY2017.csv.gz \
		--input_fy18=input/EROEncounters_FY2018.csv.gz \
		--input_fy19=input/EROEncounters_FY2019.csv.gz \
		--output=$@

output/removals.csv.gz: \
	src/concat.py \
	hand/removal_dtypes.yaml \
	input/ICERemovals_FY2016.csv.gz \
	input/ICERemovals_FY2017.csv.gz \
	input/ICERemovals_FY2018.csv.gz \
	input/ICERemovals_FY2019.csv.gz
	python $< \
		--dtypes=hand/removal_dtypes.yaml \
		--input_fy16=input/ICERemovals_FY2016.csv.gz \
		--input_fy17=input/ICERemovals_FY2017.csv.gz \
		--input_fy18=input/ICERemovals_FY2018.csv.gz \
		--input_fy19=input/ICERemovals_FY2019.csv.gz \
		--output=$@

# End.