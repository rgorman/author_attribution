library(XML)
doc <- xmlTreeParse("data/sWords/athen12_1-9_RelSWord.xml", useInternalNodes = TRUE)
doc

doc.nodes.ns.l <- getNodeSet(doc, "//SWordDocument", )  
doc.nodes.ns.l


sword.raws.l <- list()

sword.ns <- xmlElementsByTagName(doc.nodes.ns.l[[1]], "sword", recursive = TRUE)

sword.ns
doc.swords.v <-NULL
xmlValue(sword.ns[[5:6]])
length(sword.ns)

test <- append (xmlValue(sword.ns[[1]]), xmlValue(sword.ns[[2]]))
str (test)

test <- append(test, xmlValue(sword.ns[[3]]))
test
test <- NULL
test <- append(doc.swords.v, paste(xmlValue(sword.ns[[2]])), collapse = " "))

doc.sword.rel.freq.1 <- list()


#this one may have worked !!
for (i in 1:length(sword.ns)) {
  test <- append(test, xmlValue(sword.ns[[i]]))
  
}
2+2
doc.swords.v <-test

doc.swords.v <- tolower(doc.swords.v)
#calculate the frequencies
doc.sword.freq.t <- table(doc.swords.v)
doc.sword.freq.t[1:4]
str (doc.sword.freq.t)

mydata <- doc.sword.freq.t
write.table (mydata, "data/results/test1.txt", sep ="\t")
doc.sword.rel.freq.1 <- 100 *(doc.sword.freq.t/sum(doc.sword.freq.t))
?sort
2+2
?colnames
colnames(doc.sword.freq.t) <- c("sWords", "Frequencies")
sorted.t <- order(doc.sword.freq.t)
sorted.t[1:5]
sorted.t
sword.df <-  as.data.frame(doc.sword.freq.t)
str(sword.df)
sword.df[1:10,]
