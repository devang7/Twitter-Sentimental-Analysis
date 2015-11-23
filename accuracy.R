accuracy <- function(a,b)
{
  calc <- sign(a)
  ideal <- b
  count <- 0
  for(i in 1:length(ideal))
  {
    if(calc[i] == ideal[i])
      count <- count + 1
  }
  acc <- ((count)/(length(ideal)))*100
  
}