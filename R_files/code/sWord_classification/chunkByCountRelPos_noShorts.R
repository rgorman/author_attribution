library(XML)

source("code/corpusFunctions.R")
input.dir <- "sWord_input/stat_files/rel_pos_files"
files.v <- dir(path=input.dir, pattern=".*xml")





#the following script calls the user-defined function "getSwordChunkMaster).
#this function will return a list of lists of tables, each table with a maximum of words = the second variable

book.freqs.l <- list()
for(i in 1:length(files.v)){
  doc.object <- xmlTreeParse(file.path(input.dir, files.v[i]), useInternalNodes=TRUE)
  chunk.data.l <- getSwordChunkMaster(doc.object, 2000)
  book.freqs.l[[files.v[i]]] <-chunk.data.l
  
}






summary(book.freqs.l)
freqs.l <- list()

#convert list into matrix object
#this code requires the user defined function "my.apply"
freqs.l <- lapply(book.freqs.l, my.apply)

summary(freqs.l)

freqs.df <- do.call(rbind, freqs.l)
#the result is a long form data frame

dim(freqs.df)

# create .csv file for inspection (very optional!!)
write.csv(freqs.df, file="sWord_output/inspect1.csv")

#make name labels for the file
bookids.v <- gsub(".xml.\\d+", "", rownames(freqs.df))




#make book-with-chunk id labes

book.chunk.ids <- paste(bookids.v, freqs.df$ID, sep="_")


#replace the ID column in freqs.df
freqs.df$ID <- book.chunk.ids


#cross tabulate data
result.t <- xtabs(Freq ~ ID+Var1, data=freqs.df)
dim(result.t)

# read in index of short chunk row  numbers
short.chunks <- read.csv (file="Rresults/short_chunks2.csv")
View(short.chunks)
skip.v <-as.vector(short.chunks[,2])




# save original result.t
reserve.t <- result.t

# remove rows indicated by skip.v
result.t <- result.t[-skip.v,] 

dim(result.t)
dim(reserve.t)

#convert to a data frame
final.df <- as.data.frame.matrix(result.t)



#make author vector and strip work name and book numbers from it
author.v <- gsub("_.+", "", rownames(final.df))

head(author.v)
unique(author.v)
length(author.v)
author.v


#reduce the feature set
freq.means.v <- colMeans(final.df[, ])

#collect column means of a given magnitude
keepers.v <- which(freq.means.v >=.00015)


#use keepers.v to make a smaller data frame object for analysis
smaller.df <- final.df[, keepers.v]


dim(smaller.df)


# order columns by column mean, largest to smallest and create object with results
ordered.df <- smaller.df[, order(colMeans(smaller.df), decreasing=TRUE)]
View(ordered.df)

# reseve full ordered.df and smaller.df for backup
ordered.df.backup <- ordered.df
smaller.df.backup <- smaller.df

# reduce variables from ordered.df (165 for rel-pos files is the sweet spot)
smaller.df <- ordered.df[, 1:165]

View(smaller.df)
