#' Explore and Summarize Dataset
#'
#' This function provides a descriptive overview of a dataset, including structure, 
#' summary statistics, and missing or duplicate values checks.
#'
#' @param dataset A data.frame. The dataset to explore.
#' @return None. Prints the first few rows, structure, summary statistics, 
#'         and details about missing and duplicate values in the console.
#' @examples
#' explore_data(iris)
#' 
explore_data <- function(dataset, output_file){
  
  sink(output_file)  # redirect output to a file
  
  # print the first rows, structure and summary statistics of the specified dataset.
  print("Displaying the first rows:")
  print(head(dataset)) 
  cat("\n")  
  
  print("Structure:")
  print(str(dataset)) 
  cat("\n")  
  
  print("Summary statistics:")
  print(summary(dataset)) 
  cat("\n")
  
  # check for missing values
  missing_values <- sum(is.na(dataset))
  if (missing_values > 0) {
    print(paste("The dataset contains", missing_values, "missing values"))
  } else {
    print("No missing values were found")
  }

  # check for duplicate rows
  duplicate_rows <- nrow(dataset) - nrow(unique(dataset))
  if (duplicate_rows > 0) {
    print(paste("The dataset contains", duplicate_rows, "duplicate rows"))
  } else {
    print("No duplicate rows were found")
  }
  
  sink() # end redirecting
}
