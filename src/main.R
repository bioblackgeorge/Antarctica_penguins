# load packages ----
library(renv)
library(tidyverse)
library(tidymodels)
library(janitor)
library(plotly)
library(palmerpenguins) 

# load custom modules ----
source("src/data_exploration.R")
source("src/data_corr.R")

# load the data ----
data("penguins")

# data exploration
explore_data(penguins)

# correlation plot
corr_data(penguins)


