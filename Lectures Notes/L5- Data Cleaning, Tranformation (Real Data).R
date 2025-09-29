# Data Cleaning and Transformation in R (Real Data)

# Load and inspect the dataset----
# Load libraries
library(dplyr) # for data manipulation
library(ggplot2) # for data visualization
library(readr) # for reading CSV files

# Load dataset
flights <- read_csv("Data sets/nycflights.csv") # or you can import it directly from RStudio

# Quick overview
glimpse(flights)
summary(flights)
head(flights, 10)


# Handling Missing Values----
# Check for missing values
sum(is.na(flights)) # total missing values
# Count missing values per column
colSums(is.na(flights))

# Example: remove rows with missing dep_time
flights_clean <- flights %>% 
  filter(!is.na(dep_time))

# Example: replace missing air_time with mean (IMPUTATION)
flights_clean <- flights_clean %>%
  mutate(air_time = ifelse(is.na(air_time), mean(air_time, na.rm = TRUE), air_time))
# Verify no missing values remain
colSums(is.na(flights_clean))

# Handling Duplicates----
# Count duplicates
sum(duplicated(flights_clean))

# Remove duplicates
flights_clean <- flights_clean %>% distinct()

# Verify data types----
# Convert flight date to Date type
flights_clean <- flights_clean %>%
  mutate(flight_date = as.Date(paste(year, month, day, sep="-")))

# Convert carrier and tailnum to factors
flights_clean <- flights_clean %>%
  mutate(carrier = as.factor(carrier),
         tailnum = as.factor(tailnum))

# Verify outlier handling----
# Boxplot for outlier detection in arrival delay
ggplot(flights_clean, aes(x = carrier, y = arr_delay)) +
  geom_boxplot()

# Winsorize: cap extreme delays at 3 SD
mean_delay <- mean(flights_clean$arr_delay, na.rm = TRUE)
sd_delay <- sd(flights_clean$arr_delay, na.rm = TRUE)

flights_clean <- flights_clean %>%
  mutate(arr_delay = ifelse(arr_delay > mean_delay + 3*sd_delay, 
                            mean_delay + 3*sd_delay,
                            arr_delay))

# Feature Engineering----
# Create new variables
flights_clean <- flights_clean %>%
  mutate(
    gain = dep_delay - arr_delay, # How much time gained/lost during flight
    speed = distance / (air_time/60) # Average speed (mph)
  )

# Normalize/scale numeric features (example with distance)
flights_clean <- flights_clean %>%
  mutate(distance_scaled = scale(distance))

# Data Summarization and Aggregation----
# Average arrival delay by carrier
flights_clean %>%
  group_by(carrier) %>%
  summarise(avg_arr_delay = mean(arr_delay, na.rm = TRUE)) %>%
  arrange(desc(avg_arr_delay))

# Monthly flight counts
flights_clean %>%
  group_by(month) %>%
  summarise(flight_count = n())

# Data Visualization after cleaning----
# Trend of delays by month
flights_clean %>%
  group_by(month) %>%
  summarise(avg_delay = mean(arr_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = month, y = avg_delay)) +
  geom_line(color = "blue") +
  geom_point(size = 2) +
  labs(title = "Average Arrival Delay by Month", x = "Month", y = "Avg Delay (minutes)")


# arrival delays graph
ggplot(flights_clean, aes(x = arr_delay)) +
  geom_histogram(binwidth = 10, fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "Distribution of Arrival Delays", x = "Arrival Delay (minutes)", y = "Frequency") +
  xlim(-100, 300) 



