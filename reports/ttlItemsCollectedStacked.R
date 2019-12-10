library(plotly)
library(dplyr)
library(readr)
library(tidyr)
library(ggplot2)
library(ggthemes)

# read the csv into code and fix any data issues
dataFile <- "./data/beachcleanup.csv"
beachData <- read_csv(dataFile, col_names = TRUE, na = "")
beachData[is.na(beachData)] <- 0
beachData <- beachData[,c("Date", "PlasticBags", "PlasticBottles", "BottleCaps", "PlasticUtensils", "PlasticFoodService", "Straws", 
                          "PlasticFoodWrappers", "SixPacks", "Styrofoam", "Balloons", "FishingBoating", 
                          "GlowSticks", "Syringes", "MiscPlatics", "Cigarettes", "Metals", "Glass", "Paper", 
                          "Fabrics", "Wood", "Animals")]

# create long style data frame from current wide style
itemColNames <- c("PlasticBags", "PlasticBottles", "BottleCaps", "PlasticUtensils", "PlasticFoodService", "Straws", 
                  "PlasticFoodWrappers", "SixPacks", "Styrofoam", "Balloons", "FishingBoating", 
                  "GlowSticks", "Syringes", "MiscPlatics", "Cigarettes", "Metals", "Glass", "Paper", 
                  "Fabrics", "Wood", "Animals")
beachDataL <- gather(beachData, key = "Type", value = "Items" , itemColNames, convert = TRUE)

# Stacked Bar Graph (total # of items collected per beach cleanup)
p <- ggplot(beachDataL, aes(fill=beachDataL$Type, y=beachDataL$Items, x=beachDataL$Date)) +
  geom_bar(position="stack", stat="identity") +
  ggtitle("Beach Cleanup Results") +
  labs(fill = "", y = "Ttl Trash Collected") +
  theme_fivethirtyeight() +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        legend.title = element_text(size = 6), 
        legend.text = element_text(size = 6)) +
  guides(shape = guide_legend(override.aes = list(size = 1)),
         color = guide_legend(override.aes = list(size = 1)))
p <- ggplotly(p)
print(p)