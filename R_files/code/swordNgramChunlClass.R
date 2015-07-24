# a script for author classification after Jockers 2014

library(XML)
library(stylo)
source("code/corpusFunctions.R")
input.dir <- "data/relationFiles"
files.v <- dir(path=input.dir, pattern=".*xml")

#this script will work on chunks
#each input file will be divided into chunks
#it will be useful to discover the smallest chunk size that will deliver good results

#ngram size must be set in the corpusFuntions.R source file

#script requires user-defined funtion "getSwordNgramSegmentTableList


book.freqs.l <- list()
for(i in 1:length(files.v)){
  doc.object <- xmlTreeParse(file.path(input.dir, files.v[i]), useInternalNodes=TRUE)
  chunk.data.l <- getSwordNgramSegmentTableList(doc.object, 10)
  book.freqs.l[[files.v[i]]] <-chunk.data.l
  
}

#convert list into matrix object
#this code requires the user defined function "my.apply"
freqs.l <- lapply(book.freqs.l, my.apply)


freqs.df <- do.call(rbind, freqs.l)
#the result is a long form data frame

dim(freqs.df)
head(freqs.df)

#make name labels for the file
bookids.v <- gsub("\\.rel.*", "", rownames(freqs.df))

#make book-with-chunk id labes
book.chunk.ids <- paste(bookids.v, freqs.df$ID, sep="_")

#replace the ID column in freqs.df
freqs.df$ID <- book.chunk.ids
head(freqs.df)

#cross tabulate data
result.t <- xtabs(Freq ~ ID+Var1, data=freqs.df)
dim(result.t)

#convert to a data frame
final.df <- as.data.frame.matrix(result.t)
dim(final.df)

#make human readable rownames for final.df
metacols.m <- do.call(rbind, strsplit(rownames(final.df), "_"))
head(metacols.m)

#make human readable column names
colnames(metacols.m) <- c("sampletext", "samplechunk")
head(metacols.m)
unique(metacols.m[, "sampletext"])

#make author vector and strip work name and book numbers from it
author.v <- gsub("\\..*", "", metacols.m[, "sampletext"])
author.v <- gsub("\\d+$", "", author.v)
head(author.v)
unique(author.v)
length(author.v)
author.v

#bind these metadata to final.df
authorship.df <- cbind(author.v, metacols.m, final.df)


#reduce the feature set
freq.means.v <- colMeans(authorship.df[, 4:ncol(authorship.df)])

#collect column means of a given magnitude
keepers.v <- which(freq.means.v >=.0002)

keepers.v[1:10]

#use keepers.v to make a smaller data frame object for analysis
smaller.df <- authorship.df[, c(names(authorship.df)[1:3],
                                names(keepers.v))]


dim(smaller.df)



train <- smaller.df[, 4:ncol(smaller.df)]
class.f <- smaller.df[, "author.v"]

library(e1071)
model.svm <- svm(train, class.f)



summary(model.svm)

pred.svm <- predict(model.svm, train)
summary(pred.svm)
as.data.frame(pred.svm)

table(pred.svm, class.f)


