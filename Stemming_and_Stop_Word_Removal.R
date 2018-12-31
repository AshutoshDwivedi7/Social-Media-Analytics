# read in the libraries we're going to use
library(tidyverse) # general utility & workflow functions
library(tidytext) # tidy implimentation of NLP methods
library(topicmodels) # for LDA topic modelling 
library(tm) # general text mining functions, making document term matrixes
library(SnowballC) # for stemming


#tweets <- read.csv(file.choose())

tweets <- result

# create a document term matrix to clean
tweetsCorpus <- Corpus(VectorSource(tweets$text)) 

docs <-tm_map(tweetsCorpus,content_transformer(tolower))

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
docs <- tm_map(docs, removeNumbers)

tweetsDTM <- DocumentTermMatrix(docs)

# convert the document term matrix to a tidytext corpus
tweetsDTM_tidy <- tidy(tweetsDTM)

# I'm going to add my own custom stop words that I don't think will be
# very informative in hotel tweets
custom_stop_words <- tibble(word = c("allergies","allergy","jimmykimmel","http","lol","make"))

# remove stopwords
tweetsDTM_tidy_cleaned <- tweetsDTM_tidy %>% # take our tidy dtm and...
  anti_join(stop_words, by = c("term" = "word")) %>% # remove English stopwords and...
  anti_join(custom_stop_words, by = c("term" = "word")) # remove my custom stopwords

# reconstruct cleaned documents (so that each word shows up the correct number of times)
cleaned_documents <- tweetsDTM_tidy_cleaned %>%
  group_by(document) %>% 
  mutate(terms = toString(rep(term, count))) %>%
  select(document, terms) %>%
  unique()

# check out what the cleaned documents look like (should just be a bunch of content words)
# in alphabetic order
head(cleaned_documents)

# stem the words (e.g. convert each word to its stem, where applicable)
tweetsDTM_tidy_cleaned <- tweetsDTM_tidy_cleaned %>% 
  mutate(stem = wordStem(term))

# reconstruct our documents
cleaned_documents <- tweetsDTM_tidy_cleaned %>%
  group_by(document) %>% 
  mutate(terms = toString(rep(stem, count))) %>%
  select(document, terms) %>%
  unique()

# now let's look at the new most informative terms
top_terms_by_topic_LDA(cleaned_documents$terms, number_of_topics = 5)

write.csv(result,"9000tweets.csv")
View(result)

