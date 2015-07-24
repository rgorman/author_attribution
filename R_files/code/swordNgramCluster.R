
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

#converting an R list into a Data Matrix
freqs.l <- mapply(data.frame, ID=seq_along(book.freqs.l),
                  book.freqs.l, SIMPLIFY=FALSE, MoreArgs=list(stringsAsFactors=FALSE))



freqs.df <- do.call(rbind, freqs.l)
dim(freqs.df)
freqs.df[100:150, ]

files.v

#make name labels for the file
bookids.v <- gsub("\\.rel.*", "", files.v)
bookids.v


#convert from long form table to wide format
result <- xtabs(Freq ~ ID+sword.ngrams, data=freqs.df)

dim(result)
colnames(result)[1:10]
rownames(result)
str(result)

class(result)

#convert wide format table to matrix object
final.m <- apply(result, 2, as.numeric)
rownames(final.m) <-files.v
str(final.m)

#reduce data matrix to features with largest means (most common features)
smaller.m <- final.m[, apply(final.m,2,mean)>=.01]
dim(smaller.m)
colnames(smaller.m)
rownames(smaller.m)
smaller.m

summary(smaller.m)

stylo.results <-stylo(frequencies = smaller.m)
str(stylo.results)
stylo.results$distance.table
names(stylo.results)

#create a distance object
dm <- dist(final.m)

#create distance object from smaller.
dm <-dist(smaller.m)

#perform a cluster analysis on the distance object
cluster <- hclust (dm)



#get the book file names to use as labels
cluster$labels <- names(book.freqs.l)

#plot the results as a dendogram for inspection
plot(cluster)
