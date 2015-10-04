
## Note!! adjust this script to remove short chunks. A vector of the index numbers of rows
# containing short chunks has been saved as Rresults/short_chunks.csv. This can be used to cull
# short chunks from the smaller.df object. Likewise, use Rresults/short_parameters.csv 
# to set probabiliites below (insted of prob.m).


# read in .csv file with probabilities for chunks.  The goal is to make each author equally likely
# to be chosen
# !! this step must be moved to precede creation of data frame. Otherwise, the presence of factors
# will break the code!


# read in appropriate parameter file to make probabilities available
full.prob.m <- read.csv (file="Rresults/Naive_Bayes_predictions/chunkSize2000/chunk_parameters5.csv")
short.prob.m <- read.csv (file="Rresults/short_parameters2.csv")

# choose appropriate file for prop.m, which will be used in chunk selection via sample() below.
prob.m <- full.prob.m
prob.m <- short.prob.m


#load package e1071
library(e1071)
# load package gmodels for functions to evaluate predictions
library (gmodels)

# load package klar for errormatrix() function
library(klaR)


# script to test svm in multiple iterations.


# make list and vector objects to collect input and output data

svm.results.l <- list()
svm.error.matrix.l <- list()
testing.classes.l <- list()

i <- 1





for (i in 1:1000) {
  #create vector of random integers = 10% of obs in smaller.df
  testing.index.v <- sample (seq (1, nrow(smaller.df)), 24, prob=prob.m$Prob)
  
  
  
  #create training and testing data matrices using testing.index.v and its inverse
  testing.data <- smaller.df[testing.index.v, ]
  training.data <- smaller.df[-testing.index.v, ]
  
  #create vectors of factors giving classes (here = authors) of each row in testing.data and training.data
  training.classes <- as.factor(author.v[-testing.index.v])
  testing.classes <- as.factor(author.v[testing.index.v])
  
  # carry out prediction test using svm
  svm.results.l[[i]] <- perform.svm(training.data, testing.data)
  
  svm.error.matrix.l[[i]] <- errormatrix(testing.classes, svm.results.l[[i]])
  
   
  #make record of testing_classes 
  testing.classes.l[[i]] <-testing.classes
  

 
  
}


#save the resulting list
save(svm.results.l, file="Rresults/svm_predictions/svmResults_Oct3.R")

#combine all matrices contained in err.matr.l into one matrix for export to .csv file
a <- do.call(rbind, svm.error.matrix.l)
write.csv(a, file="Rresults/svm_predictions/svmError_matrix_Oct3.csv")
save(svm.error.matrix.l, file="Rresults/svm_predictions/svmErrorMatrix_Oct3.R")


# combine results in testing.classes.l into one data.frame object and save it as .csv file
my.list <- mapply(data.frame, testing.classes.l)
d <- do.call (rbind, my.list)
write.csv (d, file="Rresults/svm_predictions/right_answers_Oct3.csv")
save(testing.classes.l, file="Rresults/svm_predictions/correctAnswers_Oct3.R")




