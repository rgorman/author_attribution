# A script to order raw scores produced by Naive Bayes from highest to lowest.
# The script associates each score with the relevant author.
# The author is given first, in even number rows of the data frame.
# The raw probability scores follow in the even numbered rows.


# read the raw scores .csv file into R
raw <- read.csv(file="rawErrors.csv", header=FALSE, as.is=TRUE)

# create sorted vector of raw scores to make first even row of data frame
sort(as.numeric(unlist(raw[2,])), decreasing=TRUE)

# create sorted vector of index locations to reorder author list to be entered into
# first odd row of data frame
order(as.numeric(unlist(raw[2,])), decreasing=TRUE)

# create vector of author names from vector of index locations (see previous step)
author <- raw[1, order(as.numeric(unlist(raw[2,])), decreasing=TRUE)]

# create data frame with one row (author names)
df <- data.frame(author, stringsAsFactors=FALSE)

# add row of propabilties to data frame
df[2,] <- sort(as.numeric(unlist(raw[2,])), decreasing=TRUE)


# create vectors of odd and even numbers to provide index locations in the following loop
odds <- seq(3, 5253, 2)
evens <- seq(4, 5254, 2)

# calculate number of iterations for following loop
length(evens)
length(odds)

# create counter variable and set to one
i <- 1

# run loop
for (i in 1:length(evens)) {
  
  scores <- sort(as.numeric(unlist(raw[evens[i],])), decreasing=TRUE)
  order(as.numeric(unlist(raw[evens[i],])), decreasing=TRUE)
  
  author <- raw[odds[i], order(as.numeric(unlist(raw[evens[i],])), decreasing=TRUE)]
  
  
  
  df[odds[i],]<- author
  df[evens[i],]<- scores
  
}


View(df)

# save results to disk
write.csv (df, file="orderedRawErrors.csv")


