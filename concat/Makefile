#
# :author: PN
# :date: 2023-03-23
# :license: GPL 2.0 or greater
#
# ice-enforce/concat/src/Makefile
#
#

all: \
	output/ice_arrests_fy12-23ytd.csv.gz \
	output/ice_encounters_fy12-23ytd.csv.gz \
	output/ice_removals_fy12-23yd.csv.gz
	
PHONY: all

output/ice_arrests_fy12-23ytd.csv.gz: \
	src/concat.py \
	input/ERO_Arrests_FY2012.csv.gz \
	input/ERO_Arrests_FY2013.csv.gz \
	input/ERO_Arrests_FY2014.csv.gz \
	input/ERO_Arrests_FY2015.csv.gz \
	input/ERO_Arrests_FY2016.csv.gz \
	input/ERO_Arrests_FY2017.csv.gz \
	input/ERO_Arrests_FY2018.csv.gz \
	input/ERO_Arrests_FY2019.csv.gz \
	input/ERO_Arrests_FY2020.csv.gz \
	input/ERO_Arrests_FY2021.csv.gz \
	input/ERO_Arrests_FY2022.csv.gz \
	input/ERO_Arrests_FY2023YTD.csv.gz
	python $< \
		--input_fy12=input/ERO_Arrests_FY2012.csv.gz \
		--input_fy13=input/ERO_Arrests_FY2013.csv.gz \
		--input_fy14=input/ERO_Arrests_FY2014.csv.gz \
		--input_fy15=input/ERO_Arrests_FY2015.csv.gz \
		--input_fy16=input/ERO_Arrests_FY2016.csv.gz \
		--input_fy17=input/ERO_Arrests_FY2017.csv.gz \
		--input_fy18=input/ERO_Arrests_FY2018.csv.gz \
		--input_fy19=input/ERO_Arrests_FY2019.csv.gz \
		--input_fy20=input/ERO_Arrests_FY2020.csv.gz \
		--input_fy21=input/ERO_Arrests_FY2021.csv.gz \
		--input_fy22=input/ERO_Arrests_FY2022.csv.gz \
		--input_fy23=input/ERO_Arrests_FY2023YTD.csv.gz \
		--output=$@

output/ice_encounters_fy12-23ytd.csv.gz: \
	src/concat.py \
	input/ERO_Encounters_FY2012.csv.gz \
	input/ERO_Encounters_FY2013.csv.gz \
	input/ERO_Encounters_FY2014.csv.gz \
	input/ERO_Encounters_FY2015.csv.gz \
	input/ERO_Encounters_FY2016.csv.gz \
	input/ERO_Encounters_FY2017.csv.gz \
	input/ERO_Encounters_FY2018.csv.gz \
	input/ERO_Encounters_FY2019.csv.gz \
	input/ERO_Encounters_FY2020.csv.gz \
	input/ERO_Encounters_FY2021.csv.gz \
	input/ERO_Encounters_FY2022.csv.gz \
	input/ERO_Encounters_FY2023YTD.csv.gz
	python $< \
		--input_fy12=input/ERO_Encounters_FY2012.csv.gz \
		--input_fy13=input/ERO_Encounters_FY2013.csv.gz \
		--input_fy14=input/ERO_Encounters_FY2014.csv.gz \
		--input_fy15=input/ERO_Encounters_FY2015.csv.gz \
		--input_fy16=input/ERO_Encounters_FY2016.csv.gz \
		--input_fy17=input/ERO_Encounters_FY2017.csv.gz \
		--input_fy18=input/ERO_Encounters_FY2018.csv.gz \
		--input_fy19=input/ERO_Encounters_FY2019.csv.gz \
		--input_fy20=input/ERO_Encounters_FY2020.csv.gz \
		--input_fy21=input/ERO_Encounters_FY2021.csv.gz \
		--input_fy22=input/ERO_Encounters_FY2022.csv.gz \
		--input_fy23=input/ERO_Encounters_FY2023YTD.csv.gz \
		--output=$@

output/ice_removals_fy12-23yd.csv.gz: \
	src/concat.py \
	input/ICE_Removals_FY2012.csv.gz \
	input/ICE_Removals_FY2013.csv.gz \
	input/ICE_Removals_FY2014.csv.gz \
	input/ICE_Removals_FY2015.csv.gz \
	input/ICE_Removals_FY2016.csv.gz \
	input/ICE_Removals_FY2017.csv.gz \
	input/ICE_Removals_FY2018.csv.gz \
	input/ICE_Removals_FY2019.csv.gz \
	input/ICE_Removals_FY2020.csv.gz \
	input/ICE_Removals_FY2021.csv.gz \
	input/ICE_Removals_FY2022.csv.gz \
	input/ICE_Removals_FY2023YTD.csv.gz
	python $< \
		--input_fy12=input/ICE_Removals_FY2012.csv.gz \
		--input_fy13=input/ICE_Removals_FY2013.csv.gz \
		--input_fy14=input/ICE_Removals_FY2014.csv.gz \
		--input_fy15=input/ICE_Removals_FY2015.csv.gz \
		--input_fy16=input/ICE_Removals_FY2016.csv.gz \
		--input_fy17=input/ICE_Removals_FY2017.csv.gz \
		--input_fy18=input/ICE_Removals_FY2018.csv.gz \
		--input_fy19=input/ICE_Removals_FY2019.csv.gz \
		--input_fy20=input/ICE_Removals_FY2020.csv.gz \
		--input_fy21=input/ICE_Removals_FY2021.csv.gz \
		--input_fy22=input/ICE_Removals_FY2022.csv.gz \
		--input_fy23=input/ICE_Removals_FY2023YTD.csv.gz \
		--output=$@

# End.