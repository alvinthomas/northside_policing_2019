list.of.packages <- c("tidyverse", "stringr", "lubridate", "readxl",
  "RColorBrewer", "treemapify")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

library("tidyverse")
library("stringr")
library("lubridate")
library("readxl")
library("RColorBrewer")
library("treemapify")

arrests <- read_excel("00_data/arrests.xlsx")

arrests2 <- arrests %>%
  group_by(arrest_cat, chrgdesc) %>%
  summarise(count = n())

colourCount = length(unique(arrests2$arrest_cat))
getPalette = colorRampPalette(brewer.pal(11, "Spectral"))

ggplot(arrests2,
       aes(area = count,
           fill = arrest_cat,
           label = chrgdesc,
           subgroup = arrest_cat)) +
  geom_treemap() +
  geom_treemap_subgroup_border() +
  geom_treemap_subgroup_text(place = "centre", grow = T, alpha = 0.5, colour =
                               "black", fontface = "italic", min.size = 0) +
  geom_treemap_text(colour = "white", place = "topleft", reflow = T) +
  scale_fill_manual(name = "Arrest Category", values = getPalette(colourCount))
ggsave(filename = "02_figs/arrests.png")

incidents <- read_excel("00_data/incidents.xlsx")

incidents <- incidents %>%
  filter(incident_cat != "Information") %>%
  filter(incident_cat != "Non-Crime")

incidents2 <- incidents %>%
  group_by(incident_cat, incidentdesc) %>%
  summarise(count = n())

colourCount = length(unique(incidents2$incident_cat))
getPalette = colorRampPalette(brewer.pal(11, "Spectral"))

ggplot(incidents2,
       aes(area = count,
           fill = incident_cat,
           label = incidentdesc,
           subgroup = incident_cat)) +
  geom_treemap() +
  geom_treemap_subgroup_border() +
  geom_treemap_subgroup_text(place = "centre", grow = T, alpha = 0.5, colour =
                               "black", fontface = "italic", min.size = 0) +
  geom_treemap_text(colour = "white", place = "topleft", reflow = T) +
  scale_fill_manual(name = "Incident Category", values = getPalette(colourCount))
ggsave(filename = "02_figs/incidents.png")
