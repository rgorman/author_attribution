
# This is a script to test what number of features is the most effective when using the 
# Naive Bayes classification

# sort smaller.df by column means
sorted.df <- smaller.df[, order(colMeans(smaller.df), decreasing=TRUE) ]



View(smaller.df)
View(sorted.df)




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

  



