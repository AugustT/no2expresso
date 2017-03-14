# Function takes a vector of user names and returns the username
# with the most followers
topUser <- function(users){
  
  usersDetails <- lookupUsers(users)
  
  friendsCount <- NULL
  
  for(i in names(usersDetails)){
    
    friendsCount <- c(friendsCount, usersDetails[[i]]$getFollowersCount())
    
  }
  
  return(names(usersDetails)[grep(max(friendsCount),friendsCount)])
  
}