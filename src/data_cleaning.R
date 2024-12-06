library(tidymodels)

#' Impute Missing Data Using k-Nearest Neighbors
#'
#' This function imputes missing values in a dataset (excluding the target variable) using the k-nearest neighbors (k-NN) method 
#' from the `tidymodels` framework.
#'
#' @param dataset A data.frame. The dataset to impute.
#' @param target_col A character string. The name of the target column (outcome variable) that will not be imputed.
#' @return A data.frame with missing values imputed for the predictor columns.
#' @details
#' This function uses a `recipe` from the `tidymodels` package to impute missing values in all 
#' predictor columns (`all_predictors()`) with k-NN imputation. By default, the number of neighbors 
#' is set to 5 (`neighbors = 5`).
#'
#' @examples
#' library(tidymodels)
#' library(palmerpenguins)
#' knn_impute_data(palmerpenguins::penguins, target_col = "species")
#'
knn_impute_data <- function(dataset, target_col){
  
  # allow the user to specify the target column
  if (!target_col %in% names(dataset)) {
    stop("The specified target column does not exist.")
  }
  
  formula <- as.formula(paste(target_col, "~ ."))
  
  # create recipe
  impute_rec <- recipe(formula, data = dataset) %>%
    step_impute_knn(all_predictors(), neighbors = 5)
  
  # train the recipe 
  impute_prep <- prep(impute_rec, training = dataset)
  
  # apply the trained recipe
  imputed_results <- bake(impute_prep, new_data = NULL)
  
  return(imputed_results)
  
}
