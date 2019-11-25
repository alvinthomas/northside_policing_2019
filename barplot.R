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

arrest_append <- read_excel("00_data/arrests_append.xlsx")

arrest_append2 <- arrest_append
arrest_append2$attached <- as.factor(arrest_append2$attached)
levels(arrest_append2$attached)[levels(arrest_append2$attached)==0] <- "Overall"
levels(arrest_append2$attached)[levels(arrest_append2$attached)==1]   <- "Incident-led\nArrest"

arrest_append2$race <- as.factor(arrest_append2$race)
levels(arrest_append2$race)[levels(arrest_append2$race)=="A"] <- "Asian"
levels(arrest_append2$race)[levels(arrest_append2$race)=="B"]   <- "Black"
levels(arrest_append2$race)[levels(arrest_append2$race)=="H"] <- "Hispanic"
levels(arrest_append2$race)[levels(arrest_append2$race)=="I"]   <- "Native American"
levels(arrest_append2$race)[levels(arrest_append2$race)=="W"] <- "White"
levels(arrest_append2$race)[levels(arrest_append2$race)=="U"]   <- "Unknown"

arrest_append2 %>%
  group_by(attached, arrest_cat, race) %>%
  summarise(count=n()) %>%
  mutate(perc=count/sum(count)) %>%
  ggplot(aes(x = factor(attached), y = perc*100, fill=factor(race))) +
  geom_bar(stat="identity", width = 0.7) +
  facet_wrap(~arrest_cat) +
  theme_minimal() +
  scale_fill_brewer(palette = "Spectral", name = "Race/Ethnicity") +
  labs(x="Overall Arrests vs. Incident-led Arrests",
       y="Percent",
       title="Differences in Race Distribution by Origin of Arrest") +
  theme(legend.position="bottom",
        axis.text.x = element_text(angle = -90, hjust = 1))
ggsave(filename = "02_figs/barplot.png")
