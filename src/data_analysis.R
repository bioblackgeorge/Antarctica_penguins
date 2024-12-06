library(R6)
library(tidymodels)
library(plotly)
library(learntidymodels)
library(mixOmics)

#' PLSanalysis: A Class for Performing and Visualizing PLS analysis
#'
#' This R6 class provides functionality to perform Partial Least Squares (PLS) analysis,
#' retrieve PLS data, and generate visualizations of PLS components and loadings.
PLSanalysis <- R6Class(
  "PLSanalysis",
  public = list(
    dataset = NULL,
    target_col = NULL,
    num_comp = NULL,
    dataset_categorical = NULL,
    pls_prep = NULL,
    pls_data = NULL,
    
    #' @description
    #' Constructor for the PLSanalysis class.
    #'
    #' @param dataset A data.frame. The dataset to analyze.
    #' @param target_col A string. The name of the response variable.
    #' @param num_comp An integer. Number of components to retain. Default is 3.
    initialize = function(dataset, target_col, num_comp = 3) {
      self$dataset <- dataset
      self$target_col <- target_col
      self$num_comp <- num_comp
    },
    
    #' @description
    #' Prepare a blueprint for Partial Least Squares (PLS) using the dataset.
    #'
    #' This method separates the dataset into predictors and response, applies Z-Score normalization,
    #' and performs PLS on the data.
    prepare_pls = function() {
      
      formula <- as.formula(paste(self$target_col, "~ ."))
      
      # PLS recipe
      pls_recipe <- recipe(formula, data = self$dataset) %>%
        step_normalize(all_numeric_predictors()) %>%  # Normalize numeric predictors
        step_pls(all_numeric_predictors(),
                 outcome = self$target_col,
                 num_comp = self$num_comp)
      
      self$pls_prep <- prep(pls_recipe)
      message("PLS analysis prepared...")
    },
    
    #' @description
    #' Retrieve the PLS-transformed dataset.
    #'
    #' @return A data.frame with PLS components and original categorical columns.
    get_pls_data = function() {
      
      self$pls_data <- bake(self$pls_prep, new_data = NULL)
      
      message("PLS analysis successfully performed! Here is a sample...")
      print(head(self$pls_data))
      return(self$pls_data)
    },
    
    #' @description
    #' Create and save a 3D scatter plot of PLS results.
    #'
    #' @param color_palette A named vector. Defines the color for each unique value in the color column.
    #' @param title A string. The title of the 3D scatter plot.
    #' @param output_path A string. Path to save the plot.
    pls_plot = function(color_palette, title, output_path) {
      
      plot <- plot_ly(
        self$pls_data,
        x = ~ PLS1,
        y = ~ PLS2,
        z = ~ PLS3,
        color = self$pls_data[[self$target_col]],
        colors = color_palette,
        type = "scatter3d",
        mode = "markers",
        marker = list(size = 5)
      ) %>%
        layout(title = list(text = title))
      
      htmlwidgets::saveWidget(as_widget(plot), file = output_path)
      print(plot)
      return(plot)
    },
    
    #' @description
    #' Create and save PLS loadings plots for top variables.
    #'
    #' @param num_vars_per_comp An integer. Number of top variables per component.
    #' @param title A string. Title of the plots.
    #' @param output_path A string. Path to save the plot.
    #' @return A ggplot object containing the PLS loadings visualization.
    pls_loadings_plot = function(num_vars_per_comp, title, output_path) {
      
      # Generate the loadings plot
      plot <- self$pls_prep %>%
        plot_top_loadings(
          n = num_vars_per_comp, 
          type = "pls"
        ) +
        ggtitle(title) +
        theme(text = element_text(size = 20))
      
      # Save the plot
      ggsave(
        filename = output_path,
        plot = plot,
        width = 20,
        height = 10,
        dpi = 300
      )
      
      print(plot)
      return(plot)
    }
  )
)
