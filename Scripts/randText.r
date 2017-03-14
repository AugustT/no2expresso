# Script to generate random text response

randText <- function(){
  
  load(file='Data/choices.rdata')

  return(sample(choices,1))
}