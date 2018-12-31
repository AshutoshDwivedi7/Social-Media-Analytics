

text <- "
'cough',
'ache',
'pain',
'itch',
'sore throat',
'runny nose',
'fever',
'sneeze',
'dark circles',
'swell',
'ear ache',
'hives',
'rash',
'redden',
'peel',
'skin',
'watery',
'conjunctivitis',
'headache',
'nausea',
'weakness',
'chest pain',
'muscle weakness',
'chills',
'flu',
'tired',
'sweaty',
'thirsty',
'short of breath',
'light headed',
'dizzy',
'sleepy',
'ringing in ears',
'blurred vision',
'bleed',
'fatigue',
'appetite',
'depression',
'hallucination',
'anxiety',
'weight loss',
'cramps',
'shiver'"

text <- read.csv(file.choose())

docs <- Corpus(VectorSource(text$Side.effects))
docs <-tm_map(docs,content_transformer(tolower))

toSpace <- content_transformer(function(x, pattern) { return (gsub(pattern, " ", x))})
docs <- tm_map(docs, toSpace, "-")
docs <- tm_map(docs, toSpace, "'")
docs <- tm_map(docs, toSpace, "'")
docs <- tm_map(docs, toSpace, ".")
docs <- tm_map(docs, toSpace, """)
docs <- tm_map(docs, toSpace, """)
docs <- tm_map(docs, toSpace, "#")
docs <- tm_map(docs, toSpace, "<")
docs <- tm_map(docs, toSpace, ">")
docs <- tm_map(docs, toSpace, "@\\w+ *")
docs <- tm_map(docs, toSpace, "[^\x01-\x7F]")
docs <- tm_map(docs, toSpace, "(f|ht)tp(s?)://(.*)[.][a-z]+")
docs <- tm_map(docs, toSpace, ":")

text[1]
writeLines(as.character(docs[[1]]))

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
#docs1 <- docs

docs <- tm_map(docs,stemDocument, language = "english")
writeLines(as.character(docs1[[20]]))

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
write.csv(freq[ord],"side.effects.stemmed.csv")
