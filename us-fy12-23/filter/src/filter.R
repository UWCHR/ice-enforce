# ---
# title: "Filter ICE enforcement data"
# date: "2022-09-23"
# author: "PN"
# copyright: UWCHR, GPL 3.0
# ---

library(pacman)
pacman::p_load("argparse", "tidyverse", "logger")

parser <- ArgumentParser()
parser$add_argument("--year", default = 2012)
parser$add_argument("--input", default = 'input/arrests.csv.gz')
parser$add_argument("--log", default = 'output/filter.log')
parser$add_argument("--output", default = 'output/arrests.csv.gz')
args <- parser$parse_args()

log_threshold(TRACE)
log_appender(appender_file(args$log))
logger <- layout_glue_generator(format = '{time}|{msg}')
log_layout(logger)

df <- read_delim(args$input, delim = "|")
print(glimpse(df))
print(skimr::skim(df))

log_info('Input file: {args$input}')
rows_in <- nrow(df)
log_info('Rows in: {rows_in}')

pre_drop <- nrow(df)
df <- df %>% 
	filter(aor != "") %>%
	filter(!is.null(aor))
write_delim(df, args$output, delim='|')
post_drop <- nrow(df)
log_info('Dropped records with missing `aor`: {pre_drop - post_drop}')

pre_drop <- nrow(df)
df <- df %>% 
	filter(aor != "HQ")
write_delim(df, args$output, delim='|')
post_drop <- nrow(df)
log_info('Dropped records with `aor` == "HQ": {pre_drop - post_drop}')

### Arrests only

if (args$input == 'input/arrests.csv.gz') {

	likely_border_enforcement <- c("Patrol Border", "Inspections", 
		"Anti-Smuggling", "Patrol Interior", "Boat Patrol", "Traffic Check",
		"Crewman/Stowaway", "Transportation Check Aircraft", "Transportation Check Bus",
		"Transportation Check Passenger Train", "Transportation Check Freight Train" )

	pre_drop <- nrow(df)
	df <- df %>% 
		filter(!arrest_method %in% likely_border_enforcement)
	write_delim(df, args$output, delim='|')
	post_drop <- nrow(df)
	log_info('Dropped records with `arrest_method` reflecting likely border patrol involvement: {pre_drop - post_drop}')

	border_patrol_keywords <- "CBP|USBP|Border Patrol"

	pre_drop <- nrow(df)
	df <- df %>% 
		filter(!str_detect(arrest_method, border_patrol_keywords))
	write_delim(df, args$output, delim='|')
	post_drop <- nrow(df)
	log_info('Dropped records with border patrol keywords in `arrest_method`: {pre_drop - post_drop}')


	likely_border <- "PORT OF ENTRY|AIRPORT|BORDER"

	pre_drop <- nrow(df)
	df <- df %>% 
		filter(is.na(apprehension_landmark) | 
			   !str_detect(apprehension_landmark, likely_border))
	post_drop <- nrow(df)
	log_info('Dropped records with border-related keywords in `apprehension_landmark`: {pre_drop - post_drop}')

}

###

log_info('Output file: {args$output}')
rows_out <- nrow(df)
log_info('Rows out: {rows_out}')
log_info('Total records dropped: {rows_in - rows_out}')
write_delim(df, args$output, delim='|')

# END.
