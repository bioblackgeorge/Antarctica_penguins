library(tidymodels)

#' Perform PCA 
#'
#' This function performs Principal Component Analysis (PCA) 
#' on a given dataset without missing values
#' after it first applies Z-Score Normalization
#'
#' @param dataset A data.frame. The dataset to analyze. Must contain numeric columns for PCA.
#' @param num_comp An integer. The number of principal components to retain (default is 2).
#' @return A data.frame object displaying the PCA results.
#' @examples
#' library(tidymodels)
#' 
#' # Perform PCA on the iris dataset
#' pca_data(iris, target_col = "Species", num_comp = 2)
#'
#' @export
perform_pca <- function(dataset, num_comp = 2) {
  
  # select categorical columns
  dataset_categorical <- dataset %>% 
    select(!where(is.numeric))
    
  # select numeric columns
  dataset_numeric <- dataset %>%
    select(where(is.numeric))
  
  # create recipe
  pca_recipe <- recipe(~ ., data = dataset_numeric) %>%
    step_normalize(all_predictors()) %>%
    step_pca(all_predictors(), num_comp = num_comp)
  
  # train the recipe 
  pca_prep <- prep(pca_recipe)
  
  # apply the trained recipe
  pca_results <- bake(pca_prep, new_data = NULL) %>% 
    bind_cols(dataset_categorical)
  
  return(pca_results)
}
