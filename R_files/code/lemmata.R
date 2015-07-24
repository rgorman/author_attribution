library(XML)

#read the xml files into memory (make sure you have set the working directory!)
doc.athen.12 <- xmlTreeParse("data/lemmata/AthenLemmata.12.xml", useInternalNodes = TRUE)

doc.athen.13 <- xmlTreeParse("data/lemmata/AthenLemmata.13.xml", useInternalNodes = TRUE)


#get the individual <li> </li> nodes
athen.nodes.12.ns.l <- getNodeSet(doc.athen.12, "//li", )
athen.nodes.13.ns.l <- getNodeSet(doc.athen.13, "//li", )

#combine the two objects
athen.nodes.ns.l <- append(athen.nodes.12.ns.l, athen.nodes.13.ns.l)

#make container lists for output
lemmata.raw.l <- list()
lemmata.freq.l <- list()

#run loop to extract content of <li> </li> nodes
for (i in 1:length(athen.nodes.ns.l)) {
  lemmata.raw.l <- append (lemmata.raw.l, xmlValue(athen.nodes.ns.l[[i]]))
}
#look into the result
lemmata.raw.l[[5]]

