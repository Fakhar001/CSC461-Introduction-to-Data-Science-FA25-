# Create a "dirty" version of iris dataset
set.seed(123)

iris_dirty <- iris %>%
  mutate(
    # Introduce some missing values
    Sepal.Length = ifelse(runif(n()) < 0.05, NA, Sepal.Length),
    Petal.Width = ifelse(runif(n()) < 0.03, NA, Petal.Width),
    
    # Convert Species to character (wrong data type)
    Species = as.character(Species),
    
    # Add duplicate rows
    .after = Species
  ) %>%
  bind_rows(slice(iris, 1:10)) %>%
  # Introduce extreme outliers
  mutate(Sepal.Width = ifelse(row_number() %in% c(5, 15), Sepal.Width * 10, Sepal.Width))

# Save dataset
write.csv(iris_dirty, "iris_dirty.csv", row.names = FALSE)
