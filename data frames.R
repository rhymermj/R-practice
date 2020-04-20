# Importing data into R -------------------------------------------------

?read.csv()

# METHOD 1: SELECT THE FILE MANUALLY
stats <- read.csv(file.choose())
stats

# METHOD 2: SET WORKING DIRECTORY AND READ DATA
getwd()

# Windows:
# setwd("C:\\Users\\MJ\\Desktop\\R Programming")

#Mac:
setwd("/Users/mjchoi/Documents/R-practice")
getwd()
rm(stats)
stats <- read.csv("Demographic-Data.csv")
stats


# Exploring dataset -----------------------------------------------------
stats
nrow(stats)
ncol(stats)
head(stats)      # top 6 rows
head(stats, n=10)
tail(stats)      # bottom 6 rows
str(stats)       # display structure of the data frame
summary(stats)   # breakdown for each columns


# Using the $ sign: Another way to access data a the data frame --------
# Does not work for matrices but does work for data frame
stats
head(stats)
stats[3,3]
stats[3, "Birth.rate"]
stats["Angola", 3]    # we can't do this because Angola is not a column name

# These two operations are the same
stats$Internet.users
stats[,"Internet.users"]

stats$Internet.users[2]
levels(stats$Income.Group)


# Basic operations with a data frame ------------------------------------
stats[1:10,]
stats[3:9,]
stats[c(3, 9),]

# In a matrix, if you extract one row it will turn into a vector.
# In a data frame, it stays as a data frame.
is.data.frame(stats[1,])        # TRUE - no need for drop=F
is.data.frame(stats[,1])        # FALSE - Not a data frame
is.data.frame(stats[,1,drop=F]) # TRUE

# Multiple columns
head(stats)
stats$Birth.rate * stats$Internet.users
stats$Birth.rate + stats$Internet.users

# Add columns
head(stats)
stats$MyCalc <- stats$Birth.rate * stats$Internet.users

stats$xyz <- 1:5
stats$xyz <- 1:4  # Error: replacement has 4 rows, data has 195
head(stats, n=12)

# Remove a column
head(stats)
stats$MyCalc <- NULL
stats$xyz <- NULL
head(stats)


# Filtering data frames (working with "rows") ---------------------------
head(stats)
filter <- stats$Internet.users < 2
stats[filter,]    # Display when the filter is true
stats[stats$Birth.rate > 40,]
stats[stats$Birth.rate > 40 & stats$Internet.users < 2,]
stats[stats$Income.Group == "High income",]
levels(stats$Income.Group)

stats[stats$Country.Name == "Malta",]


# Introduction to qplot() -----------------------------------------------
library("ggplot2")
?qplot()
qplot(data = stats, x=Internet.users)
qplot(data = stats, x=Income.Group, y=Birth.rate)
qplot(data = stats, x=Income.Group, y=Birth.rate, size=I(3), colour=I("blue"))
qplot(data = stats, x=Income.Group, y=Birth.rate, geom = "boxplot")


# Visualizing with qplot ------------------------------------------------
qplot(data = stats, x=Internet.users, y=Birth.rate)
qplot(data = stats, x=Internet.users, y=Birth.rate, size=I(3))
qplot(data = stats, x=Internet.users, y=Birth.rate, size=I(3), colour=I("red"))
qplot(data = stats, x=Internet.users, y=Birth.rate, colour=Income.Group, size=I(2))
# Analysis: higher income group has higher internet usage and lower birth rate.


# Creating Data Frames --------------------------------------------------
# Use data.frame() function and pass the vectors
mydf <- data.frame(Countries_2012_Dataset, Codes_2012_Dataset, Regions_2012_Dataset)
head(mydf)
#colnames(mydf) <- c("Country", "Code", "Region")
#head(mydf)
rm(mydf)

mydf <- data.frame(Country=Countries_2012_Dataset, Code=Codes_2012_Dataset, Region=Regions_2012_Dataset)
head(mydf)
tail(mydf)
summary(mydf)


# Merging Data Frames ---------------------------------------------------
head(stats)
head(mydf)

merged <- merge(stats, mydf, by.x = "Country.Code", by.y = "Code")
head(merged)

merged$Country <- NULL
str(merged)
tail(merged)


# Visualizing with new Split -------------------------------------------
qplot(data = merged, x=Internet.users, y=Birth.rate)
qplot(data = merged, x=Internet.users, y=Birth.rate, colour=Region)

# 1.Shapes
qplot(data = merged, x=Internet.users, y=Birth.rate, colour=Region, size=I(2), shape=I(18))
# 2. Transparency
qplot(data = merged, x=Internet.users, y=Birth.rate, colour=Region, size=I(2), shape=I(19), alpha=I(0.6))
# 3. Title
qplot(data = merged, x=Internet.users, y=Birth.rate, colour=Region, size=I(2), shape=I(19), alpha=I(0.6), main = "Birth Rate vs Internet Users")
