list.of.packages <- c("shiny", "shinydashboard", "DT",
  "tidyverse", "stringr", "lubridate", "rsconnect", "readxl",
  "RColorBrewer", "treemapify")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

library("shiny")
library("shinydashboard")
library("DT")
library("tidyverse")
library("stringr")
library("lubridate")
library("rsconnect")
library("readxl")
library("RColorBrewer")
library("treemapify")

make_graph1 <- function(dateRange, options) {
  arrests <- read_excel("00_data/arrests.xlsx")
  arrests$yy <- as.Date(ymd_hms(arrests$date_arr))

  arrests2 <- arrests %>%
    filter(arrest_cat %in% options) %>%
    filter(yy >= dateRange[1] & yy <= dateRange[2]) %>%
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
}

make_graph2 <- function(dateRange, options) {
  incidents <- read_excel("00_data/incidents.xlsx")
  incidents$yy <- as.Date(mdy_hm(incidents$date_rept))

  incidents2 <- incidents %>%
    filter(incident_cat %in% options) %>%
    filter(yy >= dateRange[1] & yy <= dateRange[2]) %>%
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
}

get_dat1 <- function(dateRange, options) {
  arrests <- read_excel("00_data/arrests.xlsx")
  arrests$yy <- as.Date(ymd_hms(arrests$date_arr))

  arrests2 <- arrests %>%
    filter(arrest_cat %in% options) %>%
    filter(yy >= dateRange[1] & yy <= dateRange[2]) %>%
    group_by(arrest_cat, chrgdesc) %>%
    summarise(count = n())
  return(arrests2)
}

get_dat2 <- function(dateRange, options) {
  incidents <- read_excel("00_data/incidents.xlsx")
  incidents$yy <- as.Date(mdy_hm(incidents$date_rept))

  incidents2 <- incidents %>%
    filter(incident_cat %in% options) %>%
    filter(yy >= dateRange[1] & yy <= dateRange[2]) %>%
    group_by(incident_cat, incidentdesc) %>%
    summarise(count = n())
  return(incidents2)
}
