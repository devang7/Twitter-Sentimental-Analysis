score.afinn <- function(sentences)
{

require(plyr)
require(stringr)
r <- read.csv("afinn.csv")
affwords <- r$word
w <- r$weight
scores <- laply(sentences, function(sentence){
  word.list <- str_split(sentence, '\\s+')
  words <- unlist(word.list)
  sum <- 0
  for(i in 1:length(words))
  {
    v <- match(words[i],affwords)
    if(!is.na(v))
      sum <- sum + w[[v]]
  }
  return (sum)
  
}
  
  )
scores.df <- data.frame(score=scores, text=sentences)
write.csv(scores.df,"result_aff_flipkart.csv")

}