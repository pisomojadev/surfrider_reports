library(plotly)
library(plyr)

print(ToothGrowth)

data_mean <- ddply(ToothGrowth, c("supp", "dose"), summarise, length = mean(len))
data_sd <- ddply(ToothGrowth, c("supp", "dose"), summarise, length = sd(len))
data <- data.frame(data_mean, data_sd$length)
data <- rename(data, c("data_sd.length" = "sd"))
data$dose <- as.factor(data$dose)

p <- plot_ly(data = data[which(data$supp == 'OJ'),], x = ~dose, y = ~length, type = 'bar', name = 'OJ',
             error_y = ~list(array = sd,
                             color = '#000000')) %>%
  add_trace(data = data[which(data$supp == 'VC'),], name = 'VC')

print(p)
orca(p, "./scratchplot.png")

# Create a shareable link to your chart
# Set up API credentials: https://plot.ly/r/getting-started
#chart_link = api_create(p, filename="error-bar")
#chart_link