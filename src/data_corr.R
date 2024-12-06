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
corr_plot <- function(dataset, title, output_path){
  
  # numeric cols without missing values
  dataset_numeric <- dataset %>%
    dplyr::select(where(is.numeric)) %>%
    na.omit()  
  
  # cor matrix
  correlation_matrix <- dataset_numeric %>%
    correlate() %>% 
    rearrange() %>%  # group highly correlated together
    rplot()
  
  # cor plot
  correlation_plot <- correlation_matrix +
    ggtitle(title)
  
  # save the correlation plot
  ggsave(output_path, plot = correlation_plot, width = 10, height = 8) 
  
  return(correlation_plot)
}
