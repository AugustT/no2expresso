## Main Process
rm(list=ls())

# Load libraries
library(twitteR)
library(RCurl)

# Load scripts
files <- list.files(path='Scripts/')

# Read scripts
for(i in files) source(file.path('Scripts/',i))

# Get SinceID to NULL
sinceID <- NULL

# # Load credentials
load('auth.rdata')

# Set sink to log file
sink(file = 'log.txt', append = TRUE, split = TRUE)

a <- TRUE
while(a){

  # Setup oauth silently
  options(httr_oauth_cache = TRUE)
  try({setup_twitter_oauth(auth[1], auth[2], auth[3], auth[4])},
      silent = TRUE)
  
  # Read tweets
  tweets <- getTweets(query='expresso', sinceID = sinceID)
  sinceID <- attr(tweets, 'max_sinceID')

  # Remove ones in namesPast
  load('Data/namesPast.rdata')
  tweets <- tweets[!tweets$screenName %in% namesPast,]
  
  if(!is.null(tweets)){
    if(nrow(tweets) > 0){
      
      #get the top user
      topU <- topUser(users=tweets$screenName)
      tweets <- tweets[tweets$screenName == topU,]
      
      # Add name to the list
      namesPast <- c(namesPast, topU)
      save(namesPast, file = 'Data/namesPast.rdata')
      
      # Create reply text
      replyText <- paste(paste('@', tweets$screenName[1], sep=''), randText())
      
      # Send a reply
      x <- try(updateStatus(text = replyText, inReplyTo = tweets$id[1]), silent = TRUE)
      
      # Print progress to screen
      cat('\n', as.character(Sys.time()), '\n')
      cat('Recieved:', tweets$text[1], '\n')
      if(class(x) == 'try-error'){
        cat('Sent:', as.character(x), '\n')
      } else {
        cat('Sent:', replyText, '\n')
      }
      
    } else {
      cat('\n', as.character(Sys.time()), '\n')
    }
  } else {
    cat('\n', as.character(Sys.time()), '\n')
  }
  Sys.sleep(time=3600)
}