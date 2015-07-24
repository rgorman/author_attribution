library(XML)
library(stylo)
source("code/corpusFunctions.R")
input.dir <- "data/relationFiles"
files.v <- dir(path=input.dir, pattern=".*xml")


book.freqs.l <- list ()
for (i in 1:length(files.v)) {
  doc.object <- xmlTreeParse(file.path(input.dir, files.v[i]), useInternalNodes=TRUE)
  sword.data <-getSwordNgramTableList(doc.object)
  book.freqs.l[[files.v[i]]] <-sword.data
  
}



#the following script collects the data for testing
#when the test data are full files use the immediately following sequence

input.dir2 <- "data/relationFiles/testFiles"
test.files.v <- dir (path=input.dir2, pattern=".*xml")

for (i in 1:length(test.files.v)) {
  doc.object <- xmlTreeParse(file.path(input.dir2, test.files.v[i]), useInternalNodes=TRUE)
  sword.data <-getSwordNgramTableList(doc.object)
  book.freqs.l[[test.files.v[i]]] <-sword.data
  
}


#when the test data are partial files, use the immediately following sequence

#the following script calls the user-defined function "getSwordChunkMaster).
#this function will return a list of lists of tables, each table with a maximum of words = the second variable


for(i in 1:length(test.files.v)){
  doc.object <- xmlTreeParse(file.path(input.dir2, test.files.v[i]), useInternalNodes=TRUE)
  chunk.data.l <- getSwordChunkMaster(doc.object, 2500)
  s <- sample(chunk.data.l, 1)
  book.freqs.l[[test.files.v[i]]] <-s
  
}



#converting an R list into a Data Matrix
freqs.l <- mapply(data.frame, ID=seq_along(book.freqs.l),
                  book.freqs.l, SIMPLIFY=FALSE, MoreArgs=list(stringsAsFactors=FALSE))


freqs.df <- do.call(rbind, freqs.l)

#convert from long form table to wide format
result <- xtabs(Freq ~ ID+sword.ngrams, data=freqs.df)

#convert wide format table to matrix object
final.m <- apply(result, 2, as.numeric)

file.names <- append(files.v, test.files.v, after=length(files.v))

#substitute files names for row numbers
rownames(final.m) <-file.names

rownames(final.m) <-files.v

#reduce data matrix to features with largest means (most common features)
smaller.m <- final.m[, apply(final.m,2,mean)>=.05]

#check size of reduced feature set
dim(smaller.m)

#process data through stylo
stylo.results <-stylo(frequencies = smaller.m)

rotated.stylo.freq.table <- t(stylo.results$table.with.all.freqs)

str(stylo.results)
names(stylo.results)
stylo.results$table.with.all.zscores
write.csv(stylo.results$distance.table, file ="results/clusters/test1_100_MFW.csv")
write.csv(stylo.results$table.with.all.freqs, file ="results/clusters/test2_199.csv")
write.csv(stylo.results$table.with.all.zscores, file ="results/clusters/test1_1210_MFW_zscores.csv")
write.csv(rotated.stylo.freq.table, file ="results/clusters/rotated_test1_200_3gram.csv")
