library(XML)

doc.athen.12.all <- xmlTreeParse("data/sWords/jan2015/athen.12.all.xml", useInternalNodes = TRUE)
doc.athen.12.all

doc.athen.13.all <- xmlTreeParse("data/sWords/jan2015/athen.13.all.xml", useInternalNodes = TRUE)

athen.nodes.12.ns.l <- getNodeSet(doc.athen.12.all, "//sword", )
  
athen.nodes.12.ns.l[[1]]
athen.nodes.ns.l <-append(athen.nodes.12.ns.l, getNodeSet(doc.athen.13.all, "//sword", ) )

athen.nodes.ns.l[[19645]]

 xmlValue(athen.nodes.ns.l[[1]])

sword.raw.l <- list()
athen.sword.freq.l <- list()

for (i in 1:length(athen.nodes.ns.l)) {
  sword.raw.l <- append (sword.raw.l, xmlValue(athen.nodes.ns.l[[i]]))
}

sword.raw.l[[3]]
length(athen.nodes.ns.l)
sword.raw.l <- tolower(sword.raw.l)

#calculate the frequencies
athen.sword.freq.l <-table(sword.raw.l)
#arrange from most to least frequent
ordered.athen.sword.freq.t <- sort(athen.sword.freq.t, decreasing = TRUE)
ordered.athen.sword.freq.t[1:75]
length(athen.sword.freq.t)
#calculate the relative frequencies
ordered.athen.sword.rel.t <- 100*(ordered.athen.sword.freq.t/sum(ordered.athen.sword.freq.t))
#write to disk
write.table (athen.top.rel, "data/results/athen_rel_freq.txt", sep ="\t")

athen.sword.freq.l [[2]]
str(athen.sword.freq.l)
ordered.athen.sword.rel.t[1:75]
athen.top <- ordered.athen.sword.freq.t[1:1000]
athen.top.rel <- ordered.athen.sword.rel.t[1:1000]

length(athen.sword.freq.l[which(athen.sword.freq.l==1)])
?which
