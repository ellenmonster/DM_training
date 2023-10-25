### IMD DATA MANAGERS TRAINING
### INTRO. TO R     
### OCTOBER 25, 2023

## Getting started ----
# Clear the global environment
rm(list = ls()) 

# Load packages
library(tidyverse)

## Working with vectors ----


## Working with data frames ----

# Import the park_visits data
dat <- read_csv("Data_in/park_visits.csv")

# Check the data
summary(dat)

# Show them the plot we want to create (the end goal) and outline the steps to get there...

# What are our choices for region names, and how many records per region?
table(dat$region)

# Just get data for the MW region (dplyr and piping)
subdat <- dat %>%
  dplyr::filter(region == "MW" & year != "Total") %>%
  dplyr::select(year, unit_code, unit_name, visitors) %>%
  dplyr::mutate(
    year = as.integer(year),
    visitors_1000 = visitors/1000) %>%
  dplyr::arrange(unit_code, year)

## Plot the data ----

# Simple plot, with base R

visitors_plot <- ggplot(subdat, aes(x = year, y = visitors_1000, colour = unit_code)) + 
  geom_line() +
  labs(title = "Annual number of visitors to National Parks in Midwest Region", x = "Year", y = "Visitors (1000's)") +
  theme_bw()

# Save the plot (easy way)-- create a subfolder called Plots, and size the plots pane for preferred export size
# **Plots > Export > Save as Image (choose location, filename, image type) 

# And JUST FOR FUN from the plotly package (need to install and load this package)
plotly::ggplotly(visitors_plot)
