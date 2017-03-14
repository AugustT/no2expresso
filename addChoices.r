# A SCRIPT TO add options

load('Data/choices.rdata')

choices

choices <- c(choices,
             "It is all a matter of perspective, you say expresso, I say espresso pic.twitter.com/CCGUjsfM37",
             "Admittedly, I had to look up what 'plosive' meant... pic.twitter.com/o3YN3sYRpC",
             "This comic strip made me laugh, I have the same feeling when I hear people say expresso! pic.twitter.com/42cq6HZlUp")
save(choices,file='Data/choices.rdata')
