
# This is a script to test what number of features is the most effective when using the 
# Naive Bayes classification

# sort smaller.df by column means
sorted.df <- smaller.df[, order(colMeans(smaller.df), decreasing=TRUE) ]



View(smaller.df)
View(sorted.df)




# read in .csv file with probabilities for chunks.  The goal is to make each author equally likely
# to be chosen

prob.m <- read.csv (file="Rresults/Naive_Bayes_predictions/chunkSize2000/chunk_parameters3.csv")

#load package e1071
library(e1071)
# load package gmodels for functions to evaluate predictions
library (gmodels)

# load package klar for errormatrix() function
library(klaR)

## we should delete much of what follows. Keep only enough to record results.  Data need not be  preserved.
# script to test Naive Bayes in multiple iterations.

# create vector with various number of features to be tested
feature.number.v <- seq(2, 500, 2)




# make list and vector objects to collect results


total.errors.l <-list()
intermediate.l <- list()
total.errors2.l <- list()

# set increment variables to 1
i <- 1
j <- 1

for (j in j:250) {
  
  error.v <- NULL
  feature.df <- sorted.df[, 1:feature.number.v[j]]
  
  for (i in i:100) {
    #create vector of random integers = 10% of obs in smaller.df
    testing.index.v <- sample (seq (1, nrow(feature.df)), 28, prob=prob.m$prob)
    
    #create training and testing data matrices using testing.index.v and its inverse
    testing.data <- feature.df[testing.index.v, ]
    training.data <- feature.df[-testing.index.v, ]
    
    #create vectors of factors giving classes (here = authors) of each row in testing.data and training.data
    training.classes <- as.factor(author.v[-testing.index.v])
    testing.classes <- as.factor(author.v[testing.index.v])
    
    #train the algorithm using training.data and training classes
    sWord_classifier <- naiveBayes(training.data, training.classes)
    
    
    # run classification algorithm and put results in object
    
    holder <- predict(sWord_classifier, testing.data)
    
    
    # create errror matrix of results and put into object    
    
    error.m <- errormatrix(testing.classes, holder)
    
    error.v <- append(error.v, error.m[12,12])
    
    intermediate.l[[i]] <-error.m[12,12]
    
    
    
  }
  
  # save grand total of errors for each iteration into list object along with number of features
  
  total.errors.l[[j]] <- c(feature.number.v[j], intermediate.l)
  total.errors2.l[[j]] <- error.v 
  
  i <- 1
  
}
  
                          
                           
  
save (total.errors.l, file="Rresults/iteration_list.R")
save (total.errors2.l, file="Rresults/iteration_list2.R")




error.total.v <- sum(error.v)

(s <-sum(error.v))
(r <- 1-(s/2800))

errors
#combine all matrices contained in err.matr.l into one matrix for export to .csv file
a <- do.call(rbind, err.matr.l)
write.csv(a, file="Rresults/Naive_Bayes_predictions/error_matrix.csv")
save(err.matr.l, file="Rresults/Naive_Bayes_predictions/errorMatrix.R")

# combine results in sWord_predictions.l into one data.frame object and save it as .csv file
my.list <- mapply(data.frame, sWord_predictions.l)
b <- do.call (rbind, my.list)
write.csv (b, file="Rresults/Naive_Bayes_predictions/predictions_made.csv")
save(sWord_predictions.l, file="Rresults/Naive_Bayes_predictions/predictionList.R")

# combine results in sWord_predictions_raw.l into one data.frame object and save it as .csv file
my.list <- mapply(data.frame, sWord_predictions_raw.l)
c <- do.call (rbind, my.list)
write.csv (c, file="Rresults/Naive_Bayes_predictions/raw_predictions_made.csv")
save(sWord_predictions_raw.l, file="Rresults/Naive_Bayes_predictions/rawPredictions.R")

# combine results in testing.classes.l into one data.frame object and save it as .csv file
my.list <- mapply(data.frame, testing.classes.l)
d <- do.call (rbind, my.list)
write.csv (d, file="Rresults/Naive_Bayes_predictions/right_answers.csv")
save(testing.classes.l, file="Rresults/Naive_Bayes_predictions/correctAnswers.R")

#save list of sWord_classifier objects as binary file
save(sW.classifier.l, file="Rresults/Naive_Bayes_predictions/list_of_classifiers.R")

# save the index numbers so that chunks can be traced back to originals
# one file is a matrix with each classification attempt represented on 
#one line, the other file is a single vector to serve as back up.
index.record.m <- matrix(index.record.v, nrow=100, ncol=28, byrow=TRUE)
write.csv(index.record.m, file="Rresults/Naive_Bayes_predictions/index_matrix.csv")
write.csv(index.record.v, file="Rresults/Naive_Bayes_predictions/index_vector.csv")
