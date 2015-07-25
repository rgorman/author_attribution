library(XML)
source("code/corpusFunctions.R")

input.dir <- "../wordOrder_output/wordOrder_lemma"
files.v <- dir(path=input.dir, pattern=".*xml")


files.v

#create vector of names for later use
names_for_files.v <- gsub (".xml", "", files.v)




#create a list with relative frequency tables of contents of <word> elements

book.freqs.l <- list ()
for (i in 1:length(files.v)) {
  doc.object <- xmlTreeParse(file.path(input.dir, files.v[i]), useInternalNodes=TRUE)
  sword.data <-getRelationTableList(doc.object)
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
result <- xtabs(Freq ~ ID+word.content.lower, data=freqs.df)

dim(result)

colnames(result)[1:10]
rownames(result)


class(result)

#convert wide format table to matrix object
final.m <- apply(result, 2, as.numeric)

dim(final.m)

#add human readable rownames

row.names(final.m) <- names_for_files.v
row.names(result) <- names_for_files.v
rownames(final.m)
colnames(final.m)[1:10]

#save result and final.m objects for possible later reuse. Reload with readRDS()
saveRDS(result, "sWord_relations_wide.rds")
saveRDS(final.m, "sWord_relations_matrix.rds")

# note that the number of total lemmas in corpus (7-25-15) is c. 27,786
#reduce data matrix to features with largest means (most common features)
# a value of ">=.023" give roughly the 500 most common lemma
smaller.m <- final.m[, apply(final.m,2,mean)>=.023]
dim(smaller.m)
colnames(smaller.m)
smaller.m

#save smaller.m to csv file for viewing
write.csv (smaller.m, "Rresults/WordOrd_lemma.csv", fileEncoding="UTF-8")

summary(smaller.m)



#create a distance object
dm <- dist(final.m)

#create distance object from smaller.
dm <-dist(smaller.m)


#save distance object to csv file for viewing
write.csv (dm, "Rresults/sWord_rel_500_DistObj.csv")

#perform a cluster analysis on the distance object
cluster <- hclust (dm)



#get the book file names to use as labels
cluster$labels <- names(book.freqs.l)

#plot the results as a dendogram for inspection
plot(cluster)
smaller.m


