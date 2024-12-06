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
  clean_names() 

# data exploration
explore_data(df, output_file = "results/dataset_summary.txt")

# correlation plot
corr_plot(df, title = "Correlation plot of the penguin measurements", output_path = "results/correlation_plot.jpg")

# impute missing values via knn method
df_imputed <- knn_impute_data(df, target_col = "species")

# perform pca on the imputed data
df_imputed_pca <- perform_pca(df_imputed, num_comp = 3)

# create 3D scatterplot for pca
pca_plot(pca_data = df_imputed_pca,
         title = "PCA scatterplot of the penguin measurements",
         output_path = "results/pca_plot.html",
         color_column = "species",
         color_palette = c("Adelie" = "blue", "Gentoo" = "red", "Chinstrap" = "green"))
