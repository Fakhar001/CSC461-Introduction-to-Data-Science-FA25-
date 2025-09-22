# Data Cleaning and transformation in R
# Load necessary libraries

library(dplyr) # for data manipulation
library(tidyr) # for data tidying
library(janitor) # for cleaning column names
library(ggplot2) # for data visualization

# Loading dataset----
# Create a sample dataset
data1 <- data.frame(
  id = c(1,3,4,5,6),
  name = c("Alice", "Bob", "Charlie", "David", "Eve"),
  age = c(25, NA, 35, 45, NA),
  gender=c("Female","Male",NA, "Male","Female"),
  score_M = c(90, 85, NA, 70, 95)
)

# Create another dataset with inconsistent column names with different ids
data2=data.frame(
  id= c(2, 7),
  Name= c("Frank", "Grace"),
  age=c(33,29),
  Gender=c("Male","Female"),
  score_m=c(88, 92)
)


# Step-1 Addressing Data Inconsistencies----
# Inconsistent in order of ids
# Combine the data sets
data_raw <- bind_rows(data1, data2) # combine the data sets

data=arrange(data_raw, id) 

# Data Standardization
# Standardize column names
data1=clean_names(data1) # from janitor package
data2=clean_names(data2)
# Data Integration
data_sf <- bind_rows(data1, data2)

#order the data_s
data_sf <- arrange(data_sf, id)# Method_1

data_sf = data_sf %>% # Method_2 dplyr package
  arrange(id)

# manually rename the columns
colnames(data_sf)[which(names(data_sf) == "score_m")] <- "score_m"
# use rename function
#rename(data_sf, score_m = score_m)


# changing dataype
data3=data.frame(
  id= c(2, 7),
  Name= c("Frank", "Grace"),
  age=c(33L,29L),
  Gender=c("Male","Female"),
  score_m=c(88, 92)
)

data3$age <- as.numeric(data3$age)

# check data type 
str(data3)



# Step-2 Handling Missing Values----
missing_values <- colSums(is.na(data_sf))
# Display missing values
missing_values
# (a) remove missing value
data_no_na <- na.omit(data_sf) 
drop_na(data_sf)

# (b) replace missing values with mean for numeric columns
data_sf_wm <- data_sf %>%
  mutate(
    age = ifelse(is.na(age), mean(age, na.rm = TRUE), age),
    score_m = ifelse(is.na(score_m), mean(score_m, na.rm = TRUE), score_m), # add for gender
    gender=ifelse(is.na(gender),"Male",gender)
  )
# count the values of na in data_sf_wm
colSums(is.na(data_sf_wm))




# Step-3 Transform the dataset----

# change value equal to 50 when age=35

# update the age of  Frank to 40
data_sf_a <- data_sf_wm %>%
  mutate(age = ifelse(age == 35, 37, age))

# Values Transformation

data_sf_a <- data_sf_a %>%
  mutate(age_group = case_when(
    age < 30 ~ "Young",
    age >= 30 & age < 40 ~ "Middle-aged",
    TRUE ~ "Senior"
  )) %>%
  select(id, name, age, age_group, score_m)
# Display the transformed dataset

# More complex transformation
data_sf_a <- data_sf_a %>% # trasformed data
  mutate(
    age_group = case_when(
      age < 30 ~ "Young",
      age >= 30 & age < 40 ~ "Middle-aged",
      TRUE ~ "Senior"
    ),
    score_category = case_when(
      score_m >= 90 ~ "High",
      score_m >= 80 & score_m < 90 ~ "Medium",
      TRUE ~ "Low"
    )
  ) %>%
  select(id, name, age, age_group, score_m, score_category)
# Display the complex transformed dataset
transformed_data_complex

# Encode Categorical Variables Gender
data_sf=data_sf%>%
  mutate(is_female= as.numeric(gender =="Female"))

data_sf=data_sf%>%
  mutate(gender_en= as.numeric(gender))


# Step-4 Data Aggregation----
# Aggregating data by age group and calculating average score
aggregated_data <- data_sf_wm %>%
  group_by(age_group) %>%
  summarise(
  average_score = mean(score_m, na.rm = TRUE),
  count = n()
  ) %>%
  ungroup()


# Step-5 Find the outliers in the data----
# Step-6 Using Boxplot to find outliers----
boxplot(data_sf_wm$score_m, main = "Boxplot of Scores", ylab = "Scores")



