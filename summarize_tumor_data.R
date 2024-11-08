# Install and load necessary packages
required_packages <- c("dplyr", "tibble", "datateachr", "rlang")
for (pkg in required_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg)
  }
  library(pkg, character.only = TRUE)
}

# Load the cancer_sample dataset
data("cancer_sample", package = "datateachr")

# Define the summarize_tumor_data function
summarize_tumor_data <- function(data, column_name) {
  # Check if the data is empty
  if (nrow(data) == 0) {
    stop("The dataset is empty.")
  }

  # Check if the column_name exists in the dataset
  if (!column_name %in% names(data)) {
    stop("The specified column does not exist in the dataset.")
  }

  # Ensure the selected column is numeric
  if (!is.numeric(data[[column_name]])) {
    stop("The selected column must be numeric. Non-numeric data cannot be summarized.")
  }

  # Summarize the data using dplyr functions
  summary <- data %>%
    group_by(diagnosis) %>%
    summarise(
      mean = mean(.data[[column_name]], na.rm = TRUE),
      median = median(.data[[column_name]], na.rm = TRUE),
      sd = sd(.data[[column_name]], na.rm = TRUE),
      .groups = 'drop'
    ) %>%
    as_tibble()

  # Print a message indicating successful summarization
  message("Data summarized successfully for column: ", column_name)

  return(summary)
}

# Example usage
# Summarize the 'radius_mean' column and display results
tumor_summary <- summarize_tumor_data(cancer_sample, "radius_mean")
print(tumor_summary)
