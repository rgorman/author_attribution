library(XML)

source("code/corpusFunctions.R")
input.dir <- "sWord_input/stat_files/rel_pos_files"
files.v <- dir(path=input.dir, pattern=".*xml")

i <- 1
book.freqs.l <- list ()
for (i in 1:length(files.v)) {
  doc.object <- xmlTreeParse(file.path(input.dir, files.v[i]), useInternalNodes=TRUE)
  sword.data <-getSwordTableList(doc.object)
  book.freqs.l[[files.v[i]]] <-sword.data
  
}








summary(book.freqs.l)

#converting an R list into a Data Matrix
freqs.l <- mapply(data.frame, ID=seq_along(book.freqs.l),
                  book.freqs.l, SIMPLIFY=FALSE, MoreArgs=list(stringsAsFactors=FALSE))


freqs.df <- do.call(rbind, freqs.l)

#convert from long form table to wide format
result <- xtabs(Freq ~ ID+sword.content.lower, data=freqs.df)

dim(result)

#convert wide format table to matrix object
final.m <- apply(result, 2, as.numeric)

# create list of names for rows
bookids.v <- gsub(".xml", "", files.v)

#substitute files names for row numbers
rownames(final.m) <-bookids.v

rownames(final.m)

#reduce data matrix to features with largest means (most common features)
smaller.m <- final.m[, apply(final.m,2,mean)>=.015]

#check size of reduced feature set
dim(smaller.m)

# reorder variables in smaller.m by ferquency from highest to lowest
sorted.m <- smaller.m[, order(colMeans(smaller.m), decreasing=TRUE) ]

# check results
View(sorted.m)

# save results as .csv file
write.csv(sorted.m, file="Rresults/relPos544.csv")

