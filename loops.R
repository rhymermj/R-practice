while(TRUE){
  print('Hello')            # use print inside loops
}

counter <- 1
while(counter < 12){
  print(counter)
  counter <- counter + 1    # counter++ does not work
}

# Iterate i from 1 to 5
for(i in 1:5){
  print("Hello R")
}

# Prints Hello 6 times
for(i in 5:10){
  print("Hello R")
}
