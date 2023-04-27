# ---
# title: "Summarize and export ICE enforcement data"
# date: "2022-09-23"
# author: "PN"
# copyright: UWCHR, GPL 3.0
# ---

library(pacman)
pacman::p_load("argparse", "tidyverse", "lubridate", "logger")

parser <- ArgumentParser()
parser$add_argument("--arrests", default = 'us-fy12-23/export/input/arrests.csv.gz')
parser$add_argument("--encounters", default = 'us-fy12-23/export/input/encounters.csv.gz')
parser$add_argument("--removals", default = 'us-fy12-23/export/input/removals.csv.gz')
parser$add_argument("--log", default = 'us-fy12-23/export/output/export.log')
parser$add_argument("--output", default = 'us-fy12-23/export/output/enforcement.csv.gz')
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
  mutate(arrest_date = as.Date(arrest_date, format = "%m/%d/%Y"))

arrests_by_method <- arrests %>% 
  mutate(arrest_method = tolower(arrest_method)) %>%
  group_by(arrest_date, aor, arrest_method) %>% 
  summarise(n = n())

write_delim(arrests_by_method, 'output/arrests_by_method.csv.gz', delim='|')

arrests_by_disp <- arrests %>% 
  mutate(processing_disposition = tolower(processing_disposition)) %>%
  group_by(arrest_date, aor, processing_disposition) %>% 
  summarise(n = n())

write_delim(arrests_by_disp, 'output/arrests_by_disposition.csv.gz', delim='|')

arrests <- arrests %>%
  mutate(quarter = quarter(arrest_date, with_year = TRUE, fiscal_start = 10), 
         fy = stringr::str_sub(quarter, 1, 4)) %>%
  group_by(arrest_date, quarter, fy, aor) %>%
  summarize(n_arrests = n()) %>%
  ungroup() %>%
  rename(date = arrest_date)

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

# Removal date is not present in FY12-13 data, so we use departed date instead
removals <- removals %>%
  mutate(removal_date = as.Date(removal_date, format = "%m/%d/%Y"),
         departed_date = as.Date(departed_date, format = "%m/%d/%Y"),
         date = coalesce(departed_date, removal_date),
         processing_disp = coalesce(processing_disposition_code, processing_disposition))

removals_by_disp <- removals %>% 
  mutate(processing_disp = tolower(processing_disp)) %>%
  group_by(date, aor, processing_disp) %>% 
  summarise(n = n())

write_delim(removals_by_disp, 'output/removals_by_disposition.csv.gz', delim='|')

removals <- removals %>% 
  mutate(quarter = quarter(date, with_year = TRUE, fiscal_start = 10), 
         fy = stringr::str_sub(quarter, 1, 4)) %>%
  group_by(date, quarter, fy, aor) %>%
  summarize(n_removals = n()) %>%
  ungroup()

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
