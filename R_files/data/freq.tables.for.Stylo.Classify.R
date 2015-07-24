# a script for author classification after Jockers 2014



library(stylo)
source("code/corpusFunctions.R")
input.dir <- "data/Classify/ClassifyFiles"
files.v <- dir(path=input.dir, pattern=".*txt")

#this script will work on chunks
#each input file will be divided into chunks
#it will be useful to discover the smallest chunk size that will deliver good results

#script requires user-defined funtion "getSwordSegmentTableList




book.freqs.l <- list()
for(i in 1:length(files.v)){
  doc.object <- scan(file.path(input.dir, files.v[i]), what="character")
  chunk.data.l <- getSwordChunksFromTxt(doc.object, 5)
  book.freqs.l[[files.v[i]]] <-chunk.data.l
  
}







#convert list into matrix object
#this code requires the user defined function "my.apply"
freqs.l <- lapply(book.freqs.l, my.apply)





freqs.df <- do.call(rbind, freqs.l)
#the result is a long form data frame

#save to excel to examine
write.csv(freqs.df, file="test.matrix.csv")

dim(freqs.df)
head(freqs.df)

#make name labels for the file
new.rownames.v <- gsub("\\.txt.", "", rownames(freqs.df))
new.rownames.v <- gsub("[0-9]+", "", new.rownames.v)

#make book-with-chunk id labes
book.chunk.ids <- paste(new.rownames.v, freqs.df$ID, sep="_")



#replace the ID column in freqs.df
freqs.df$ID <- book.chunk.ids
head(freqs.df)

#cross tabulate data
result.t <- xtabs(Freq ~ ID+Var1, data=freqs.df)
dim(result.t)



#convert to a data frame
final.df <- as.data.frame.matrix(result.t)
dim(final.df)

#save to excel to examine
write.csv(final.df, file="test.final.csv")

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
# freq.means.v <- colMeans(authorship.df[, 4:ncol(authorship.df)])
freq.means.v <- colMeans(final.df)


#collect column means of a given magnitude
keepers.v <- which(freq.means.v >=.0002)

keepers.v[1:10]

#use keepers.v to make a smaller data frame object for analysis
# smaller.df <- authorship.df[, c(names(authorship.df)[1:3],
                                names(keepers.v))]

smaller.df <- final.df[, keepers.v]


dim(smaller.df)
write.csv(smaller.df, file="smaller.df_A.csv")

ncol(smaller.df)

x <-1:nrow(smaller.df)
success.l <-list()

for(i in 1:100) {
train.v <- sample(x, nrow(smaller.df)*.25)



#smaller.df[train.v,]
training.df <- smaller.df[train.v,]
testing.df <- smaller.df[-train.v,]

# write.csv(training.df, file="trainingSet_A.csv")

my.classify.results <-classify(gui=FALSE, training.frequencies=training.df, test.frequencies=testing.df)
success.l[[i]] <-my.classify.results$success.rate

}

success.v <- append(success.v, my.classify.results$sucess.rate)
names(my.classify.results)
success.v

both.sets <-my.classify.results$frequencies.both.sets
rotated.both.sets <- t(both.sets)

write.csv(rotated.both.sets, file="freq.sets_A.csv")
my.classify.results$success.rate


success.v <-NULL

for (i in 1:100) {
success.v <-append(success.v, success.l[[i]][1], after=length(success.v))
}


mean(success.v)



