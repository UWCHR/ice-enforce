library(dplyr)

arrests <- read.csv("../clean/output/arrests.csv.gz", sep = "|")
arrests <- arrests %>% filter(aor != "", apprehension_landmark != "DO NOT USE")

encounters <- read.csv("../clean/output/encounters.csv.gz", sep = "|")
