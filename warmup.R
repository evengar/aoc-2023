# repeating day 2 2020 in R
library(stringr)

d <- readLines("data/2020-02-input.txt")

d_split <- sapply(d, str_split, pattern = " ")

count <- sapply(d_split, function(x){
  nums <- as.numeric(str_split(x[1], "-", simplify = TRUE))
  char <- str_replace(x[2], ":", "")
  nchar <- str_count(x[3], char)
  if (nchar >= nums[1] & nchar <= nums[2]){
    return(1)
  }
  return(0)
})

sum(count)  
