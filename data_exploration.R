explore_data <- function(dataset){
  # dataset is of class data.frame
  # provides description of the dataset
  # checks for duplicate rows and missing values
  
  # prints the first rows, structure and summary statistics of the specified dataset.
    print("Displaying the first rows:")
  print(head(dataset)) 
  cat("\n")  
  
  print("Structure:")
  print(str(dataset)) 
  cat("\n")  
  
  print("Summary statistics:")
  print(summary(dataset)) 
  cat("\n")
  
  # Check for missing values
  missing_values <- sum(is.na(dataset))
  if (missing_values > 0) {
    print(paste("The dataset contains", missing_values, "missing values"))
  } else {
    print("No missing values were found")
  }

  # Check for duplicate rows
  duplicate_rows <- nrow(dataset) - nrow(unique(dataset))
  if (duplicate_rows > 0) {
    print(paste("The dataset contains", duplicate_rows, "duplicate rows"))
  } else {
    print("No duplicate rows were found")
  }

}
