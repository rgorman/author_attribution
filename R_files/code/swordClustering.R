library(XML)

input.dir <- "data/relationFiles"
files.v <- dir(path=input.dir, pattern=".*xml")
file.v <- NULL
files.v


i <- 1
doc.object <- xmlTreeParse(file.path(input.dir, files.v[i]), useInternalNodes=TRUE)
swords <-getNodeSet(doc.object, "//sword", )
sword.content <- paste(sapply(swords, xmlValue), collapes = " ")
sword.content.lower <- tolower(sword.content)
book.freqs.t <-table(sword.content.lower)
book.freqs.rel.t <- 100*(book.freqs.t/sum(book.freqs.t))


getSwordTableList <- function(doc.object) {
  swords <-getNodeSet(doc.object, "//sword", )
  sword.content <- paste(sapply(swords, xmlValue), collapes = " ")
  sword.content.lower <- tolower(sword.content)
  book.freqs.t <-table(sword.content.lower)
  book.freqs.rel.t <- 100*(book.freqs.t/sum(book.freqs.t))
  return(book.freqs.rel.t)
}


library(XML)
source("code/corpusFunctions.R")
input.dir <- "data/relationFiles"
files.v <- dir(path=input.dir, pattern=".*xml")

book.freqs.l <- list ()
for (i in 1:length(files.v)) {
  doc.object <- xmlTreeParse(file.path(input.dir, files.v[i]), useInternalNodes=TRUE)
  sword.data <-getSwordTableList(doc.object)
  book.freqs.l[[files.v[i]]] <-sword.data
 
}

#converting an R list into a Data Matrix
freqs.l <- mapply(data.frame, ID=seq_along(book.freqs.l),
                  book.freqs.l, SIMPLIFY=FALSE, MoreArgs=list(stringsAsFactors=FALSE))

class(freqs.l[[1]])
class(book.freqs.l)
freqs.l[[2]][1:12, ]

freqs.df <- do.call(rbind, freqs.l)
dim(freqs.df)
freqs.df[100:150, ]

#convert from long form table to wide format
result <- xtabs(Freq ~ ID+sword.content.lower, data=freqs.df)

dim(result)
colnames(result)[1:10]
rownames(result)
class(result)

#convert wide format table to matrix object
final.m <- apply(result, 2, as.numeric)

#reduce data matrix to features with largest means (most common features)
smaller.m <- final.m[, apply(final.m,2,mean)>=.25]
dim(smaller.m)
colnames(smaller.m)
smaller.m

summary(smaller.m)



#create a distance object
dm <- dist(final.m)

#create distance object from smaller.
dm <-dist(final.m)

#perform a cluster analysis on the distance object
cluster <- hclust (dm)



#get the book file names to use as labels
cluster$labels <- names(book.freqs.l)

#plot the results as a dendogram for inspection
plot(cluster)




