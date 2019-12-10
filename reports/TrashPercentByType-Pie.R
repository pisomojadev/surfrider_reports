library(plotly)
library(plyr)
library(dplyr)
library(readr)
library(tidyr)
library(ggplot2)
library(ggthemes)

# load credentials
source('../config/creds.R')

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

# Pie Chart (Percent type of trash collected)
beachDataL$Type <- as.factor(beachDataL$Type)
pieData <- beachDataL[,c('Type', 'Items')] %>%
  group_by(Type) %>% summarize(sum(Items)) %>%
  setNames(c("Type", "Items"))

# # Add label position
# pieData <- pieData %>%
#   arrange(desc(Type)) %>%
#   mutate(lab.ypos = cumsum(Items) - 0.5*Items)
# 
# p <- ggplot(pieData, aes(x = 2, y = Items, fill = Type)) +
#   geom_bar(stat = "identity", color = "white") +
#   coord_polar("y", start = 0)+
#   geom_text(aes(y = lab.ypos, label = Items), color = "white") +
#   #scale_fill_manual(values = mycols) +
#   theme_void() +
#   xlim(0.5, 2.5)
# 
# p <- ggplotly(p)
# print(p)

p <- plot_ly(pieData, labels = pieData$Type, values = pieData$Items, type = 'pie', textposition = 'inside') %>%
  layout(title = 'Beach Cleanup Items Collected',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
print(p)

options(browser = 'false')
chart_link = api_create(p, filename = "beachcleanupbytype-pie")
chart_link
chart_link