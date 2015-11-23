library(RCurl)
library(twitteR)
library(ROAuth)

requestURL <- "https://api.twitter.com/oauth/request_token"
accessURL = "https://api.twitter.com/oauth/access_token"
authURL = "https://api.twitter.com/oauth/authorize"
consumerKey = "lPpQro0U5wKvunIprs1ZnJXyS"
consumerSecret = "tZjylHjtPpAjsxmwiwZEx57SLJslXerpzT9KLX22pmZaMm5F1U"
Cred <- OAuthFactory$new(consumerKey=consumerKey,
                         consumerSecret=consumerSecret,
                         requestURL=requestURL,
                         accessURL=accessURL, 
                         authURL=authURL)
#The next command provides a URL which you will need to copy and paste into your favourite browser
#Assuming you are logged into Twitter you will then be provided a PIN number to type into the R command line
Cred$handshake(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl") )