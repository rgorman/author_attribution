# script to test functions in stylo(). First run sWordStats.R

require(stylo)

# reduce number of columns in sorted.m for easier reading of results
reduced.m <-sorted.m[, 1:100]
View(reduced.m)

# run dist.delta() from stylo package to examine results

delta.scores <-as.matrix (dist.delta(reduced.m))


# result is a matrix with a Burrows Delta score for each pair of input files.
View(delta.scores)

cosine.scores <- as.matrix(dist.cosine(training.data))
View(cosine.scores)
