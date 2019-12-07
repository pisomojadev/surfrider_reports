library(plotly)
library(plyr)
library(readr)

#print(ToothGrowth)

dataFile <- "./data/beachcleanup.csv"

#beachdata = read.csv("data/beachcleanup.csv")  # read csv file 
beachData <- read_csv(dataFile)

head(beachData)

x <- list(
  title = "Dates"
)
y <- list(
  title = "Total Items"
)

p <- plot_ly(
  x = as.Date(beachData$Date, "%m/%d/%y"),
  y = beachData$TotalItems,
  name = "Beach Cleanup",
  type = "bar",
  transforms = list(
    list(
      type = 'groupby',
      groups = beachData$Location))
) %>%
layout(xaxis = x, yaxis = y)

print(p)


#data_mean <- ddply(ToothGrowth, c("supp", "dose"), summarise, length = mean(len))
#data_sd <- ddply(ToothGrowth, c("supp", "dose"), summarise, length = sd(len))
#data <- data.frame(data_mean, data_sd$length)
#data <- rename(data, c("data_sd.length" = "sd"))
#data$dose <- as.factor(data$dose)

#data_mean <- ddply(beachData, c("TotalItems", "Date"), summarise, length = mean(len))
#data_sd <- ddply(beachData, c("TotalItems", "Date"), summarise, length = sd(len))
#data <- data.frame(data_mean, data_sd$length)
#data <- rename(data, c("data_sd.length" = "sd"))
#data$dose <- as.factor(data$Date)
#p <- plot_ly(data = data[which(data$TotalItems == 'OJ'),], x = ~dose, y = ~length, type = 'bar', name = 'OJ',
#             error_y = ~list(array = sd,
#                             color = '#000000')) %>%
# add_trace(data = data[which(data$supp == 'VC'),], name = 'VC')

#print(p)
#orca(p, "./scratchplot.png")

# Create a shareable link to your chart
# Set up API credentials: https://plot.ly/r/getting-started
#chart_link = api_create(p, filename="error-bar")
#chart_link