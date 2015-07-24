

#reduce the feature set
freq.means.v <- colMeans(final.df)


#collect column means of a given magnitude
keepers.v <- which(freq.means.v >=.00025)

#use keepers.v to make a smaller data frame object for analysis
smaller.df <- final.df[, keepers.v]


dim(smaller.df)

stylo.results <- stylo(frequencies = smaller.df)
stylo.results
summary(stylo.results)
stylo.results$distance.table
