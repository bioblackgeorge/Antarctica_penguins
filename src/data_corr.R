library(corrr)

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


