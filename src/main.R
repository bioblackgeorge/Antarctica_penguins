# load packages ----
library(renv)
library(tidyverse)
library(janitor)
library(palmerpenguins) 

# load custom modules ----
source("src/data_exploration.R")
source("src/data_corr.R")
source("src/data_cleaning.R")
source("src/data_analysis.R")

# load the data ----
df <- palmerpenguins::penguins %>% 
  clean_names() 

# data exploration
explore_data(df)

# correlation plot
cor_plot <- corr_data(df)

# impute missing values via knn method
df_imputed <- knn_impute_data(df, target_col = "species")

# impute missing values via knn method
df_imputed_pca <- perform_pca(df_imputed, num_comp = 3)
