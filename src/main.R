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
df <- palmerpenguins::penguins %>% 
  clean_names() 

# data exploration
explore_data(df)

# correlation plot
corr_data(df)

# impute missing values via knn method
knn_impute_data(df)

