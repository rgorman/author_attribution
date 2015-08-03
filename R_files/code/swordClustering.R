library(XML)

input.dir <- "../sWord_output/sWord_from_root/sWord_root_rel"
files.v <- dir(path=input.dir, pattern=".*xml")


files.v

#create vector of names for later use
names_for_files.v <- gsub (".xml", "", files.v)


i <- 1
doc.object <- xmlTreeParse(file.path(input.dir, files.v[i]), useInternalNodes=TRUE)
swords <-getNodeSet(doc.object, "//sword", )
sword.content <- paste(sapply(swords, xmlValue), collapes = " ")
sword.content.lower <- tolower(sword.content)
book.freqs.t <-table(sword.content.lower)
book.freqs.rel.t <- 100*(book.freqs.t/sum(book.freqs.t))


getSwordTableList <- function(doc.object) {
  swords <-getNodeSet(doc.object, "//sWord", )
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
# this command may turn each list into a data frame object
# the code "ID=seq_along(book.freqs.l)" creates an ID for
# each work
freqs.l <- mapply(data.frame, ID=seq_along(book.freqs.l),
                  book.freqs.l, SIMPLIFY=FALSE, MoreArgs=list(stringsAsFactors=FALSE))

#this command binds each sub list into a column in a table
freqs.df <- do.call(rbind, freqs.l)
str(freqs.df)

freqs.df[1, 2]
freqs.l[[1]]

#convert from long form table to wide format
result <- xtabs(Freq ~ ID+sword.content.lower, data=freqs.df)

dim(result)
colnames(result)[1:10]
rownames(result)


class(result)

#convert wide format table to matrix object
final.m <- apply(result, 2, as.numeric)

#add human readable rownames

row.names(final.m) <- names_for_files.v
row.names(result) <- names_for_files.v
rownames(final.m)
colnames(final.m)[1:10]

#save result and final.m objects for possible later reuse. Reload with readRDS()
saveRDS(result, "sWord_relations_wide.rds")
saveRDS(final.m, "sWord_relations_matrix.rds")

#reduce data matrix to features with largest means (most common features)
# a value of ">=.0142" give roughly the 500 most common rel sWords
smaller.m <- final.m[, apply(final.m,2,mean)>=.0142]
dim(smaller.m)
colnames(smaller.m)
smaller.m

#save smaller.m to csv file for viewing
write.csv (smaller.m, "Rresults/sWord_rel_500.csv")

summary(smaller.m)

sorted.m <- read.csv(file="Rresults/sorted_rel.csv")

#create a distance object
dm <- dist(final.m)

#create distance object from smaller.
dm <-dist(smaller.m)

# distance object from file without 25 most frequent sWords
sorted_dm <-dist(sorted.m)
sorted_cluster <- hclust(sorted_dm)
str (sorted_cluster)
sorted_cluster$labels <- names(book.freqs.l)
plot (sorted_cluster)



#save distance object to csv file for viewing
write.csv (dm, "Rresults/sWord_rel_500_DistObj.csv")

#perform a cluster analysis on the distance object
cluster <- hclust (dm)



#get the book file names to use as labels
cluster$labels <- names(book.freqs.l)

#plot the results as a dendogram for inspection
plot(cluster)




