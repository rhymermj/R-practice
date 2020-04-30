#########################################################
## Tutorial 6 (Chapter 7) - k-Nearest Neighbours (kNN) ## 
#########################################################

install.packages("class")
install.packages("e1071")
install.packages("caret")
library(class)
library(caret)
library(e1071)

####################################################################################
## Problem - Predicting Housing Median Prices. 
## The file BostonHousing.csv contains information on over 500 census tracts in 
## Boston, where for each tract multiple variables are recorded. The last column
## (CAT..MEDV) was derived from MEDV, such that it obtains the value 1 if 
## MEDV > 30 and 0 otherwise. Consider the goal of predicting the median value 
## (MEDV) of a tract, given the information in the first 12 columns. 
##
## Partition the data into training (60%) and validation (40%) sets. 
####################################################################################

# load the data
housing.df <- read.csv("BostonHousing.csv")
t(t(names(housing.df)))

# partition into training and validation sets
set.seed(1)  
train.index <- sample(row.names(housing.df), 0.6*dim(housing.df)[1])  
valid.index <- setdiff(row.names(housing.df), train.index)  
train.df <- housing.df[train.index, -14]    # ignore 14th column 
valid.df <- housing.df[valid.index, -14]

train.norm.df <- train.df
valid.norm.df <- valid.df
norm.values <- preProcess(train.df[, -13], method=c("center", "scale"))
train.norm.df[, -13] <- predict(norm.values, train.df[, -13])
valid.norm.df[, -13] <- predict(norm.values, valid.df[, -13])

## 1.a Perform a k-NN prediction with all 12 predictors (ignore the CAT.MEDV
## column), trying values of k from 1 to 5. Make sure to normalise the data, and
## choose function knn() from package class rather than package FNN. To make sure
## R is using the class package (when both packages are loaded), use class::knn(). 
## What is the best k? What does it mean? 

library(caret)
accuracy.df <- data.frame(k = seq(1, 5, 1), RMSE = rep(0, 5))
# In this problem, we use RMSE to determine accuracy because data is real numbers
# rather than a factor (e.g. 0 or 1, as in lecture example)
for(i in 1:5) {
  knn.pred <- class::knn(train = train.norm.df[,-13], 
                         test = valid.norm.df[,-13], 
                         cl = train.df$MEDV, k = i)  
  accuracy.df[i, 2] <- RMSE(as.numeric(as.character(knn.pred)), valid.df$MEDV)
}                
accuracy.df
# accuracy.df
#   k    RMSE
#1  1    5.17
#2  2    5.57
#3  3    5.86
#4  4    5.73
#5  5    5.88

# Here best k = 1. However, we will not use k=1 (reminder). The next lowest error
# is for k=2. This means that, for a given record, MEDV is predicted by 
# averaging the MEDVs for the 2 closest records, proximity being measured by the
# distance between the vectors of predictor values.

## 1.b Predict the MEDV for a tract with the following information, using the 
## best k:
## CRIM  ZN INDUS  CHAS   NOX RM AGE DIS RAD TAX PTRATIO LSTAT
## 0.2   0     7   0    0.538 6  62  4.7   4 307      21    10

new.rec <- data.frame(0.2, 0, 7, 0, 0.538, 6, 62, 4.7, 4, 307, 21, 10)
names(new.rec) <- names(train.norm.df)[-13]
new.norm.rec <- predict(norm.values, new.rec)

knn.pred <- class::knn(train = train.norm.df[,-13], 
                       test = new.norm.rec, 
                       cl = train.df$MEDV, k = 2)
knn.pred
# knn.pred
# [1] 19.9
# 173 Levels: 5 5.6 7 7.2 7.4 7.5 8.1 8.3 8.5 8.7 8.8 9.6 9.7 10.2 10.4 10.5 10.8 ... 50

## 1.c If we used the above k-NN algorithm to score the training data, what 
## would be the error of the training set?
#
# In the training set, the error is zero because the training cases are matched 
# to themselves. 

## 1.d Why is the validation data error overly optimistic compared to the 
## error rate when applying this k-NN predictor to new data?
#
# The validation error measures the error for the "best k" among multiple k's 
# tried out for the validation data, so that particular k is optimized for 
# the particular validation data set that was used in selecting it. It may 
# not be as suitable for the new data.

## 1.e If the purpose is to predict MEDV for several thousands of new tracts, what would 
## be the disadvantage of using k-NN prediction? List the operations that the algorithm goes 
## through in order to produce each prediction. 
#
# KNN does not yield a uniform rule that can be applied to each new record to be
# predicted -- the whole "model building" process has to be repeated for each new
# record to be classified.

# Specifically, the algorithm must calculate the distance from a new record to 
# each of the training records, select the n-closest training records, determine
# the average target value for the n-closest training records, then score that 
# target value to the new record, then repeat this process for each of the new 
# records.

#Note that the computations required are a function both of the size of the 
#training set and the size of the new data to be scored. 

