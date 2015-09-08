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


xx[2:26, 1]
zscore.m <- cbind (xx[, 1], (xx[,1] - mean(xx[,1]))/ sd(xx[,1]))
i <- 3
for (i in i : 774) {
  zscore.m <- cbind (zscore.m, xx[, i], (xx[,i] - mean(xx[,i]))/ sd(xx[,i]))
  
}


write.csv(zscore.m, file="Rresults/zScoreLabels.csv")
write.csv(final.m, file="Rresults/relPosFreqsWithZscores.csv.csv")

zscore.m <- matrix(rep("Z-score", 774), nrow=1, ncol=774)
feature.m <- xx[1,2:775]




dim(feature.m)
dim(zscore.m)
dim(labels2)
length(labels2)/2


labels2 <- matrix(labels1, nrow=1, ncol=1548)

a <-  unlist(labels2)
a[1548:1560]

labels3 <- a[1:1547]
labels3[1546:1547]

final.m <-rbind(labels3, yy)

View(final.m)
View(labels2)
View(labels1)
View(zscore.m)
View(yy)
View(feature.m)
View(header.v)
colnames(xx[,1])
View(xx)
rm (zscore.m)
mean(xx[2:26,1])
mean(xx[,1])
