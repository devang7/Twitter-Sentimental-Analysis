realtime <- function(hastag,t,jasonfilename, csvfilename)
{
  library(streamR);
  library(stringr);
  jfilename <- paste(jasonfilename,"json",sep = ".");
  filterStream( file.name=jfilename,track = hastag, oauth=Cred, timeout= t, lang='en' )
  tweet_df <- parseTweets(tweets= jfilename);
  filename <- paste(csvfilename, "csv", sep=".")
  write.table(tweet_df, file=filename, sep = "," ,append=TRUE)
  
}