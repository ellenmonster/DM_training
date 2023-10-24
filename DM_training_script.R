## Save your script...

# Load tidyverse
library(tidyverse)

# Import the park_visits data
dat <- read_csv("Data_in/park_visits.csv")

# Check the data
glimpse(dat)
summary(dat)

# Extract a subset of the data (using dplyr functions and piping instead of base R)

# What are our choices for region names?
table(dat$region)

# Just get data for the MW region
subdat <- dat %>%
  dplyr::filter(region == "MW" & year != "Total") %>%
  dplyr::select(year, unit_code, unit_name, visitors) %>%
  dplyr::mutate(
    year = as.integer(year),
    visitors_1000 = visitors/1000) %>%
  dplyr::arrange(unit_code, year)

# plot the data
visitors_plot <- ggplot(subdat, aes(year, visitors_1000, colour = unit_code)) + 
  geom_line() +
  labs(title = "Annual number of visitors to National Parks in Midwest Region", x = "Year", y = "Visitors (1000's)") +
  theme_bw()

# save the plot (easy way)
# **Plots > Export > Save as Image (choose location, filename, image type)

# And JUST FOR FUN from the plotly package (need to install and load this package)
plotly::ggplotly(visitors_plot)
