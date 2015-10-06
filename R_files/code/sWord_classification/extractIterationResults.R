list1 <- load(file="Rresults/iteration_list_sept13.R")
list2 <- load(file="Rresults/iteration_list2_sept13.R")
summary(list1)
list1
total.errors.l[[2]]
total.errors2.l
total.errors2.l[[1]]
length(total.errors2.l[[1]])
sum(total.errors2.l[[1]])/2400
unlist(total.errors2.l[[1]])
lapply(total.errors2.l, sum)
unlist(lapply(total.errors2.l, sum))
unlist(lapply(total.errors2.l, sum))/2800
1-(unlist(lapply(total.errors2.l, sum))/2400)

x <- seq(2, 500, 2)
iteration.m <- matrix (x, nrow=250, ncol=1)
iteration.m <- (cbind(iteration.m, lapply(total.errors.l, sum)))
iteration.m <- (cbind(iteration.m, unlist(lapply(total.errors.l, sum))/2400 ))
iteration.m <- (cbind(iteration.m, 1-(unlist(lapply(total.errors.l, sum))/2400) ))




View(iteration.m)
plot(iteration.m[,1], iteration.m[,4])
write.csv(iteration.m, file="Rresults/svmRel_pos_iterationTest_Oct5.csv")
