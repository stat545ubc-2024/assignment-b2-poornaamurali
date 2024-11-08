test_that("summarize_tumor_data works correctly", {
  # Example data
  tumor_data <- data.frame(radius_mean = c(10, 15, 12, 20, 18), diagnosis = c("A", "B", "A", "B", "A"))

  # Call the function
  result <- summarize_tumor_data(tumor_data, "radius_mean")

  # Test that the result is correct
  expect_equal(result$mean[result$diagnosis == "A"], 13.33, tolerance = 0.01)  # Add tolerance for floating point comparison
  expect_equal(result$mean[result$diagnosis == "B"], 17.5, tolerance = 0.01)

  # Clean up
  rm(tumor_data)
})
