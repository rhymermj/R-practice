x <- c("a", "b", "c", "d", "e")
x
x[c(1, 5)]
x[1]

# Subsetting

Games
t(Games)
Games[1:3, 6:10]
Games[c(1,10),]
Games[, c("2008", "2009")]

Games[1,]
is.matrix(Games[1,])   # FALSE
is.vector(Games[1,])   # TRUE

Games[1,5]
is.matrix(Games[1,5])  # FALSE
is.vector(Games[1,5])  # TRUE

Games[1,, drop=F]
is.matrix(Games[1,, drop=F])  # TRUE
is.vector(Games[1,, drop=F])  # FALSE

Games[1,5, drop=F]


