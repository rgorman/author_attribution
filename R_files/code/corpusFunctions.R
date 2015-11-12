
# function to print a vector of file names in user-friendly format
show.files <- function(file.name.v) {
  for (i in 1:length(file.name.v)){
    cat (i, file.name.v[i], "\n", sep = " ")
  }
  
}

# function takes a vector of file names and a directory path and returns 
# a list in which each item in the list is an ordered vector of words
# from one of the files in the vector of file names
make.file.word.v.l <- function(files.v, input.dir) {
  #set up an empty container
  text.word.vector.l <- list ()
  #loop over the files
  for (i in 1:length(files.v)) {
    #read the file in (we must know input directory)
    text.v <- scan(paste(input.dir, files.v[i], sep = "/"), what = "character", sep = "n")
    #convert to a single string  
    paste(text.v, collapse = " ")
    #lowercase and split on non-word characters
    text.lower.v <- tolower(text.v)
    text.words.v <- strsplit(text.lower.v, "\\W")
    text.words.v <- unlist(text.words.v)
    #remove the blanks
    text.words.v <- text.words.v[which(text.words.v !="")]
    #use the index id from the files.v vector as the "name" in the list
    text.word.vector.l[[files.v[i]]] <- text.words.v
    
  }
  return(text.word.vector.l)
}

#function to process relative frequency table of sWords; takes uploaded xml file as argument (called "doc.object)
#use xmlTreeParse to generate "doc.object"
getSwordTableList <- function(doc.object) {
  swords <-getNodeSet(doc.object, "//sWord",)
  sword.content <- paste(sapply(swords, xmlValue), sep="", collapse=NULL)
  sword.content.lower <- tolower(sword.content)
  book.freqs.t <-table(sword.content.lower)
  book.freqs.rel.t <- 100*(book.freqs.t/sum(book.freqs.t))
  return(book.freqs.rel.t)
}


#function to make n-grams of sword elements ; takes uploaded xml file as argument (called "doc.object)
#use xmlTreeParse to generate "doc.object"
getSwordNgramTableList <- function(doc.object) {
  swords <-getNodeSet(doc.object, "//sWord", )
  sword.content <- paste(sapply(swords, xmlValue), collapse = NULL)
  sword.ngrams <- make.ngrams(sword.content, ngram.size=1)
  sword.ngrams <-tolower(sword.ngrams)
  book.freqs.t <-table(sword.ngrams)
  book.freqs.rel.t <- 100*(book.freqs.t/sum(book.freqs.t))
  
  return(book.freqs.rel.t)
}



# function to make list of relative frequency tables of chunks of ngrams:
getSwordNgramSegmentTableList <- function(doc.object, chunk.size=10) {
  swords <-getNodeSet(doc.object, "//sword", )
  sword.content <- paste(sapply(swords, xmlValue), collapse=NULL)
  sword.ngrams <- make.ngrams(sword.content, ngram.size=3)
  sword.content.lower <- tolower(sword.ngrams)
  
  #the following lines split sword.content.lower in equalsized chunks accounting for remainders
  max.length <- length(sword.content.lower)/chunk.size
  x <- seq_along(sword.content.lower)
  chunks.l <- split(sword.content.lower, ceiling(x/max.length))
  
  #convert the list object chunks.l into table objects
  freq.chunks.l <- lapply(chunks.l, table)
  
  #convert the result from raw frequencies to relative fequencies
  rel.freq.chunk.l <- lapply(freq.chunks.l, prop.table)
  
  #return the result
  return(rel.freq.chunk.l)
}





#function to process relative frequency table of <word> elements, not <sword> elements; takes uploaded xml file as argument (called "doc.object)
#use xmlTreeParse to generate "doc.object"
getRelationTableList <- function(doc.object) {
  words <-getNodeSet(doc.object, "//word", )
  word.content <- paste(sapply(words, xmlValue), sep="", collapse = NULL)
  word.content.lower <- tolower(word.content)
  book.freqs.t <-table(word.content.lower)
  book.freqs.rel.t <- 100*(book.freqs.t/sum(book.freqs.t))
  return(book.freqs.rel.t)
}


# function to make list of relative frequency tables of chunks:
getSwordSegmentTableList <- function(doc.object, chunk.size=10) {
  swords <-getNodeSet(doc.object, "//sword", )
  sword.content <- paste(sapply(swords, xmlValue), collapse=NULL)
  sword.content.lower <- tolower(sword.content)
  
  #the following lines split sword.content.lower in equalsized chunks accounting for remainders
  max.length <- length(sword.content.lower)/chunk.size
  x <- seq_along(sword.content.lower)
  chunks.l <- split(sword.content.lower, ceiling(x/max.length))
  
  #convert the list object chunks.l into table objects
  freq.chunks.l <- lapply(chunks.l, table)
  
  #convert the result from raw frequencies to relative fequencies
  rel.freq.chunk.l <- lapply(freq.chunks.l, prop.table)
  
  #return the result
  return(rel.freq.chunk.l)
}


#this function is applied to a list of lists of tables to convert to matrix
my.apply <- function(x){
  my.list <-mapply(data.frame, ID=seq_along(x),
                   x, SIMPLIFY=FALSE,
                   MoreArgs=list(stringsAsFactors=FALSE))
  my.df <- do.call(rbind, my.list)
  return(my.df)
}


# function to make list of relative frequency tables of chunks of ngrams:
getSwordChunkMaster <- function(doc.object, chunk.size=250) {
  swords <-getNodeSet(doc.object, "//sWord", )
  sword.content <- paste(sapply(swords, xmlValue), collapse=NULL)
 
  
  sword.content.lower <- tolower(sword.content)
  
  #the following lines split sword.content.lower in equalsized chunks accounting for remainders
  # max.length <- length(sword.content.lower)/chunk.size
  divisor <- length(sword.content.lower)/chunk.size
  max.length <- length(sword.content.lower)/divisor
  x <- seq_along(sword.content.lower)
  chunks.l <- split(sword.content.lower, ceiling(x/max.length))
  
  #convert the list object chunks.l into table objects
  freq.chunks.l <- lapply(chunks.l, table)
  
  #convert the result from raw frequencies to relative fequencies
  rel.freq.chunk.l <- lapply(freq.chunks.l, prop.table)
  
  #return the result
  return(rel.freq.chunk.l)
}


# function to make list of relative frequency tables of chunks of ngrams:
getWordChunkMaster <- function(doc.object, chunk.size=250) {
  swords <-getNodeSet(doc.object, "//word", )
  sword.content <- paste(sapply(swords, xmlValue), collapse=NULL)
  
  
  sword.content.lower <- tolower(sword.content)
  
  #the following lines split sword.content.lower in equalsized chunks accounting for remainders
  # max.length <- length(sword.content.lower)/chunk.size
  divisor <- length(sword.content.lower)/chunk.size
  max.length <- length(sword.content.lower)/divisor
  x <- seq_along(sword.content.lower)
  chunks.l <- split(sword.content.lower, ceiling(x/max.length))
  
  #convert the list object chunks.l into table objects
  freq.chunks.l <- lapply(chunks.l, table)
  
  #convert the result from raw frequencies to relative fequencies
  rel.freq.chunk.l <- lapply(freq.chunks.l, prop.table)
  
  #return the result
  return(rel.freq.chunk.l)
}


# function to make list of relative frequency tables of chunks:
getSwordChunksFromTxt <- function(doc.object, chunk.size=5) {
  
  
  
  #the following lines split sword.content.lower in equalsized chunks accounting for remainders
  max.length <- length(doc.object)/chunk.size
  x <- seq_along(doc.object)
  chunks.l <- split(doc.object, ceiling(x/max.length))
  
  #convert the list object chunks.l into table objects
  freq.chunks.l <- lapply(chunks.l, table)
  
  #convert the result from raw frequencies to relative fequencies
  rel.freq.chunk.l <- lapply(freq.chunks.l, prop.table)
  
  #return the result
  return(rel.freq.chunk.l)
}




#function to make word chunks based on size of chunk in words
getSizedChunksFromTxt <- function(doc.object, chunk.size=2500) {
  
  #script to convert chunk.size to number of chunks as imput to function
  #and trim doc.object to eliminate remainders
  chunk.number <- length(doc.object)/chunk.size
  remainder.size <- length(doc.object)%%chunk.size
  rounded.chunk.number <-floor(chunk.number)
  
  #this code truncates doc.object by length of remainder.size
  # trimmed.doc.object <- doc.object[1:(length(doc.object)-remainder.size)]
  
  #alternately, we might remove a random selection of sWords = remainder.size
  random.sWords <- sample(length(doc.object), remainder.size)
  random.doc.object <- doc.object[-random.sWords]
  
  
  
  #the following lines split input object into equalsized chunks accounting for remainders
  max.length <- length(random.doc.object)/rounded.chunk.number
  x <- seq_along(random.doc.object)
  chunks.l <- split(random.doc.object, ceiling(x/max.length))
  
  #convert the list object chunks.l into table objects
  freq.chunks.l <- lapply(chunks.l, table)
  
  #convert the result from raw frequencies to relative fequencies
  rel.freq.chunk.l <- lapply(freq.chunks.l, prop.table)
  
  #return the result
  return(rel.freq.chunk.l)
}




