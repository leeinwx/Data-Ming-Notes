library(rpart)
library(rpart.plot)

rm(list=ls())

setwd("/home/vkg/IIT/CS422/lectures/lecture-4")

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

