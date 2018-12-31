
data <- read.csv(file.choose())
View(data)

install.packages("tm")
install.packages("topicmodels")
install.packages("tmap")
install.packages("qdapRegex")
install.packages("SnowballC")
install.packages('plyr')
install.packages('stringr')


library(tm)
library(topicmodels)
library(tmap)
library(qdapRegex)
library("SnowballC")
library(plyr)
library(stringr)

#-----------------------#

factor <- as.factor(data$user_id)
ad_users <- as.data.frame(sort(table(factor), decreasing = F))
ad_users <-  as.vector(ad_users$factor)

source <- read.csv(file.choose())
Relevant_source <- as.vector(source$Source...Relevant )

final<-data[which(data$source==Relevant_source[1]),]
s1<-2

while(s1<length(Relevant_source)+1)
{
  final<-rbind(final,data[which(data$source==Relevant_source[s1]),])
  s1<-s1+1
}

View(final)

result <- data[which(data$user_id==ad_users[1]),]
s1<-2
while(s1<length(ad_users)-15)
{
  result<-rbind(result,data[which(data$user_id==ad_users[s1]),])
  s1<-s1+1
}
View(result)

write.csv(result,"Zyrtec_Final.csv")


library(plyr)
library(stringr)

#pos.words <- read.delim(file.choose())
#neg.words <- read.delim(file.choose())

pos.words<-scan('positive-words.txt', what = 'character', comment.char = '')
neg.words<-scan('negative.txt', what = 'character', comment.char = '')


score.sentiment<- function(sentences,pos.words,neg.words){
  
  scores<-laply(sentences,function(sentence,pos.words,neg.words){
    sentence<-gsub('[[:punct:]]',"",sentence)
    sentence<-gsub('[[:cntrl:]]',"",sentence)
    sentence<-gsub('\\d+',"",sentence)
    
    word.list<-str_split(sentence,'\\s+')
    words<-unlist(word.list)
    pos.matches<-match(words,pos.words)
    neg.matches<-match(words,neg.words)
    pos.matches<-!is.na(pos.matches)
    neg.matches<-!is.na(neg.matches)
    score<-sum(pos.matches)-sum(neg.matches)
    return(score)
  },pos.words,neg.words)
  scores.df<-data.frame(score=scores,text=sentences)
  return(scores.df)
}

# reading positive and negative words
test.score<-score.sentiment(result$text,pos.words,neg.words)
View(test.score)

negative <- test.score[test.score$score<0,]
View(negative)

write.csv(negative,"negative.csv")

data <- read.csv(file.choose())

#Stemming and frew words
docs <- Corpus(VectorSource(data$text))
docs <-tm_map(docs,content_transformer(tolower))

writeLines(as.character(docs[[1]]))

toSpace <- content_transformer(function(x, pattern) { return (gsub(pattern, " ", x))})
docs <- tm_map(docs, toSpace, "-")
docs <- tm_map(docs, toSpace, "'")
docs <- tm_map(docs, toSpace, "#")
docs <- tm_map(docs, toSpace, "<")
docs <- tm_map(docs, toSpace, ">")
docs <- tm_map(docs, toSpace, "@\\w+ *")
docs <- tm_map(docs, toSpace, "&\\w+ *")
docs <- tm_map(docs, toSpace, "[^\x01-\x7F]")
docs <- tm_map(docs, toSpace, "(f|ht)tp(s?)://(.*)[.][a-z]+")
docs <- tm_map(docs, toSpace, ":")

data$text[1]
writeLines(as.character(docs[[1]]))

tweets_stem <- data.frame(text = sapply(docs, as.character), stringsAsFactors = FALSE)

write.csv(tweets_stem,"Claritin_Negative_Tweets_Classified.csv")



#remove punctuation
docs <- tm_map(docs, removePunctuation)
#Strip digits
docs <- tm_map(docs, removeNumbers)
#remove stopwords
docs <- tm_map(docs, removeWords, stopwords("english"))
#remove whitespace
docs <- tm_map(docs, stripWhitespace)
#Good practice to check every now and then
writeLines(as.character(docs[[1]]))
#Stem document
docs1 <- docs

docs <- tm_map(docs,stemDocument, language = "english")
writeLines(as.character(docs[[1]]))

tweets_stem1 <- data.frame(text = sapply(cleaned_documents, as.character), stringsAsFactors = FALSE)

#Create document-term matrix
dtm <- DocumentTermMatrix(docs)
#convert rownames to filenames
#rownames(dtm) <- filenames
#collapse matrix by summing over columns
freq <- colSums(as.matrix(dtm))
#length should be total number of terms
length(freq)
#create sort order (descending)
ord <- order(freq,decreasing=TRUE)
#List all terms in decreasing order of freq and write to disk
freq[ord]

write.csv(freq[ord],"Result.csv")


