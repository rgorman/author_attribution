write.csv (short.parameters, file="Rresults/short_parameters2.csv")
write.csv (short.chunks, file="Rresults/short_chunks2.csv")

prob.m <- read.csv (file="Rresults/Naive_Bayes_predictions/chunkSize2000/chunk_parameters5.csv")
View(prob.m)
names(prob.m)
prob.m$Size
which(prob.m$Size < 1900)
length(which(prob.m$Size < 1900))
length(prob.m$Size)
262-20
short.chunks <- which(prob.m$Size < 1900)
short.parameters <- prob.m[-short.chunks,]
short.chunks
