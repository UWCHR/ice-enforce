library(dplyr)

arrests <- read.csv("../clean/output/arrests.csv.gz", sep = "|")
arrests <- arrests %>% filter(aor != "", apprehension_landmark != "DO NOT USE")
write.csv(arrests, file = gzfile("../export/output/arrests.csv.gz"))

encounters <- read.csv("../clean/output/encounters.csv.gz", sep = "|")
encounters <- encounters %>% filter(aor != "", landmark != "DO NOT USE")
write.csv(encounters, file = gzfile("../export/output/encounters.csv.gz"))

#removals <- read.csv("../clean/output/removals.csv.gz", sep = "|")

