
# This is a script to test what number of features is the most effective when using the 
# Naive Bayes classification

# sort smaller.df by column means
ordered.df <- smaller.df[, order(colMeans(smaller.df), decreasing=TRUE) ]



View(smaller.df)
View(ordered.df)




# read in .csv file with probabilities for chunks.  The goal is to make each author equally likely
# to be chosen

prob.m <- read.csv (file="Rresults/Naive_Bayes_predictions/chunkSize2000/chunk_parameters5.csv")

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
    feature.df <- ordered.df[, 1:feature.number.v[j]]
    
    for (i in i:100) {
        #create vector of random integers = 10% of obs in smaller.df
            testing.index.v <- sample (seq (1, nrow(feature.df)), 24, prob=prob.m$Prob)
          
          #create training and testing data matrices using testing.index.v and its inverse
          testing.data <- feature.df[testing.index.v, ]
          training.data <- feature.df[-testing.index.v, ]
          
          #create vectors of factors giving classes (here = authors) of each row in testing.data and            # training.data
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

