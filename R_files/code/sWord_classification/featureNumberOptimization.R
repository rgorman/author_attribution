
# This is a script to test what number of features is the most effective when using the 
# Naive Bayes classification

# sort smaller.df by column means
sorted.df <- smaller.df[, order(colMeans(smaller.df), decreasing=TRUE) ]



View(smaller.df)
View(sorted.df)
