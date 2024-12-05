# load packages ----
library(renv)
library(tidyverse)
library(tidymodels)
library(janitor)
library(plotly)
library(palmerpenguins) 

# load custom modules ----
source("src/data_exploration.R")
source("src/data_cleaning.R")

# load the data ----
data("penguins")


