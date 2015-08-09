# object a is result of  a <- do.call (rbind, my.list)
head(a)
# create vector of levels used in row of sWord_predictions.l
levs <- levels(sWord_predictions.l[[11]])

# each row of object a is a vector to be used as an index in object levs. In this way, we replace the viector of factor-level numbers
# with author names
# results are stored in pred.author.l

pred.author.l <- list()
i <- 1

for (i in i:100) {
  levs <- levels(sWord_predictions.l[[i]])
  pred.author.l[[i]] <- levs[a[i,]]
  
  
}

# create table from list of vectors
pred.author.t <- do.call(rbind, pred.author.l)
# save table as .csv file
write.csv (pred.author.t, file="Rresults/Naive_Bayes_predictions/pred_authors.csv")



# each row of object f (below) is a vector to be used as an index in object true.levs. In this way, we replace the viector of factor-level numbers
# with author names
# results are stored in true.author.l


my.list <- mapply(data.frame, testing.classes.l)
f <- do.call (rbind, my.list)

pred.author.l[[2]]
sWord_predictions.l[[2]]


true.author.l <- list()
i <- 1

for (i in i:100) {
  true.levs <- levels(testing.classes.l[[i]])
  true.author.l[[i]] <- true.levs[f[i,]]
  
  
}

true.author.l[[1]]
testing.classes.l[[1]]

# create table from list of vectors
true.author.t <- do.call(rbind, true.author.l)
# save table as .csv file
write.csv (pred.author.t, file="Rresults/Naive_Bayes_predictions/true_authors.csv")


testing.classes.l[[5]]
true.author.t[5,]

#interleave rows of predicted and true authors, adding row of NA between sets
t_p.matrix <- interleave(pred.author.t, true.author.t, blank.m)

# save combined table as .csv file
write.csv (pred.author.t, file="Rresults/Naive_Bayes_predictions/true_authors.csv")