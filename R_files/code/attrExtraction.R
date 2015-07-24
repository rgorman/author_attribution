

i <- 1
#read single xml file into R
doc.object <- xmlTreeParse("data/rawTrees/athen12.1-9.xml", useInternalNodes=TRUE)

# swords <-getNodeSet(doc.object, "//sword", )
# sword.content <- paste(sapply(swords, xmlValue), collapes = " ")
# sword.content.lower <- tolower(sword.content)
# book.freqs.t <-table(sword.content.lower)
# book.freqs.rel.t <- 100*(book.freqs.t/sum(book.freqs.t))

# make list object from all <word> nodes in doc.object
words.l <-getNodeSet(doc.object, "//word", )





#make character vector object of selected <word> attribute
word.content <-NULL
for (i in 1:length(words.v)) {
 add.word <- xmlGetAttr(words.v[[i]], "relation")
 word.content <- append(word.content, add.word)
 word.content <-tolower(word.content)
  
}



