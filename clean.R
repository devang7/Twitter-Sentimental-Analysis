iclean <- function(sentences, filename)
{
  require(plyr)
  require(stringr)
  
  sent <- laply(sentences, function(sentence)
  {
    sentence <- gsub('(?:^|(?<=\\s))(?:(c\\+\\+|c#)|http://[^\\s]*|[^\\s]*[#/:+]+[^\\s]*)(?:\\s|$)', '\\1', sentence, perl=TRUE)
    
    sentence <- gsub("[^\\s]*@[^\\s]*","", sentence, perl=T) ##remove mentions
    sentence <- gsub("^\\s+|\\s+$", "", sentence) ##remove trailing and leading spaces
    sentence <- tolower(sentence)
    
  })
  filename <- paste(filename, "csv", sep=".")
  write.table(sent, file=filename,sep = ",",append = TRUE)
}

