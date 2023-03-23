# ---
# title: "Summarize and export ICE enforcement data"
# date: "2022-09-23"
# author: "PN"
# copyright: UWCHR, GPL 3.0
# ---

library(pacman)
pacman::p_load("argparse", "tidyverse", "lubridate", "logger")

parser <- ArgumentParser()
parser$add_argument("--year", default = 2012)
parser$add_argument("--arrests", default = 'input/arrests.csv.gz')
parser$add_argument("--encounters", default = 'input/encounters.csv.gz')
parser$add_argument("--removals", default = 'input/removals.csv.gz')
parser$add_argument("--log", default = 'output/export.log')
parser$add_argument("--output", default = 'output/enforcement.csv.gz')
args <- parser$parse_args()

log_threshold(TRACE)
log_appender(appender_file(args$log))
logger <- layout_glue_generator(format = '{time}|{msg}')
log_layout(logger)

log_info('Log Start Time')

arrests <- read_delim(args$arrests, delim = "|")
log_info('Input file: {args$arrests}')
rows_in <- nrow(arrests)
log_info('Rows in: {rows_in}')

arrests <- arrests %>%
  mutate(apprehension_date = as.Date(apprehension_date, format = "%m/%d/%Y"))
arrests <- arrests %>%
  mutate(quarter = quarter(apprehension_date, with_year = TRUE, fiscal_start = 10), 
         fy = stringr::str_sub(quarter, 1, 4)) %>%
  group_by(apprehension_date, quarter, fy, aor) %>%
  summarize(n_arrests = n()) %>%
  ungroup() %>%
  rename(date = apprehension_date)

encounters <- read_delim(args$encounters, delim = "|")
log_info('Input file: {args$encounters}')
rows_in <- nrow(encounters)
log_info('Rows in: {rows_in}')

encounters <- encounters %>%
  mutate(event_date = as.Date(event_date, format = "%m/%d/%Y"))
encounters <- encounters %>%
  mutate(quarter = quarter(event_date, with_year = TRUE, fiscal_start = 10), 
         fy = stringr::str_sub(quarter, 1, 4)) %>%
  group_by(event_date, quarter, fy, aor) %>%
  summarize(n_encounters = n()) %>%
  ungroup() %>%
  rename(date = event_date)

removals <- read_delim(args$removals, delim = "|")
log_info('Input file: {args$removals}')
rows_in <- nrow(removals)
log_info('Rows in: {rows_in}')

removals <- removals %>%
  mutate(removal_date = as.Date(removal_date, format = "%m/%d/%Y"))
removals <- removals %>% 
  mutate(quarter = quarter(removal_date, with_year = TRUE, fiscal_start = 10), 
         fy = stringr::str_sub(quarter, 1, 4)) %>%
  group_by(removal_date, quarter, fy, aor) %>%
  summarize(n_removals = n()) %>%
  ungroup() %>%
  rename(date = removal_date)

enforcement <- full_join(encounters, arrests, by = c("date", "aor")) %>%
  full_join(., removals, by = c("date", "aor")) %>%
  select(-c(quarter.x, fy.x, quarter.y, fy.y, quarter, fy)) %>%
  mutate(quarter = quarter(date, with_year = TRUE, fiscal_start = 10), 
         fy = stringr::str_sub(quarter, 1, 4)) %>%
  replace(is.na(.), 0)

write_delim(enforcement, args$output, delim='|')
log_info('Rows out: {nrow(enforcement)}')
log_info('Output file: {args$output}')
log_info('Log End Time')

# END.
