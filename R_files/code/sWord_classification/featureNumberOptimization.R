
# This is a script to test what number of features is the most effective when using the 
# Naive Bayes classification


sorted.df <- smaller.df[, order(colMeans(smaller.df), decreasing=TRUE) ]
write.csv (smaller.df, file="Rresults/Naive_Bayes_predictions/toSort.csv")