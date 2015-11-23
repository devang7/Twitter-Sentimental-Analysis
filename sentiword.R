senti_score <- function(sentence,filename)
{
  library(NLP)
  library(openNLP)
  library(openNLPmodels.en)
  library(tm)
  library(stringr)
  library(gsubfn)
  library(plyr)
  tags <- character(length = 100000) 
  n <- read.csv("senti_wordnet.csv")
  w <- split(n,n$X..POS)
  yu1 <- w$a
  yu2 <- w$n
  yu3 <- w$r
  yu4 <- w$v
  airt1 <- lapply(yu1$SynsetTerms, function(x){gsub('#.*\\s*', '', x)})
  airt2 <- lapply(yu2$SynsetTerms, function(x){gsub('#.*\\s*', '', x)})
  airt3 <- lapply(yu3$SynsetTerms, function(x){gsub('#.*\\s*', '', x)})
  airt4 <- lapply(yu4$SynsetTerms, function(x){gsub('#.*\\s*', '', x)})

 
  scores <- laply(sentence, function(x){
    sent_token_annotator <- Maxent_Sent_Token_Annotator()
    word_token_annotator <- Maxent_Word_Token_Annotator()
    pos_tag_annotator <- Maxent_POS_Tag_Annotator()
    y1 <- annotate(x, list(sent_token_annotator, word_token_annotator))
    y2 <- annotate(x, pos_tag_annotator, y1)
    y2w <- subset(y2, type == "word")
    for (i in seq_along(y2w))
    {
      tags[i] <- y2w$features[[i]]
    }
    word.list <- str_split(tags, '\\s+')
    sum.pos <- 0;
    sum.neg <- 0;
    for (i in seq_along(word.list))
    {
      a <- word.list[[i]]
      a <- substr(a,0,1)
      a <- tolower(a)
      #n,a,r,v other ignore
      if(a[1] == 'a')
      {
        #print("a")
        b <- w$a
        t <- y2w[[i]]
        start <- t$start
        end <- t$end
        subt <- substring(x,start,end)
        v <- match(subt,airt1)
        p <- b$PosScore
        q <- b$NegScore
        if(!is.na(v))
        {
          sum.pos = sum.pos + p[[v]]
          sum.neg = sum.neg + q[[v]]
        }
        
      }
      if(a[1] == 'n')
      {
        #print("n")
        b <- w$n
        t <- y2w[[i]]
        start <- t$start
        end <- t$end
        subt <- substring(x,start,end)
        v <- match(subt,airt2)
        p <- b$PosScore
        q <- b$NegScore
        if(!is.na(v))
        {
          sum.pos = sum.pos + p[[v]]
          sum.neg = sum.neg + q[[v]]
        }
      }
      if(a[1] == 'r')
      {
        #print("r")
        b <- w$r
        t <- y2w[[i]]
        start <- t$start
        end <- t$end
        subt <- substring(x,start,end)
        v <- match(subt,airt3)
        p <- b$PosScore
        q <- b$NegScore
        
        if(!is.na(v))
        {
          sum.pos = sum.pos + p[[v]]
          sum.neg = sum.neg + q[[v]]
        }
      }
      if(a[1] == 'v')
      {
        #print("v")
        b <- w$v
        t <- y2w[[i]]
        start <- t$start
        end <- t$end
        subt <- substring(x,start,end)
        v <- match(subt,airt4)
        p <- b$PosScore
        q <- b$NegScore
        if(!is.na(v))
        {
          sum.pos = sum.pos + p[[v]]
          sum.neg = sum.neg + q[[v]]
        }
      }
    }
  
    if(sum.pos > sum.neg)
    {
      print(x)
      score <- 1
    }
    else if(sum.pos < sum.neg)
    {
      print(x)
      score <- -1
    }
    else
    {
      print(x)
      score <- 0 
    }
    
      
    return(score)
    
  }  
    
    )
  
  scores.df <- data.frame(score=scores, text=sentence)
  
  write.csv(scores.df,"result_post_snap.csv")
}
