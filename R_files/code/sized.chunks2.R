library(XML)
library(stylo)
source("code/corpusFunctions.R")
input.dir <- "sWord_input"
files.v <- dir(path=input.dir, pattern=".*xml")

#the following script calls the user-defined function "getSwordChunkMaster).
#this function will return a list of lists of tables, each table with a maximum of words = the second variable

book.freqs.l <- list()
for(i in 1:length(files.v)){
  doc.object <- xmlTreeParse(file.path(input.dir, files.v[i]), useInternalNodes=TRUE)
  chunk.data.l <- getSwordChunkMaster(doc.object, 2000)
  book.freqs.l[[files.v[i]]] <-chunk.data.l
  
}






summary(book.freqs.l)

#convert list into matrix object
#this code requires the user defined function "my.apply"
freqs.l <- lapply(book.freqs.l, my.apply)

summary(freqs.l)

freqs.df <- do.call(rbind, freqs.l)
#the result is a long form data frame

dim(freqs.df)
head(freqs.df)
write.csv(freqs.df, file="sWord_output/inspect1.csv")

#make name labels for the file
bookids.v <- gsub(".xml.\\d+", "", rownames(freqs.df))
bookids.v[1:20]


freqs.df$ID[1:10]
#make book-with-chunk id labes

book.chunk.ids <- paste(bookids.v, freqs.df$ID, sep="_")
book.chunk.ids[1:20]

#replace the ID column in freqs.df
freqs.df$ID <- book.chunk.ids
head(freqs.df)

#cross tabulate data
result.t <- xtabs(Freq ~ ID+Var1, data=freqs.df)
dim(result.t)

  #convert to a data frame
final.df <- as.data.frame.matrix(result.t)

dim(final.df)



#make author vector and strip work name and book numbers from it
author.v <- gsub("_.+", "", rownames(final.df))
author.v[100:110]


head(author.v)
unique(author.v)
length(author.v)
author.v


#reduce the feature set
freq.means.v <- colMeans(final.df[, ])

#collect column means of a given magnitude
keepers.v <- which(freq.means.v >=.001)

keepers.v[1:10]

#use keepers.v to make a smaller data frame object for analysis
smaller.df <- final.df[, keepers.v]

# write smaller.df to disk for examination
write.csv(smaller.df, file="sWord_output/rel_csv/2000_sWord_chunks.csv")

dim(smaller.df)


#supervised classification of chunks using naive Bayes algorithm

# create vector of integers giving index points of random 10% of number of rows in smaller.df
seq (1, nrow(smaller.df))
testing.index.v <- sample (seq (1, nrow(smaller.df)), 28)

#create training and testing data matrices using testing.index.v and its inverse
testing.data <- smaller.df[testing.index.v, ]
training.data <- smaller.df[-testing.index.v, ]

#create vectors of factors giving classes (here = authors) of each row in testing.data and training.data


