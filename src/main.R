# load packages ----
library(renv)
library(tidyverse)
library(janitor)
library(palmerpenguins)

# load custom modules ----
source("src/data_exploration.R")
source("src/data_visualization.R")
source("src/data_cleaning.R")
source("src/data_analysis.R")

# load the data ----
df <- palmerpenguins::penguins %>% 
  clean_names() %>% 
  dplyr::select(-year) # year is not relevant to our analysis

# data exploration ----
explore_data(df, output_path = "results/dataset_summary.txt")

# correlation plot ----
corr_plot(df, title = "Correlation plot of the penguin measurements",
          output_path = "results/correlation_plot.jpg")

# impute missing values ----
df_imputed <- knn_impute_data(df, target_col = "species")

# perform pls analysis ----

## create instance ----
pls_instance <- PLSanalysis$new(dataset = df_imputed, target_col = "species", num_comp = 3)

## prepare pls ----
pls_instance$prepare_pls()

## perform pls ----
pls_data <- pls_instance$get_pls_data()

## scatterplot pls ----
color_palette <- c("Adelie" = "blue", "Gentoo" = "red", "Chinstrap" = "green")

scatter_plot <- pls_instance$pls_plot(
  color_palette = color_palette,
  title = "PLS scatterplot of the penguin measurements",
  output_path = "results/pls_plot.html"
)

# loadings of pls for top 5 variables per component
loadings <- pls_instance$pls_loadings_plot(
  num_vars_per_comp = 5,
  title = "PLS loadings plot",
  output_path = "results/pls_loadings.jpg"
)