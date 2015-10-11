library(XML)

source("code/corpusFunctions.R")
input.dir <- "sWord_input/stat_files/combined_authors"
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

# reduce sorted.m to ratio of frequency/1
test.m <- sorted.m/100
View(test.m)

sorted.m <- test.m

# save results as .csv file
write.csv(sorted.m, file="Rresults/StatsRelPos542_Oct11.csv")

# create file with z-scores for sorted.m
zscore.m <- scale(sorted.m)
View(zscore.m)

# combine the  columns of sorted.m and zscore.m 
combined.m <- cbind (sorted.m, zscore.m)

View(combined.m)

# a vector to serve as an index to reorder the columns
s <- rep(1:542, each=2) + (0:1) * 542

# create container matrix
y <- matrix("blah", nrow=15, ncol=1)


# a loop to bind columns in desired order
i <- 1

for (i in 1:length(combined.m[1,])) {
 y <- cbind(y, combined.m[, s[i]])
  
}


# create a vector of column names to be added to object y

names <- rep(colnames(sorted.m), each=2)

# create vector of column ranks to be added to object y
ranks <- rep(1:542, each=2)
types <- rep(c("frequency", "z-score"), 542)

# save matrix and names and ranks vectors as scv files
write.csv(y, file="Rresults/zscores_Oct11.csv")
write.csv(names, file="Rresults/columnNames_Oct11.csv")
write.csv(ranks, file="Rresults/columnRanks_Oct11.csv")
write.csv(types, file="Rresults/columnTypes_Oct11.csv")
