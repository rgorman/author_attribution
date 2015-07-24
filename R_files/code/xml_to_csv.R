# a script to extract elements from xml files and write the resulting tabulated relative frequency data to
# csv files

library(XML)
source("code/corpusFunctions.R")

#set input directory for desired files
input.dir <- "../sWord_output/sWord_relation_files"
files.v <- dir(path=input.dir, pattern=".*xml")


#create vector of names for later use
names_for_files.v <- gsub (".xml", "", files.v)
names_for_output.v <- gsub (".xml", ".csv", files.v)

#select output directory
output_dir.v <- "sWord_output/rel_csv/"




#loop to process files
for (i in 1:length(files.v)) {
  #read xml file into doc.object
  doc.object <- xmlTreeParse(file.path(input.dir, files.v[i]), useInternalNodes=TRUE)
  
  # create R object of the target nodes in xml file
  # be sure to select the kind of node you want here!
  swords <-getNodeSet(doc.object, "//sWord", )
  
  # create character vector of all values of target xml nodes
  sword.content <- paste(sapply(swords, xmlValue), collapes = " ")
  
  # change contents of character vector to lower case characters
  sword.content.lower <- tolower(sword.content)
  
  # make relative frequency table of count of like elements in character vector
  book.freqs.t <-table(sword.content.lower)
  
  # change frequency table to relative frequency giving each feature as % of total
  book.freqs.rel.t <- 100*(book.freqs.t/sum(book.freqs.t))
  
  # transpose relative frequency table so that rows are observations and columns are features.
  # R prefers this configuration.
  csv_ready.t <-t(book.freqs.rel.t)
  
  # Add file name as row name for relative frequency table
  row.names(csv_ready.t) <-  names_for_files.v[i]
  
  # create correct path and file name for output
  output_path <- paste(output_dir.v, names_for_output.v[i], sep="", collapse="NULL")
  
  #write relative frequency table to disk as csv file
  write.csv(csv_ready.t, file=output_path)
  
  
}


# a short test
i <- 1
doc.object <- xmlTreeParse(file.path(input.dir, files.v[i]), useInternalNodes=TRUE)
swords <-getNodeSet(doc.object, "//sWord", )
sword.content <- paste(sapply(swords, xmlValue), collapes = " ")
sword.content.lower <- tolower(sword.content)

book.freqs.t <-table(sword.content.lower)
book.freqs.rel.t <- 100*(book.freqs.t/sum(book.freqs.t))
csv_ready.t <-t(book.freqs.rel.t)
row.names(csv_ready.t) <-  names_for_files.v[i]
output_path <- paste(output_dir.v, names_for_output.v[i], sep="", collapse="NULL")
write.csv(csv_ready.t, file=output_path)
