library(stringr)
d <- readLines("data/04-input.txt")
fields <- str_split(d, "[|:]") %>%
  lapply(str_trim)

wins <- lapply(fields, function(card){
  winning_numbers <- str_split_1(card[2], "[ ]+")
  your_numbers <- str_split_1(card[3], "[ ]+")
  sapply(your_numbers, function(number) number %in% winning_numbers)
})

n_wins <- sapply(wins, sum)
only_wins <- n_wins[n_wins > 0]

sum(2^(only_wins-1))

# part 2

addCards <- function(card_number, n_wins, total_cards = 223){

  score <- rep(0, total_cards)
  if(n_wins == 0){
    return(score)
  }
  new_cards <- ((card_number+1):(card_number+n_wins))
  score[new_cards] <- 1
  return(score[1:total_cards])
}


n_scratchcards <- rep(1, length(d))
for (i in 1:length(d)){
  cards_added <- addCards(i, n_wins[i]) * n_scratchcards[i]
  n_scratchcards <- n_scratchcards + cards_added
}

sum(n_scratchcards)



### THIS IS ALL WRONG

n_wins

n_scratchcards <- rep(1, length(d))
new_wins <- n_scratchcards
card_numbers <- 1:length(d)
have_winners = TRUE
while(have_winners){
  wins <- rowSums(mapply(addCards, card_numbers, n_wins))
  n_scratchcards <- n_scratchcards + new_wins * wins
  new_wins <- wins
  if(all(new_wins == 0)){
    have_winners <- FALSE
  }

  
}
