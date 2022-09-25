library(dplyr)
library(rpart)
library(rpart.plot)

setwd('/Users/lee/Library/Mobile\ Documents/com~apple~CloudDocs/IIT/CS422/Notes/dplyr')
df <- read.csv('student.csv', header = TRUE, sep = ';')
df

sum(df$grade == "B")

# filter
gpa.ge.2 <- df %>% filter(gpa > 2.00)

# select
student <- select(filter(df, gpa>=3.5 & grade == "B"), c('name','id'))

# loan
rm(list=ls())
df <- read.csv("loan.csv", header=T, sep=",")

model <- rpart(Defaulted ~ ., data = df, 
               control=rpart.control(minsplit=2, minbucket=1))
rpart.plot(model, extra=103, fallen.leaves = T, type=2, 
           main="RPART Decision Tree")

# Let's see how it predicts.
obs <- data.frame(Homeowner="Yes", Marital.Status="Single",
                  Annual.Income=200)
test.df <- obs
obs <- data.frame(Homeowner="No", Marital.Status="Divorced",
                  Annual.Income=160)
test.df <- rbind(test.df, obs)
obs <- data.frame(Homeowner="No", Marital.Status="Married",
                  Annual.Income=73)
test.df <- rbind(test.df, obs)

# Predict the class and the probability associated with each prediction
pred.class <- predict(model, newdata=test.df, type = "class")
pred.prob <- predict(model, newdata=test.df, type = "prob")
