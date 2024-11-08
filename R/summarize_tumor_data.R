#' Summarize Tumor Data
#' @description
#' This function summarizes a specified numeric column in the dataset, grouped by 'diagnosis'.
#' It calculates the mean, median, and standard deviation for each diagnosis group.
#'
#' @param data A data frame containing the tumor data.
#' @param column_name A character string specifying the name of the numeric column to summarize.
#' @return A tibble with columns for the mean, median, and standard deviation, grouped by 'diagnosis'.
#' @examples
#' #' @examples
#' # Load required libraries
#' library(dplyr)
#' library(rlang)
#'
#' # Example data frame
#' tumor_data <- data.frame(radius_mean = c(10, 15, 12, 20, 18),
#' diagnosis = c("A", "B", "A", "B", "A"))
#'
#' # Call the summarize_tumor_data function
#' summarize_tumor_data(tumor_data, "radius_mean")
#' # Example function using dplyr and rlang
#' summarize_tumor_data <- function(data, column_name) {
#' data %>%
#' group_by(.data$diagnosis) %>%
#' summarise(mean = mean(.data[[column_name]], na.rm = TRUE))
#' }
#' @export
summarize_tumor_data <- function(data, column_name) {
  # Check if the data is empty
  if (nrow(data) == 0) {
    stop("The dataset is empty.")
  }

  # Check if the column_name exists in the dataset
  if (!column_name %in% names(data)) {
    stop("The specified column does not exist in the dataset.")
  }

  # Check if the 'diagnosis' column exists in the dataset
  if (!"diagnosis" %in% names(data)) {
    stop("The 'diagnosis' column is missing in the dataset.")
  }

  # Ensure the selected column is numeric
  if (!is.numeric(data[[column_name]])) {
    stop("The selected column must be numeric. Non-numeric data cannot be summarized.")
  }

  # Summarize the data using dplyr functions
  summary <- data %>%
    dplyr::group_by(.data$diagnosis) %>%  # Use .data pronoun for diagnosis column
    dplyr::summarise(
      mean = base::mean(.data[[column_name]], na.rm = TRUE),  # .data for correct evaluation of column
      median = stats::median(.data[[column_name]], na.rm = TRUE),  # Explicitly call median from stats package
      sd = stats::sd(.data[[column_name]], na.rm = TRUE),  # Explicitly call sd from stats package
      .groups = 'drop'
    ) %>%
    tibble::as_tibble()  # Ensure as_tibble is called from tibble package

  # Print a message indicating successful summarization
  message("Data summarized successfully for column: ", column_name)

  return(summary)
}

# Install and load necessary packages
required_packages <- c("dplyr", "tibble", "datateachr", "rlang")
for (pkg in required_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg)
  }
  library(pkg, character.only = TRUE)
}

# Load the cancer_sample dataset from the datateachr package
cancer_sample <- datateachr::cancer_sample

# Example usage: Summarize the 'radius_mean' column and display results
tumor_summary <- summarize_tumor_data(cancer_sample, "radius_mean")
print(tumor_summary)

