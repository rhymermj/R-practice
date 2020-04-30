housing.df <- read.csv(file.choose())
housing.df

getwd()
setwd("/Users/mjchoi/Documents/DMBA-R-datasets")
getwd()

# Load data
housing.df <- read.csv("WestRoxbury.csv", header = TRUE)

# Find the dimension of data frame
dim(housing.df)

# Show the first six rows
head(housing.df)

# Show all the data in a new tab
View(housing.df)

housing.df[5, c(1:2, 4, 8:10)]
housing.df[, 1]
housing.df$TOTAL.VALUE
length(housing.df$TOTAL.VALUE)
mean(housing.df$TOTAL.VALUE)

# Find summary statistics for each column
summary(housing.df)

# random sample of 5 observations
s <- sample(row.names(housing.df), 5)
housing.df[s,]

# oversample houses with over 10 rooms
s <- sample(row.names(housing.df), 5, prob = 1, false(housing.df$ROOMS > 10, 0.9, 0.01))
?sample()

# print a list of variables/columns to the screen
names(housing.df)

# print the list in a useful column format
t(t(names(housing.df))) # a double matrix transpose using t() function

# change the first column's name
colnames(housing.df)[1] <- c("TOTAL_VALUE")

class(housing.df$REMODEL) # REMODEL is a factor variable
class(housing.df[,14]) # same as above
levels(housing.df[,14]) # It can take one of three levels
class(housing.df$BEDROOMS) # BEDROOMS is an integer variable
class(housing.df[,1]) # TOTAL_VALUE is a numeric variable

# To illustrate missing data procedures, we first convert a few entries for bedrooms 
# to NA's. Then we input these missing values using the median of the remaining values.
rows.to.missing <- sample(row.names(housing.df), 10)
housing.df[rows.to.missing,]$BEDROOMS <- NA
summary(housing.df$BEDROOMS)

# replace the missing values using the median of the remaining values
# use median() with na.rm = TRUE to ignore missing values when computing the median
housing.df[rows.to.missing,]$BEDROOMS <- median(housing.df$BEDROOMS, na.rm = TRUE)
summary(housing.df$BEDROOMS)

# Partitioning the data -----------------------------------------------
# get the same partitions when re-running the R code
set.seed(1)

# partitioning into training (60%) and validation (40%)
# randomly sample 60% of the row IDs for training; 
# the remaining 40% serve as validation
train.rows <- sample(rownames(housing.df), dim(housing.df)[1]*0.6)

# collect all the columns with training row ID into training set
train.data <- housing.df[train.rows,]

# assign row IDs that are not already in the training set, into validation
valid.rows <- setdiff(rownames(housing.df), train.rows)
valid.data <- housing.df[valid.rows,]

reg <- lm(TOTAL_VALUE ~ ., data = housing.df, subset = train.rows)
# remove TAX
reg <- lm(TOTAL_VALUE ~ .-TAX, data = housing.df, subset = train.rows)
tr.res <- data.frame(train.data$TOTAL_VALUE, reg$fitted.values, reg$residuals)
head(tr.res)
