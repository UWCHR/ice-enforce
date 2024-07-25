#
# Authors:     PN
# Maintainers: PN
# Copyright:   2024, UWCHR, GPL v2 or later
# ============================================
# ice-enforce/write/Makefile

AORS = ATL BAL BOS BUF CHI DAL DEN DET ELP HOU LOS MIA NEW NOL NYC PHI PHO SEA SFR SLC SNA SND SPM WAS
# AORS = BOS SEA # For testing


.PHONY: all clean

all: \
	output/index.html \
	output/encounters.html \
	output/arrests.html \
	output/removals.html

aors:
	@for n in $(AORS); do \
		Rscript -e "rmarkdown::render('note/aor.Rmd', 'html_document', params = list(aor = '$$n'))" ; \
		mkdir -p output/aor/ ; \
		mv note/aor.html output/aor/$$n.html ; \
	done

clean:
	rm -r output/*

output/index.html: \
		note/index.Rmd \
		input/ice_encounters_fy12-23ytd.csv.gz \
		input/ice_arrests_fy12-23ytd.csv.gz \
		input/ice_removals_fy12-23ytd.csv.gz \
		input/aor_demog_indicators.csv.gz
	Rscript -e "rmarkdown::render('note/index.Rmd', 'html_document')"
	mv note/index.html output/

output/encounters.html: \
		note/encounters.Rmd \
		input/ice_encounters_fy12-23ytd.csv.gz \
		input/aor_demog_indicators.csv.gz
	Rscript -e "rmarkdown::render('note/encounters.Rmd', 'html_document')"
	mv note/encounters.html output/

output/arrests.html: \
		note/arrests.Rmd \
		input/ice_arrests_fy12-23ytd.csv.gz \
		input/aor_demog_indicators.csv.gz
	Rscript -e "rmarkdown::render('note/arrests.Rmd', 'html_document')"
	mv note/arrests.html output/

output/removals.html: \
		note/removals.Rmd \
		input/ice_removals_fy12-23ytd.csv.gz \
		input/aor_demog_indicators.csv.gz
	Rscript -e "rmarkdown::render('note/removals.Rmd', 'html_document')"
	mv note/removals.html output/

output/SEA.html: \
		note/aor.Rmd \
		input/ice_encounters_fy12-23ytd.csv.gz \
		input/ice_arrests_fy12-23ytd.csv.gz \
		input/ice_removals_fy12-23ytd.csv.gz \
		input/aor_demog_indicators.csv.gz
	Rscript -e "rmarkdown::render('note/aor.Rmd', 'html_document', params = list(aor = 'SEA'))"
	mv note/aor.html output/SEA.html

# done.
