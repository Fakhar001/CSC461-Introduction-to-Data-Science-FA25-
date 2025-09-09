# Basic Arithmetic Operations in R----
# Addition
5 + 3 # Addition
# Subtraction
10 - 4
# Multiplication
6 * 7
# Division
20 / 5
# Exponentiation
2 ^ 3
# Modulus
10 %% 3
# Integer Division
10 %/% 3
# Assigning Values to Variables
x = 10
y <- 5
z <- x + y
z
# Print the result
print(z)


# Different Data types in R----
# Numeric
num <- 42.5
class(num)
# Integer
int <- 42L
class(int)
# Character
char <- "Hello, R!"
class(char)
# Logical
logi <- TRUE
class(logi)
# Factor
fact <- factor(c("Red", "Blue", "Green", "Blue"))
class(fact)
# Complex
comp <- 3 + 2i
class(comp)
# Time
time <- Sys.time()
class(time)
# Date
date <- as.Date("2023-10-01")
class(date)



# Data structures in R----
# Vectors
vec <- c(1, 2, 3, 4, 5)
vec
# Lists
my_list <- list(Name = "John", Age = 30, Scores = c(90, 85, 88))
my_list
# Matrices
mat <- matrix(1:9, nrow = 3, ncol = 3)
mat
# Array
arr <- array(1:12)
arr
arr_3d <- array(1:24, dim = c(2, 3, 4))


# Data Frames in R---- 
# Create a data frame

df <- data.frame(
  Name = c("Alice", "Bob", "Charlie"),
  Age = c(25, 30, 35),
  Score = c(90, 85, 88)
)
# View the data frame
print(df)
# Accessing elements
df$Name # Accessing the 'Name' column
df[1, ] # Accessing the first row
df[, "Score"] # Accessing the 'Score' column
df[2, 3] # Accessing the element in the 2nd row and 3rd column
# Summary statistics
summary(df)
mean(df$Age) # Mean of the 'Age' column
sd(df$Score) # Standard deviation of the 'Score' column

# Adding a new column
df$Passed <- df$Score > 88
print(df)
# Subsetting data
passed_students <- df[df$Passed == TRUE, ]
print(passed_students)
# Sorting data
sorted_df <- df[order(df$Score, decreasing = TRUE), ]
print(sorted_df)
# Merging data frames
df2 <- data.frame(
  Name = c("David", "Eva"),
  Age = c(28, 22),
  Score = c(92, 81)
)
merged_df <- rbind(df, df2)
print(merged_df)

# Basic Functions in R----
# Define a function to calculate the square of a number
square <- function(x) {
  return(x^2)
}
# Call the function
result <- square(4)
print(result)
# Define a function to calculate the factorial of a number
factorial <- function(n) {
  if (n == 0) {
    return(1)
  } else {
    return(n * factorial(n - 1))
  }
}
# Call the function
fact_result <- factorial(5)
print(fact_result)
# Define a function to check if a number is even or odd
is_even <- function(num) {
  if (num %% 2 == 0) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}
# Call the function
even_check <- is_even(10)
print(even_check)
odd_check <- is_even(7)
print(odd_check)
# Define a function to calculate the mean of a numeric vector
calculate_mean <- function(vec) {
  return(sum(vec) / length(vec))
}
# Call the function
mean_result <- calculate_mean(c(1, 2, 3, 4, 5))
print(mean_result)






