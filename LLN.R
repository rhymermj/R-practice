# Test the Law of Large Numbers for N random normally distributed numbers with mean = 0, SD = 1.
# Create an R script that will count how many of these numbers fall between -1 and 1,
# and divide by the total quantity N

N <- 1000000                    # specify sample size
counter <- 0                    # reset counter
#rnorm(N)                       # print the number

for(i in rnorm(N)){             # iterate over vector of numbers; i is the variable itself, not an index  
  if(i > -1 & i < 1) {
    counter <- counter + 1      # increase counter if condition is met
  }
}

answer <- counter / N           # calculate hit-ratio
answer                          # print answer in console

# compare with E(x)=68.2