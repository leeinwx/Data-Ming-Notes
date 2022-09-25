# CS422 Data Mining
# Vijay K. Gurbani, Ph.D.
# Illinois Institute of Technology

# Make sure you install these packages once by issuing the command:
# > install.packages(c("rpart", "rpart.plot", "caret", "e1071", "knitr"))

library(rpart)
library(caret)
library(rpart.plot)

setwd("/home/vkg/IIT/CS422/lectures/lecture-4")

# Example of tree pruning using the ecoli dataset (see
# https://archive.ics.uci.edu/ml/datasets/ecoli)

# Read data and create a classification tree using all predictors.
ecoli <- read.csv("ecoli.csv")
model <- rpart(class ~ mcg + gvh + lip + chg + aac + alm1 + alm2, data=ecoli)
rpart.plot(model, extra=104, fallen.leaves = T, type=4)  # Show the tree

# Can we prune?
plotcp(model)
printcp(model)

# Now look at plotcp() and choose a cp value of 0.04, corresponding with a 
# tree size of 5
model.pruned <- prune(model, cp=0.01)
rpart.plot(model.pruned, extra=104, fallen.leaves = T, type=4) # Should be a
# simpler tree.