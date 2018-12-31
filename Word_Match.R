word.match <- function(sentences,list.words){
  
  scores<-laply(sentences,function(sentence,list.words){
    sentence<-gsub('[[:punct:]]',"",sentence)
    sentence<-gsub('[[:cntrl:]]',"",sentence)
    sentence<-gsub('\\d+',"",sentence)
    
    word.list<-str_split(sentence,'\\s+')
    words<-unlist(word.list)
    pos.matches<-match(words,list.words)
    
    pos.matches<-!is.na(pos.matches)
    score<-sum(pos.matches)
    return(score)
  },list.words)
  scores.df<-data.frame(score=scores,text=sentences)
  return(scores.df)
}

data <- read.csv(file.choose())
list.words<-scan(file.choose(), what = 'character', comment.char = '')

test.score<- word.match(claritin$text,list.words)

View(test.score)

Result <- test.score[test.score$score>0,]
write.csv(Result, "Result.csv")

