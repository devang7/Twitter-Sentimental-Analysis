library(RCurl)
library(twitteR)
library(ROAuth)

requestURL <- "https://api.twitter.com/oauth/request_token"
accessURL = "https://api.twitter.com/oauth/access_token"
authURL = "https://api.twitter.com/oauth/authorize"
consumerKey = "ZsjdjsYoHVA2PTa1nZGJAOWVg"
consumerSecret = "oLDtMETOyQ884b40EJlhgP7D5br1HV3XcwnLuebf7oLfeIDN0u"
Cred <- OAuthFactory$new(consumerKey=consumerKey,
                         consumerSecret=consumerSecret,
                         requestURL=requestURL,
                         accessURL=accessURL, 
                         authURL=authURL)
#The next command provides a URL which you will need to copy and paste into your favourite browser
#Assuming you are logged into Twitter you will then be provided a PIN number to type into the R command line
Cred$handshake(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl") )