x <- c(1, 123, 534, 13, 4)     # combine/concatenate
y <- seq(201, 250, 11)         # sesquence
z <- rep("Hi!", 3)             # replicate

# How to access individual element of vector
w <- c("a", "b", "c", "d", "e")
w

w[1]
w[2]
w[3]
w[-1]
v <- w[-3]
w[1:3]
w[3:5]

c(1,3,5)
w[c(1,3,5)]
w[c(-2,-4)]
w[-3:-5]
w[1:2]

# R is vector drive language and accessing individual elements is not very common.