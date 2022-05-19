library(tidyverse)
library(lubridate)
library(here)

file_in <- here::here("git", "ice-ero-lesa", 'us', 'export', 'output', 'arrests.csv.gz')
arrests <- read.csv(file_in)
arrests <- arrests %>% filter(aor != "HQ") %>%
  mutate(apprehension_date2 = as.Date(apprehension_date, format = "%m/%d/%Y"))
arrests_join <- arrests %>% mutate(quarter = quarter(apprehension_date2, with_year = TRUE, fiscal_start = 10), 
                                   fy = stringr::str_sub(quarter, 1, 4)) %>%
  group_by(apprehension_date2, quarter, fy, aor) %>%
  summarize(n_arrests = n()) %>%
  rename(date = apprehension_date2)


file_in <- here::here("git", "ice-ero-lesa", 'us', 'export', 'output', 'encounters.csv.gz')
encounters <- read.csv(file_in)
encounters <- encounters %>% filter(aor != "HQ") %>%
  mutate(event_date2 = as.Date(event_date, format = "%m/%d/%Y"))
encounters_join <- encounters %>% mutate(quarter = quarter(event_date2, with_year = TRUE, fiscal_start = 10), 
                                         fy = stringr::str_sub(quarter, 1, 4)) %>%
  group_by(event_date2, quarter, fy, aor) %>%
  summarize(n_encounters = n()) %>%
  rename(date = event_date2)

file_in <- here::here("git", "ice-ero-lesa", 'us', 'export', 'output', 'removals.csv.gz')
removals <- read.csv(file_in, sep = "|")
removals <- removals %>% filter(aor != "HQ") %>%
  mutate(removal_date2 = as.Date(removal_date, format = "%m/%d/%Y"))
removals_join <- removals %>% mutate(quarter = quarter(removal_date2, with_year = TRUE, fiscal_start = 10), 
                                     fy = stringr::str_sub(quarter, 1, 4)) %>%
  group_by(removal_date2, quarter, fy, aor) %>%
  summarize(n_removals = n()) %>%
  rename(date = removal_date2)

enforcement <- full_join(encounters_join, arrests_join, by = c("date", "aor")) %>%
  full_join(., removals_join, by = c("date", "aor")) %>%
  select(-c(quarter.x, fy.x, quarter.y, fy.y, quarter, fy)) %>%
  mutate(quarter = quarter(date, with_year = TRUE, fiscal_start = 10), 
         fy = stringr::str_sub(quarter, 1, 4))

readr::write_delim(enforcement, here::here("git", "ice-ero-lesa", 'us','export', 'output', 'enforcement.csv.gz'),
                   delim='|')