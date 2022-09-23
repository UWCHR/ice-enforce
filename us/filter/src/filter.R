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

log_info('Output file: {args$output}')
rows_out <- nrow(df)
log_info('Rows out: {rows_out}')

# END.
