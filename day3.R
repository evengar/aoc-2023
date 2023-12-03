library(readr)


getAdjacent <- function(mat, row, col){
  
  indices <- list(c(row - 1, col), 
                  c(row + 1, col), 
                  c(row, col - 1), 
                  c(row, col + 1),
                  # diagonals
                  c(row - 1, col - 1),
                  c(row - 1, col + 1),
                  c(row + 1, col -1),
                  c(row + 1, col + 1))
  oob <- sapply(indices, function(x) any(x < 1) | any(x > dim(mat)))
  indices <- indices[!oob]
  vals <- rep(NA, length(indices))
  for (i in seq_along(indices)){
    vals[i] <- mat[indices[[i]][1], indices[[i]][2]]
  }
  return(vals)
}



isSymbol <- function(char){
  non_symbol <- c(
    "1", "2", "3",
    "4", "5", "6",
    "7", "8", "9",
    "0", "."
  )
  return(!(char %in% non_symbol))
}
isNumber <- function(char){
  numbers <- c(
    "1", "2", "3",
    "4", "5", "6",
    "7", "8", "9",
    "0"
  )
  return(char %in% numbers)
}

getNumber <- function(mat, i, j){
  number = mat[i,j]
  x <- 1
  while (TRUE){
    next_number <- mat[i, j+x]
    if(!isNumber(next_number)){
      break
    }
    number <- paste0(number, next_number)
    x <- x+1
    if(j+x > ncol(mat)){
      break
    }
  }
  return(number)
}

calculatePartSums <- function(d){
  part_sums <- 0
  for (i in 1:nrow(d)){
    j <- 1
    while (j <= ncol(d)){
      current <- d[i,j]
      if (!isNumber(current)){
        j <- j + 1
        next
      }
      number = getNumber(d, i, j)
      adj_symbol = FALSE
      for (k in 0:(nchar(number)-1)){
        adjacent <- getAdjacent(d, i, j+k)
        if (any(isSymbol(adjacent))){
          adj_symbol = TRUE
          break
        }
      }
      if (!adj_symbol){
        j <- j + nchar(number)
        next
      }
      part_sums = part_sums + as.numeric(number)
      j <- j + nchar(number)
    }
  }
  return(part_sums)
}

d_test <- as.matrix(read_fwf("data/03-test.txt", fwf_widths(rep(1, 10))))
d <- as.matrix(read_fwf("data/03-input.txt", fwf_widths(rep(1, 140))))

calculatePartSums(d_test)
calculatePartSums(d)

## Part 2
library(stringi)
getNumber2Way <- function(mat, i, j){
  number <- getNumber(mat, i, j)
  mat_rev <- mat[, ncol(mat):1]
  rev_j <- ncol(mat) - j + 1
  number_rev <- stri_reverse(getNumber(mat_rev, i, rev_j))
  if (nchar(number_rev) > 1){
    extra <- stri_sub(number_rev, to = -2)
    number <- paste0(extra, number)
  }
  return(number)
}

startOfNumber <- function(mat, i, j){
  a <- getNumber2Way(mat, i, j)
  b <- getNumber(mat, i, j)
  return(j - (nchar(a) - nchar(b)))
}

getAdjacentPositions <- function(mat, row, col){
  
  indices <- list(c(row - 1, col), 
                  c(row + 1, col), 
                  c(row, col - 1), 
                  c(row, col + 1),
                  # diagonals
                  c(row - 1, col - 1),
                  c(row - 1, col + 1),
                  c(row + 1, col -1),
                  c(row + 1, col + 1))
  oob <- sapply(indices, function(x) any(x < 1) | any(x > dim(mat)))
  indices <- indices[!oob]
  return(indices)

}

getGearRatio <- function(d, row, col){
  poses <- getAdjacentPositions(d, row, col)
  start_points <- c()
  numbers <- c()
  for (pos in poses){
    i = pos[1]
    j = pos[2]
    char = d[i, j]
    if (isNumber(char)){
      start <- startOfNumber(d, i, j)
      start_points <- unique(c(start_points, start))
      numbers <- unique(c(numbers, getNumber(d, i, start)))
    }
  }
  # THIS IS WRONG SINCE start_points ONLY TRACKS COLUMN NUMBER
  # if (length(start_points) < 2){
  #   print(c("not gear",row, col))
  #   print(numbers)
  #   return(0)
  # }
  
  # THIS WORKS, BUT ONLY BECAUSE NO NUMBERS ADJACENT TO THE SAME * ARE THE SAME
  if (length(numbers) < 2){
    return(0)
  }
  return(prod(as.numeric(numbers)))
}

sumGearRatios <- function(d){
  ratio_sum = 0
  for (i in 1:nrow(d)){
    for (j in 1:ncol(d)){
      if (d[i, j] == "*"){
        ratio_sum = ratio_sum + getGearRatio(d, i, j)
      }
    }
  }
  return(ratio_sum)
}

sumGearRatios(d_test)
sumGearRatios(d)


