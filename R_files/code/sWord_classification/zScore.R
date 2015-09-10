require(gdata)

View(xx)
sd(xx[,2])
sd[,1]
xx[,1]
colnames(xx)
rownames(xx)
xx <- read.csv(file="Rresults/relPos774.csv", header=FALSE,  stringsAsFactors=FALSE )
yy <- read.csv(file="Rresults/zScoreRelPos744.csv", header=TRUE, row.names=1, stringsAsFactors=FALSE )
labels1 <- read.csv(file="Rresults/zScoreLabelsWithsWords.csv", header=FALSE, stringsAsFactors=FALSE)

(xx[2:26,1] - mean(xx[2:26,1]))/ sd(xx[2:26,1])
zscore.m <-cbind (zscore.m, xx[,2], (xx[,2] - mean(xx[,2]))/ sd(xx[,2]))
zscore.m <- xxx

col.scores <- 

xx[2:26, 1]
zscore.m <- cbind (xx[, 1], (xx[,1] - mean(xx[,1]))/ sd(xx[,1]))
i <- 2
for (i in i : 544) {
  zscore.m <- cbind (zscore.m, sorted.m[, i], (sorted.m[,i] - mean(sorted.m[,i]))/ sd(sorted.m[,i]))
  
}


write.csv(labels2, file="Rresults/zScoreLabels544.csv")
write.csv(zscore.m, file="Rresults/relPosFreqsWithZscores544.csv")

labels.m <- matrix(rep("Z-score", 544), nrow=1, ncol=544)
feature.m <- matrix(colnames(sorted.m), nrow=1, ncol=544)
combined.m <- rbind(feature.m, labels.m)


View(combined.m)

dim(feature.m)
dim(zscore.m)
dim(labels2)
length(labels2)/2


labels2 <- matrix(combined.m, nrow=1, ncol=1088)

a <-  unlist(labels2)
a[1548:1560]

labels3 <- a[1:1547]
labels3[1546:1547]

final.m <-rbind(labels3, yy)

View(final.m)
View(labels2)
View(labels.m)
View(zscore.m)
View(yy)
View(feature.m)
View(header.v)
colnames(xx[,1])
View(xx)
rm (zscore.m)
mean(xx[2:26,1])
mean(xx[,1])
