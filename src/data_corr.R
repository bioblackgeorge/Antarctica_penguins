library(corrr)

#' Correlation Plot for Numeric Columns
#'
#' This function generates a correlation plot for the numeric columns 
#' in a given dataset, ignoring rows with missing values.
#'
#' @param dataset A data.frame. The input dataset to analyze.
#' @return A correlation plot showing relationships between numeric variables.
#' @details
#' This function selects numeric columns from the input dataset, removes rows with 
#' missing values, computes the correlation matrix, and visualizes it using 
#' the `corrr` package. Highly correlated variables are grouped together for better clarity.
#'
#' @examples
#' library(corrr)
#' corr_data(iris)
#' 
corr_data <- function(dataset){
  
  # numeric cols without missing values
  dataset_numeric <- dataset %>%
    dplyr::select(where(is.numeric)) %>%
    na.omit()  
  
  # cor matrix
  cor_matrix <- dataset_numeric %>%
    correlate()
  
  # cor plot
  cor_matrix %>%
    rearrange() %>%  # group highly correlated together
    rplot()          
  
}


