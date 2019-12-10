library(plotly)
library(plyr)
library(readr)
library(tidyr)
library(ggplot2)
library(ggthemes)

### REQUIREMENTS ###
#total # of items collected per beach cleanup 
#total # of items per volunteer per beach cleanup location
#items per volunteer per beach cleanup 
#total volunteers per beach cleanup location 
#specific item total averages per beach for top items of concern - butts, foam, etc. 

# read the csv into code and fix any data issues
dataFile <- "./data/beachcleanup.csv"
beachData <- read_csv(dataFile, col_names = TRUE, na = "")
beachData[is.na(beachData)] <- 0

# create long style data frame from current wide style
itemColNames <- c("PlasticBags", "PlasticBottles", "BottleCaps", "PlasticUtensils", "PlasticFoodService", "Straws", 
                   "PlasticFoodWrappers", "SixPacks", "Styrofoam", "Balloons", "FishingBoating", 
                   "GlowSticks", "Syringes", "MiscPlatics", "Cigarettes", "Metals", "Glass", "Paper", 
                   "Fabrics", "Wood", "Animals")
beachDataL <- gather(beachData, key = "Type", value = "Items" , itemColNames)

# Stacked Bar Graph (total # of items collected per beach cleanup)
p <- ggplot(beachDataL, aes(fill=beachDataL$Type, y=beachDataL$Items, x=beachDataL$Date)) + 
  geom_bar(position="stack", stat="identity") +
  ggtitle("Beach Cleanup Results") +
  labs(fill = "", y = "Ttl Trash Collected") +
  theme_fivethirtyeight() +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())
p <- ggplotly(p)
print(p)


#chart_link