View(xx)
sd(xx[,2])
sd[,1]
xx[,1]
colnames(xx)
rownames(xx)
xx <- read.csv(file="Rresults/relPos774.csv", header=TRUE, row.names=1, stringsAsFactors=FALSE )
(xx[2:26,1] - mean(xx[2:26,1]))/ sd(xx[2:26,1])
zscore.m <-cbind (zscore.m, xx[,2], (xx[,2] - mean(xx[,2]))/ sd(xx[,2]))


xx[2:26, 1]
zscore.m <- cbind (xx[, 1], (xx[,1] - mean(xx[,1]))/ sd(xx[,1]))
i <- 3
for (i in i : 774) {
  zscore.m <- cbind (zscore.m, xx[, i], (xx[,i] - mean(xx[,i]))/ sd(xx[,i]))
  
}


write.csv(zscore.m, file="Rresults/zScoreRelPos744.csv")

View(zscore.m)
colnames(xx[,1])
View(xx)
rm (zscore.m)
mean(xx[2:26,1])
mean(xx[,1])
