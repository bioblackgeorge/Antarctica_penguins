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
    ggtitle(title)
  
  # save the correlation plot
  ggsave(output_path, plot = correlation_plot, width = 10, height = 8) 
  
  return(correlation_plot)
}

#' Create and Save a 3D PCA Scatter Plot
#'
#' This function generates an interactive 3D scatter plot from PCA data using plotly,
#' saves the plot as an HTML file, and returns the plot object.
#'
#' @param pca_data A data frame containing the PCA results. Must include columns for PC1, PC2, PC3, and the specified color column.
#' @param title A character string specifying the title of the plot.
#' @param output_path A character string specifying the full path (including the file name) where the HTML file will be saved.
#' @param color_column A character string specifying the name of the column to use for color coding the points.
#' @param color_palette A named vector specifying colors for the unique values in the color column.
#'
#' @return The plot object (of class `plotly`) is returned invisibly.
#' 
#' @examples
#' pca_plot(
#'   pca_data = penguins_pca_data,
#'   title = "3D PCA Plot of Penguin Measurements",
#'   output_path = "plots/penguin_pca.html",
#'   color_column = "species",
#'   color_palette = c("Adelie" = "blue", "Gentoo" = "red", "Chinstrap" = "green")
#' )
#' 
pca_plot <- function(pca_data, title, output_path, color_column, color_palette) {
  
  # allow the user to specify the color column
  if (!color_column %in% colnames(pca_data)) {
    stop("The specified color column does not exist.")
  }
  
  # generate 3D scatter plot
  plot <- plot_ly(
    pca_data,
    x = ~PC1,
    y = ~PC2,
    z = ~PC3,
    color = pca_data[[color_column]],
    colors = color_palette,
    type = "scatter3d",
    mode = "markers",
    marker = list(size = 5)
  ) %>%
    layout(
      title = title,
      scene = list(
        xaxis = list(title = "Principal Component 1"),
        yaxis = list(title = "Principal Component 2"),
        zaxis = list(title = "Principal Component 3")
      )
    )
  
  # save the plot as an HTML file
  htmlwidgets::saveWidget(plot, file = output_path)
  
  print(plot)
  
  return(plot)
}
