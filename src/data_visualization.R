library(corrr)

#' Correlation Plot for Numeric Columns
#'
#' This function generates a correlation plot for the numeric columns 
#' in a given dataset, ignoring rows with missing values.
#'
#' @param dataset A data.frame. The input dataset to analyze.
#' @param title A character string specifying the title of the output file
#' @param output_path A character string specifying the full path (including the file name) where the output file will be saved.
#' @return A correlation plot showing relationships between numeric variables.
#' @details
#' This function selects numeric columns from the input dataset, removes rows with 
#' missing values, computes the correlation matrix, and visualizes it using 
#' the `corrr` package. Highly correlated variables are grouped together for better clarity.
#'
#' @examples
#' library(corrr)
#' corr_plot(iris)
#' 
corr_plot <- function(dataset, title, output_path){
  
  # numeric cols without missing values
  dataset_numeric <- dataset %>%
    dplyr::select(where(is.numeric)) %>%
    na.omit()  
  
  # correlation matrix
  correlation_matrix <- dataset_numeric %>%
    correlate() %>% 
    rearrange() %>%  # group highly correlated together
    rplot()
  
  # correlation plot
  correlation_plot <- correlation_matrix +
    ggtitle(title)+
    theme(text = element_text(size = 15),
          aspect.ratio = 0.618)
  
  # save the correlation plot
  ggsave(output_path, plot = correlation_plot, width = 10, height = 8) 
  
  return(correlation_plot)
}
