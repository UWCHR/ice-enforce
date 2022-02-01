library(dplyr)

arrests <- read.csv("../clean/output/arrests.csv.gz", sep = "|")
arrests <- arrests %>% filter(aor != "")
write.csv(arrests, file = gzfile("../export/output/arrests.csv.gz"), row.names = F)

encounters <- read.csv("../clean/output/encounters.csv.gz", sep = "|")
encounters <- encounters %>% filter(aor != "")
write.csv(encounters, file = gzfile("../export/output/encounters.csv.gz"), row.names = F)

#removals <- read.csv("../clean/output/removals.csv.gz", sep = "|")


