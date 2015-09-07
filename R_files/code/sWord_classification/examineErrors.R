
# a script to help examine the pattern of errors in the naive Bayes classifications

load(file="Rresults/Naive_Bayes_predictions/chunkSize2000/c100_variables/relationTests/test4_August28/correctAnswers.R")

load(file="Rresults/Naive_Bayes_predictions/chunkSize2000/c100_variables/relationTests/test4_August28/errorMatrix.R")

load(file="Rresults/Naive_Bayes_predictions/chunkSize2000/c100_variables/relationTests/test4_August28/list_of_classifiers.R")

load(file="Rresults/Naive_Bayes_predictions/chunkSize2000/c100_variables/relationTests/test4_August28/predictionList.R")

load(file="Rresults/Naive_Bayes_predictions/chunkSize2000/c100_variables/relationTests/test4_August28/rawPredictions.R")


err.matr.l[[1]]
sW.classifier.l[[1]][2]
sWord_predictions.l[[1]]
sWord_predictions_raw.l[[1]]
testing.classes.l[[1]]



author.v <- c("Aeschylus", "Athenaeus", "Diodorus", "Hdt", "Hesiod", "Iliad", "Lysias", "Odyssey", "Plutarch", "Polybius", "Sophocles", "Thucydides")

author.m <- matrix(author.v, nrow=2800, ncol=12, byrow=TRUE)
View(author.m)

require(gdata)








write.csv(examineErrors.m, file="Rresults/Naive_Bayes_predictions/chunkSize2000/c100_variables/relationTests/test4_August28/errorExamination.csv")



