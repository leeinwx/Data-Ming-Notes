# CS422 Data Mining
# Vijay K. Gurbani, Ph.D.
# Illinois Institute of Technology

# Make sure you know the basic collections in R:
# Mandatory to know:
# - Vectors
# - Lists
# - Data frames
# Optional (not used in class, but useful to know):
# - Containers (https://cran.r-project.org/web/packages/container/)
# - Collections (https://cran.r-project.org/web/packages/collections/index.html)

library(dplyr)

setwd("/home/vkg/IIT/CS422/lectures/lecture-1")

# Variables in R
a <- 1
b <- 1.0
c <- "Hello"
d <- "World"

# There is a difference between <- and =.  Both are assignment operators,
# but <- is used to assign values to variables and = is used to assign
# values to function parameters.
# Writing output
cat("Hello World")
str <- paste("Hello World")
cat(str)

# Or...
str <- paste(c, d, sep="+")
cat(str)

# Or ...
cat(paste(c, d))

# A gentle introduction to R through three main collections: vectors, lists
# and data frames.

# VECTORS
# Normal vectors of multiple types
s <- c("hello", "world")
i <- c(1,2,3)
n <- c(1.0, 2.1, 11.1)
b <- c(TRUE,FALSE,TRUE,TRUE)

# You can access individual elements using s[1], i[2], etc.
# You can access multipe elements using b[1:3]

# You can do vectorized calculations, such as i+3 

# Named elements in a vector
named <- c(name="Vijay", mode="Instructor", students=73)

# Access using indices or names
named[1]
named['name']

# LISTS

l <- list(1, 'a', "hello", strings=s, booleans=b)
l
l[1]
l['strings']
length(l)

# Note the difference between l[4] and l[[4]] (or l['strings'] and 
# l[['strings]])
l[4]
l[[4]]
l['strings']
l[['strings']]

# And functions
intro <- function(){
  a <- toString("Hello, my name is Vijay\n")
  a
}

intro2 <- function(name, student){
  if (student == "y")  {
      status <- "I am a student"  
  }
  else {
    status <- "I am not a student"
  }
  list(name=name, status=status)
}


# DATA FRAMES
# Data Frames: An important concept in R.
df <- read.csv("student.csv", sep=";", header=T)
# Or read.csv("/home/vkg/IIT/CS422/lectures/lecture-1/student.csv", ...)
df

# class() is an important function; it tells you what is the type of
# object you are dealing with.
class(df)

# str() is another important function.  It shows you the structure of the
# R object.  For example, note the output of the following commands:
str(df)
df$name
summary(df$gpa)

# Note the difference between df[1] and df[1,] (also see df[1:2,])
# You can add/remove rows and columns to/from a data frame.  I will
# let you experiment with this.

# Introduce the pipe from package magrittr
# (https://magrittr.tidyverse.org/reference/pipe.html)
df %>% head
df %>% head(2) # Versus head(df, 2)

# Some interesting things you can do with data frames:
# Count the number of B's in the dataframe
sum(df$grade == "B")

# Which observations have a GPA > 2.00?
gpa.ge.2 <- filter(df, gpa > 2.00)
# or
gpa.ge.2 <- df %>% filter(gpa > 2.00)

# Sometimes, you will find that you need indices for selected 
# observations... 
indx <- which(df$gpa > 2.00)

# Select the name and ID of all the students who had a B with a GPA of at
# least 3.50.
students <- select(filter(df, gpa >= 3.50 & grade == "B"), c("name", "id"))

# Plot: simple histogram
plot(hist(df$gpa), main="GPA Histogram", xlab="GPA")

# Add color!
colors <- c("red", "yellow", "orange")
plot(hist(df$gpa), main="GPA Histogram", xlab="GPA", col=colors)

# You can easily manipulate data frames.  Let's say you want to add a column
# that contains status (i.e., freshman, junior, ...)
df$year <- c("Freshman", "Junior", "Senior", "Sophomore", "Junior",
             "Freshman", "Senior")

# ... If you want to take the column out ...
df$year <- NULL

# ... If you want to add a new row...
df <- rbind(df, data.frame(name="Jane Doe", id=75411, gpa=3.65, grade="B"))

# ... If you want to remove the row...
df <- df[-8, ]
