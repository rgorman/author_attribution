library(XML)
library(tm)
library(stylo)
source("code/corpusFunctions.R")

# input from proiel files
input.dir <- "../proiel/proiel_output"
files.v <- dir(path=input.dir, pattern=".*xml")


# input from aldt files for comparison 
input.dir <- "sWord_input/stat_files/divided_authors"
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

#convert from long form table to wide format
result <- xtabs(Freq ~ ID+sword.ngrams, data=freqs.df)

#convert wide format table to matrix object
final.m <- apply(result, 2, as.numeric)

dim(final.m)

# make names for rows
names_for_files.v <- gsub (".xml", "", files.v)


#substitute files names for row numbers
rownames(final.m) <-names_for_files.v

rownames(final.m)

View(final.m)
dim(final.m)

#reduce data matrix to features with largest means (most common features)
smaller.m <- final.m[, apply(final.m,2,mean)>=.0025]

#check size of reduced feature set
dim(smaller.m)


#create distance object as input to hclust algorithm. Possible methods are "euclidian", "maximum", "manhattan", "canberra", "binary" or "minkowski". Default is "euclidian".
dist.smaller.m <- dist(smaller.m)


# run hclust and get result in object (available methods are "ward.D", "ward.D2", "single", "complete" "average", "mcquitty", "median", or "centroid")
groups <- hclust(dist.smaller.m, method="ward.D2")

# plot the results
plot(groups, hang=-1)

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
