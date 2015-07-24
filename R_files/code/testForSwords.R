
#collect column means of a given magnitude
keepers.v <- which(freq.means.v >=.00025)

keepers.v[1:10]

#use keepers.v to make a smaller data frame object for analysis
smaller.df <- authorship.df[, c(names(authorship.df)[1:3],
                                names(keepers.v))]
library(e1071)

#begin script HERE if data are coming directly from "sized.chunks.R"
#use rm() to free up memory by deleting all files except "freq.means.v", "authorship.df", "smaller.df", and "keepers.v"

rm(freqs.l)

dim(smaller.df)
nrow(smaller.df)
index <- sample(nrow(smaller.df), 20)

train <- smaller.df[-index, 4:ncol(smaller.df)]
class.f <- smaller.df[-index, "author.v"]
test <-smaller.df[index, 4:ncol(smaller.df)]
class.f.neg <- smaller.df[index, "author.v"]

classify.results <-classify(training.frequencies = "train_1", test.frequencies = "test_1")
 model.svm <- svm(train, class.f)
pred.svm <- predict(model.svm, test)


summary(model.svm)

pred.svm <- predict(model.svm, train)
summary(pred.svm)
summary(model.svm)
as.data.frame(pred.svm)

chunks.to.read <- as.data.frame(pred.svm)
write.csv(chunks.to.read, "data/proseFiles/chunks_Feb_5.csv")
write.csv(train, "data/filesForClassify/train_1.csv")
write.csv(test, "data/filesForClassify/test_1.csv")

test_1 <-read.csv("data/filesForClassify/test_1.csv")
train_1 <-read.csv("data/filesForClassify/train_1.csv")


str(pred.svm)

tab <-table(pred.svm, class.f.neg)
tab
ca.result <-  classAgreement(tab, match.names=TRUE)
str(ca.result)
ca.result

# the following script should iterate the svm classificaiton test and return data on accuracy


test.results.l <- list()
guess.l <- list()
for (i in 1:10){
  
  index <- sample(nrow(smaller.df), 10)
  
  train <- smaller.df[-index, 4:ncol(smaller.df)]
  class.f <- smaller.df[-index, "author.v"]
  test <-smaller.df[index, 4:ncol(smaller.df)]
  class.f.neg <- smaller.df[index, "author.v"]
  
  model.svm <- svm(train, class.f)
  pred.svm <- predict(model.svm, test)
  guess.l[[i]] <-pred.svm
  tab <- table(pred.svm, class.f.neg)
  test.results.l[[i]] <- classAgreement(tab, match.names=TRUE)
 
  
  
}

ag <- my.apply(test.results.l)
ag
test.summary <- colMeans(ag[2:5])
test.summary

write.csv(ag, "data/proseFiles/test3_Feb_8.csv")
save (guess.l, file="data/proseFiles/guessList3_Feb_8.Rdata")
smaller.df[[1]][1]
summary(smaller.df)
colMeans(ag[1:5])
summary(guess.l)
table(guess.l[[1]], class.f.neg)

resulsLists <- my.apply(guess.l)
write.csv(guess.l, "data/proseFiles/guessList_Feb_5.csv")
as.data.frame <- guess.l
rm(as.data.frame)
as.data.frame(guess.l)
