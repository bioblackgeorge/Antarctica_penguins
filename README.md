# Penguin Data Analysis with PLS

This repository contains an R-based workflow for analyzing penguin data using Partial Least Squares (PLS) analysis. The project includes data exploration, visualization, cleaning, and statistical analysis. 

Below is a detailed description of the key scripts and their functionality.

## Dataset description
Focuses on three species of penguins (Adelie, Chinstrap, and Gentoo) found in the Palmer Archipelago, Antarctica. 
It contains biological and physical measurements by Dr. Kristen Gorman and the Palmer Station, Antarctica LTER, a member of the Long Term Ecological Research Network.

The dataset includes the following attributes:

Species: The species of the penguin (Adelie, Chinstrap, or Gentoo). <br>
Island: The island in the Palmer Archipelago where the penguin was observed (e.g., Torgersen, Biscoe, Dream). <br>
Bill Length (mm): Length of the penguin's bill. <br>
Bill Depth (mm): Depth of the penguin's bill. <br>
Flipper Length (mm): Length of the penguin's flipper. <br>
Body Mass (g): Body mass of the penguin. <br>
Sex: The sex of the penguin (male or female). <br>
Year: The year when the data was collected.

---

## **Main Script: `main.R`**

This script orchestrates the data processing pipeline, combining various modular functions and classes to execute the complete analysis.

### **Key Steps:**
1. **Load Required Libraries**:
   Utilizes libraries like `tidyverse`, `janitor`, and `palmerpenguins` for data manipulation and visualization.
   
2. **Load Custom Modules**: Sources the project-specific functions and classes from:
   - `data_exploration.R`
   - `data_visualization.R`
   - `data_cleaning.R`
   - `data_analysis.R`

3. **Data Loading and Cleaning**:
   Loads the penguin dataset, cleans column names, and removes irrelevant columns.

4. **Data Exploration**:
   Generates a dataset summary and saves it to `results/dataset_summary.txt`.

5. **Data Visualization**:
   Creates and saves a correlation plot of numerical variables as `results/correlation_plot.jpg`.

6. **Data Imputation**:
   Handles missing values using k-Nearest Neighbors (k-NN) imputation.

7. **Partial Least Squares (PLS) Analysis**:
   - Prepares PLS data using the `PLSanalysis` R6 class.
   - Generates a 3D scatterplot of PLS components and a loadings plot for top variables.

---

## **Modular Scripts**

### **1. Data Exploration: `src/data_exploration.R`**
Provides a descriptive summary of the dataset:
- Displays the first few rows, structure, and summary statistics.
- Identifies missing and duplicate values.
- Saves the output to a specified file.

### **2. Data Visualization: `src/data_visualization.R`**
Creates a correlation plot of numeric variables:
- Uses the `corrr` package to compute and visualize correlations.
- Groups highly correlated variables for clarity.
- Saves the plot as an image.

### **3. Data Cleaning: `src/data_cleaning.R`**
Imputes missing data with k-NN:
- Excludes the target variable from imputation.
- Uses the `tidymodels` package to apply a k-NN-based recipe.
- Returns the cleaned dataset.

### **4. Data Analysis with PLS: `src/data_analysis.R`**
Defines an R6 class `PLSanalysis` for performing PLS analysis:
- **Key Methods**:
  - `prepare_pls()`: Prepares data with Z-Score normalization and PLS transformation.
  - `get_pls_data()`: Retrieves PLS-transformed data.
  - `pls_plot()`: Generates a 3D scatterplot of PLS components.
  - `pls_loadings_plot()`: Visualizes PLS loadings for top variables.

---


## **Results**

The analysis pipeline generates the following results:
1. **Dataset Summary**: `results/dataset_summary.txt`
2. **Correlation Plot**: `results/correlation_plot.jpg`
3. **PLS 3D Scatterplot**: `results/pls_plot.html`
4. **PLS Loadings Plot**: `results/pls_loadings.jpg`

---

project_structure:
  - main.R: "Main analysis script"
  - src:
      - data_exploration.R: "Data exploration functions"
      - data_visualization.R: "Data Visualization functions"
      - data_cleaning.R: "Data cleaning functions"
      - data_analysis.R: "Data Analysis with PLS class"
  - results:
      - dataset_summary.txt: "Output summary of the dataset"
      - correlation_plot.jpg: "Correlation plot image"
      - pls_plot.html: "PLS plot in HTML format"
      - pls_loadings.jpg: "PLS loadings plot image"
  - README.md: "Project description"

---

## **Install Required Packages**
   Run the following to install and restore required dependencies:
   ```
   renv::restore()
  ```

## **Dependencies**
- R (≥ 4.0.0)
- Packages: 
  - `renv`
  - `tidyverse`
  - `janitor`
  - `palmerpenguins`
  - `corrr`
  - `tidymodels`
  - `plotly`
  - `mixOmics`
  - `ggplot2`


# Dataset references

## Data originally published in:
- Gorman KB, Williams TD, Fraser WR (2014). Ecological sexual dimorphism and environmental variability within a community of Antarctic penguins (genus *Pygoscelis*). *PLoS ONE* 9(3):e90081. [https://doi.org/10.1371/journal.pone.0090081](https://doi.org/10.1371/journal.pone.0090081)

## Data citations:
### Adélie penguins:
- Palmer Station Antarctica LTER and K. Gorman, 2020. Structural size measurements and isotopic signatures of foraging among adult male and female Adélie penguins (*Pygoscelis adeliae*) nesting along the Palmer Archipelago near Palmer Station, 2007-2009 ver 5. Environmental Data Initiative. [https://doi.org/10.6073/pasta/98b16d7d563f265cb52372c8ca99e60f](https://doi.org/10.6073/pasta/98b16d7d563f265cb52372c8ca99e60f) (Accessed 2020-06-08).

### Gentoo penguins:
- Palmer Station Antarctica LTER and K. Gorman, 2020. Structural size measurements and isotopic signatures of foraging among adult male and female Gentoo penguin (*Pygoscelis papua*) nesting along the Palmer Archipelago near Palmer Station, 2007-2009 ver 5. Environmental Data Initiative. [https://doi.org/10.6073/pasta/7fca67fb28d56ee2ffa3d9370ebda689](https://doi.org/10.6073/pasta/7fca67fb28d56ee2ffa3d9370ebda689) (Accessed 2020-06-08).

### Chinstrap penguins:
- Palmer Station Antarctica LTER and K. Gorman, 2020. Structural size measurements and isotopic signatures of foraging among adult male and female Chinstrap penguin (*Pygoscelis antarcticus*) nesting along the Palmer Archipelago near Palmer Station, 2007-2009 ver 6. Environmental Data Initiative. [https://doi.org/10.6073/pasta/c14dfcfada8ea13a17536e73eb6fbe9e](https://doi.org/10.6073/pasta/c14dfcfada8ea13a17536e73eb6fbe9e) (Accessed 2020-06-08).
