# Script to create files for matrix of correct answers and predictions with raw scores


# create a matrix with ncol equaling number of chunks per round of predictions
correct.m <- matrix(nrow=1, ncol=24)
View(preds.m)

# loop to fill correct.m with correct authors (from testing.classes.l)

i <- 1

for (i in 1:100) {
  
  correct.m <- rbind (correct.m, as.character(testing.classes.l[[i]]) )
  
  
}


# create vector container for correct authors
correct.v <-NULL



# fill correct.v with successive rows of correct.m
for (i in 2:101) {
 
  correct.v <- append(correct.v, as.vector(correct.m[i,]))
  
}

View(correct.v)

# transform correct.v to matrix of one column so that we can apply interleave()
# from library(gdata)

require(gdata)



final.correct.m <- matrix (correct.v, nrow=2400, ncol=1, )
View(final.preds.m)


# create matrix of gibberish to interleave() with final.correct.m
blanks.m <- matrix(rep("bugger all", 2400), nrow=2400, ncol=1)
  
# interleave matrices
correctWithBlanks.m <- interleave(final.correct.m, blanks.m)
View(correctWithBlanks.m)

# save as csv file
write.csv (correctWithBlanks.m, file="Rresults/CorrectWithBlanks.csv")

 
# the following section creates matrix of raw predictions. The raw probabilities are  ordred from highest to lowest


# make vector of author names
author.v <- c("Aeschylus", "Athenaeus", "Diodorus", "Hdt", "Hesiod", "Iliad",  "Odyssey", "Plutarch", "Polybius", "Sophocles", "Thucydides")


# make matrices as containers for rows from sWord_predictions_raw.l

unordered.holder <- matrix(author.v, nrow=1, ncol= 11)
ordered.holder <- matrix(author.v, nrow=1, ncol= 11)

# run loop to pull data from sWord_predictions_raw.l and order it

i <- 1
j <- 1

for (i in 1:100) {
  
  for (j in 1:24) {
    
    unordered.holder <- rbind(author.v, as.vector( sWord_predictions_raw.l[[i]][j,]))
    
    ordered.holder <-rbind(ordered.holder, unordered.holder[, order(as.numeric(unordered.holder[2,]), decreasing=TRUE)])
    
  }
  
  j <- 1
}


write.csv (ordered.holder, file="Rresults/sortedRawPredictions_sept26.csv")

# the two csv files created from this script should be combined to form a single spread sheet containing correct authors and predicitons made by the algorithm.
