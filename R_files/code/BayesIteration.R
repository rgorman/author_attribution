


# script to test Naive Bayes in multiple iterations.


# make list and vector objects to collect input and output data
testing.classes.l <- list()
sWord_predictions.l <- list()
sWord_predictions_raw.l <- list()
index.record.v <- NULL
err.matr.l <- list()
i <- 1

for (i in i:100) {
  #create vector of random integers = 10% of obs in smaller.df
  testing.index.v <- sample (seq (1, nrow(smaller.df)), 28)
  
  #create training and testing data matrices using testing.index.v and its inverse
  testing.data <- smaller.df[testing.index.v, ]
  training.data <- smaller.df[-testing.index.v, ]
  
  #create vectors of factors giving classes (here = authors) of each row in testing.data and training.data
  training.classes <- as.factor(author.v[-testing.index.v])
  testing.classes <- as.factor(author.v[testing.index.v])
  
  #train the algorithm using training.data and training classes
  sWord_classifier <- naiveBayes(training.data, training.classes)
  
  # test the algorithm by using sWord_classifier to predict() the testing.data
  #store results in list object
  sWord_predictions.l[[i]] <- predict(sWord_classifier, testing.data)
 
  
  # make a file of the raw probabilities
  sWord_predictions_raw.l[[i]] <- predict(sWord_classifier, testing.data, type = "raw")
  
  #make record of index vectors so we can identify the particular chunks
  index.record.v <- append(index.record.v, testing.index.v)
  
  #make record of testing_classes 
  testing.classes.l[[i]] <-testing.classes
  

  #make list of error matrices
  err.matr.l[[i]] <- errormatrix(testing.classes.l[[i]], sWord_predictions.l[[i]]) 
  
}

#combine all matrices contained in err.matr.l into one matrix for export to .csv file
a <- do.call(rbind, err.matr.l)
write.csv(a, file="Rresults/Naive_Bayes_predictions/error_matrix.csv")


#this function is applied to a list of lists of tables to convert to matrix
my.apply <- function(x){
  my.list <-mapply(data.frame, ID=seq_along(x),
                   x, SIMPLIFY=FALSE,
                   MoreArgs=list(stringsAsFactors=FALSE))
  my.df <- do.call(rbind, my.list)
  return(my.df)
}

b <- rbind(err.matr.l[[1]], err.matr.l[[2]])
