library(XML)
library(stylo)
source("code/corpusFunctions.R")
input.dir <- "data/preprocessForStylo"
files.v <- dir(path=input.dir, pattern=".*xml")

#loop to preprocess sWord files for input to Stylo

for (i in 1:length(files.v)) {
 
  #read xml files into doc.object
  doc.object <- xmlTreeParse(file.path(input.dir, files.v[i]), useInternalNodes=TRUE)
  
  # extract swords from doc.object
  swords <-getNodeSet(doc.object, "//sword", )
  
  # extract content of <sword> elements and paste into object
  sword.content <- paste(sapply(swords, xmlValue), Collapse = NULL)
  
  # convert to lower case
  sword.content <- tolower(sword.content)
  
  #eliminate the star, underscore, and hash-tag symbols which bother stylo; replace with hyphon
  no.star <-gsub("*", "-", sword.content, fixed=TRUE)
  no.underscore <-gsub("_", "-", no.star, fixed=TRUE)
  root <- gsub("#", "-root", no.underscore, fixed=TRUE)
  no.digits <- gsub("exd[0-9]", "exd", root)
  exd.hyphen <- gsub("exd", "exd-", no.digits)
  final <- gsub("--", "-", exd.hyphen, fixed=TRUE)
  
  
  
  #create new file name for out put; new name is compatible with stylo
  file.name <- files.v[i]
  file.name <- gsub(".rel.xml", "", file.name, fixed=TRUE)
  file.name <- gsub(".", "_", file.name, fixed=TRUE)
  file.name <- paste(file.name, "txt", sep=".")
  
  
  # combine path and file name for writing to disk
  path <- c("data/postprocessForStylo")
  output.file <- paste(path, file.name, sep="/")
  
  #write to disk
  cat(final, file=output.file, sep=" ")
  
}


