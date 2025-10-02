# Comprehensive Lecture on Grammar of Graphics in R using ggplot2
# This script accompanies a lecture on the Grammar of Graphics, implemented with ggplot2 in R.


# Install and load ggplot2 if needed
# install.packages("ggplot2")  # Uncomment if not installed
library(ggplot2)

# 1. Exploring the mtcars dataset (built-in)
head(mtcars)  # Preview: mpg, cyl, disp, hp, etc.

# 2. Basic ggplot2: Initializing a plot
# Blank plot with data and aesthetics
ggplot(mtcars, aes(x = wt, y = mpg))

# 3. Adding a geom (scatterplot)
ggplot(mtcars, aes(x = wt, y = mpg)) + 
  geom_point()

# 4. Adding a statistical transformation (linear regression line)
ggplot(mtcars, aes(x = wt, y = mpg)) + 
  geom_point() + 
  geom_smooth(method = "lm")  # lm = linear model

# 5. Customizing with a color scale (categorical)
ggplot(mtcars, aes(x = wt, y = mpg, color = factor(cyl))) + 
  geom_point() + 
  scale_color_brewer(palette = "Set1")  # Brewer palette for colors

# 6. Coordinate system: Flipped bar chart
ggplot(mtcars, aes(x = factor(cyl), y = mpg)) + 
  geom_bar(stat = "summary", fun = "mean")+
  coord_flip()# Mean mpg per cylinder
  

# 7. Polar coordinates for a pie-like chart
ggplot(mtcars, aes(x = factor(1), fill = factor(cyl))) + 
  geom_bar(width = 1) + 
  coord_polar(theta = "y")

# 8. Faceting by cylinders
ggplot(mtcars, aes(x = wt, y = mpg)) + 
  geom_point() + 
  facet_wrap(~ cyl)

# 9. Applying a theme and labels
ggplot(mtcars, aes(x = wt, y = mpg)) + 
  geom_point() + 
  theme_minimal() + 
  labs(title = "Car Weight vs MPG", x = "Weight (1000 lbs)", y = "Miles per Gallon")

# 10. Building a complex plot iteratively with mpg dataset
# Step 1: Initialize
p <- ggplot(mpg, aes(x = displ, y = hwy))  # displ: engine size, hwy: highway mpg
p  # Blank canvas

# Step 2: Add scatter points
p <- p + geom_point()
p

# Step 3: Add color by class
p <- ggplot(mpg, aes(x = displ, y = hwy, color = class)) + geom_point()
p

# Step 4: Add smooth trend
p <- p + geom_smooth(method = "loess")  # Local regression
p

# Step 5: Add facets
p <- p + facet_wrap(~ class)
p

# Step 6: Customize scales and theme
p <- p + scale_color_viridis_d() +  # Viridis color palette
  theme_minimal() + 
  labs(title = "Engine Displacement vs Highway MPG by Car Class")
p

# 11. Common Plot Types
# Scatterplot with iris dataset
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) + 
  geom_point(size = 3) + 
  geom_smooth(method = "lm", se = FALSE) +  # No confidence interval
  theme_light() + 
  labs(title = "Iris Sepal Dimensions by Species")

# Bar chart (count)
ggplot(mpg, aes(x = class, fill = class)) + 
  geom_bar() + 
  coord_flip() + 
  scale_fill_brewer(palette = "Paired") + 
  labs(title = "Count of Cars by Class")

# Bar chart (mean)
ggplot(mpg, aes(x = class, y = hwy)) + 
  geom_bar(stat = "summary", fun = "mean", fill = "steelblue") + 
  labs(title = "Average Highway MPG by Class")

# Histogram
ggplot(mpg, aes(x = hwy)) + 
  geom_histogram(bins = 20, fill = "lightblue", color = "black") + 
  labs(title = "Distribution of Highway MPG")

# Boxplot
ggplot(mpg, aes(x = class, y = hwy, fill = class)) + 
  geom_boxplot() + 
  theme_bw() + 
  labs(title = "Highway MPG Distribution by Class")

# Line plot with economics dataset
ggplot(economics, aes(x = date, y = unemploy)) + 
  geom_line(color = "red") + 
  labs(title = "US Unemployment Over Time")

# 12. Advanced Customization
# Custom aesthetics and scales
ggplot(mtcars, aes(x = wt, y = mpg, size = hp, shape = factor(cyl))) + 
  geom_point(color = "blue", alpha = 0.7) + 
  scale_size_continuous(range = c(1, 10)) + 
  scale_shape_manual(values = c(16, 17, 18))

# Faceting with two variables
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  facet_grid(drv ~ class)

# Annotations
ggplot(mtcars, aes(x = wt, y = mpg)) + 
  geom_point() + 
  annotate("text", x = 4, y = 30, label = "High Efficiency", color = "red") + 
  geom_vline(xintercept = 3, linetype = "dashed")

# 13. Saving a plot
# ggsave("my_plot.png", plot = p, width = 8, height = 6, dpi = 300)
# Uncomment the above line to save the last plot as a PNG file

