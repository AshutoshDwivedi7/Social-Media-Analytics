#Clear R Environment
rm(list=ls())
#Load required libraries
install.packages("twitteR")
install.packages("ROAuth")
library("twitteR")
library("ROAuth")
# Download the file and store in your working directory
download.file(url= "http://curl.haxx.se/ca/cacert.pem", destfile= "cacert.pem")

#Insert your consumerKey and consumerSecret below
credentials <- OAuthFactory$new(consumerKey='HSTLjObUdFB1eVrljsZ2B7dz9',
                                consumerSecret='1ZIQAHs0gYoNPa125MMqZCH4KjgFwkvrXoewjjoQXvB6rtCsNr',
                                oauthKey = '745817120005591040-MNqssFHcQKEnqjSbwBWSFF6qBAxOrF0',
                                oauthSecret = 'jRZZD731PDsFXbQqWps1XlMRln4TeHrz5kg9Q3waTKW57',
                                requestURL='https://api.twitter.com/oauth/request_token',
                                accessURL='https://api.twitter.com/oauth/access_token',
                                authURL='https://api.twitter.com/oauth/authorize')



#Register Twitter Authentication
setup_twitter_oauth(credentials$consumerKey, credentials$consumerSecret, credentials$oauthKey, credentials$oauthSecret)
#Extract Tweets with concerned string(first argument), followed by number of tweets (n) and language (lang)
tweets <- searchTwitter('Claritin', n=3000, lang="en")

df <- do.call("rbind", lapply(tweets, as.data.frame))

View(df)
