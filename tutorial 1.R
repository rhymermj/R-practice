#######################################################
## Tutorial 1                                        ##
## (Chapter 2 - Overview of the Data Mining Process) ## 
####################################################### 

##Problem 2. The dataset ToyotaCorolla.csv contains data on used cars on sale
##during the late summer of 2004 in the Netherlands. It has 1436 records 
##containing details on 38 attributes, including Price, Age, Kilometers, HP, 
##and other specifications.

# Question 2a
#	We plan to analyse the data using various data mining techniques described in future chapters. 
# Prepare the data for use as follows:
# The dataset has two categorical attributes, Fuel Type and Color. 
# Use R's functions to transform this categorical data into dummies. 
# What would you do with the variable Model?
# NOTE: Metallic is binary and not needed to be converted to dummies.


install.packages("dummies")
library(dummies)

#load data
car.df <- read.csv("ToyotaCorolla.csv")

car.df
?dummy.data.frame()

#create binary dummy variables for Fuel_Type and Color
car.df <- dummy.data.frame(car.df, names = c("Fuel_Type", "Color"), sep=".")

# Examine data set after creating dummies
dim(car.df)
t(t(names(car.df)))
head(car.df[,8:10], 10)
?head()
head(car.df[,13:22], 10)

# Question 2b
##Prepare the dataset (as factored into dummies) for data mining 
##techniques of supervised learning by creating partitions in R. Select  
##the variables and use default values for the random seed and partitioning
##percentages for training (50%), validation (30%), and test (20%) sets. 
##Describe the roles that these partitions will play in modeling.


#use set.seed() to get the same partitions when re-running the R code.
set.seed(201)
?set.seed()

## partitioning into training (50%), validation (30%), test (20%)
# randomly sample 50% of the row IDs for training
train.rows <- sample(rownames(car.df), dim(car.df)[1]*0.5)

# sample 30% of the row IDs into the validation set, drawing only from records
# not already in the training set
# use setdiff() to find records not already in the training set
valid.rows <- sample(setdiff(rownames(car.df), train.rows), dim(car.df)[1]*0.3)

# assign the remaining 20% row IDs serve as test
test.rows <- setdiff(rownames(car.df), union(train.rows, valid.rows))

# create the 3 data frames by collecting all columns from the appropriate rows
train.data <- car.df[train.rows, ]
valid.data <- car.df[valid.rows, ]
test.data <- car.df[test.rows, ]
dim(car.df)
dim(train.data)
dim(valid.data)
dim(test.data)


#------------------------------------------------------------------------------------
#Training dataset
#The training dataset is used to train or build models. For example, in a 
#linear regression, the training dataset is used to fit the linear regression 
#model, i.e. to compute the regression coefficients. This is usually the 
#largest partition.

#Validation dataset
#Once a model is built on training data, we assess the accuracy of the model on
#unseen data. For this, the model should be used on a dataset that was not used
#in the training process. In the validation data we know the actual value of 
#the response variable, and can therefore examine the difference between the 
#actual value and the predicted value to determine the error in prediction. 
#Based on this performance, sometimes the validation dataset is used to tweak 
#the model, or to choose between multiple fitted models.

#Test dataset
#The validation dataset is often used to select a model with minimum error. 
#Testing that model on completely unseen data gives a realistic estimate of 
#the performance of the model. When a model is finally chosen, its accuracy
#with the validation dataset is still an optimistic estimate of how it would 
#perform with unseen data. This is because (1) the final model has come out as 
#the winner among the competing models based on the fact that its accuracy with
#the validation dataset is highest, and/or (2) the validation set was used to 
#help build one or more models. Thus, you need to set aside yet another portion 
#of data, which is used neither in training nor in validation, which is called 
#the test dataset. The accuracy of the model on the test data gives a realistic
#estimate of the performance of the model on completely unseen data.


