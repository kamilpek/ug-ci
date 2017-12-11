#Lab6/Zad3
require(neuralnet)
library(caret)
#
normalize <- function(x)
{
  num <- x - min(x)
  denom <- max(x) - min(x)
  return (num/denom)
}
maxidx <- function(arr) {
  return(which(arr == max(arr)))
}
# Dane
womens <- read.csv("diabetes.csv", header=TRUE, sep=",")
womens.norm <- as.data.frame(lapply(womens[1:8], normalize))
ind <- sample(2, nrow(womens), replace=TRUE, prob=c(0.67, 0.33))
womens.norm$positive <- c(womens$class == "tested_positive")
womens.norm$negative <- c(womens$class == "tested_negative")
womens.training <- womens[ind==1, 1:8]
womens.test <- womens[ind==2, 1:8]
womens.trainLabels <- womens[ind==1, 9]
womens.testLabels <- womens[ind==2, 9]
womens.norm.training <- womens.norm[ind==1, 1:10]
womens.norm.test <- womens.norm[ind==2, 1:10]
womens.trainLabels <- womens[ind==1, 9]
womens.testLabels <- womens[ind==2, 9]
# kNN
womens_pred1 <- knn(train = womens.training, test = womens.test, cl = womens.trainLabels, k=1)
womens_pred3 <- knn(train = womens.training, test = womens.test, cl = womens.trainLabels, k=3)
womens_pred5 <- knn(train = womens.training, test = womens.test, cl = womens.trainLabels, k=5)
womens_pred11 <- knn(train = womens.training, test = womens.test, cl = womens.trainLabels, k=11)
cm_knn1 <- confusionMatrix(womens_pred1, womens.testLabels)
cm_knn3 <- confusionMatrix(womens_pred3, womens.testLabels)
cm_knn5 <- confusionMatrix(womens_pred5, womens.testLabels)
cm_knn11 <- confusionMatrix(womens_pred11, womens.testLabels)
knn1_accuracy <- cm_knn1$overall['Accuracy']
knn3_accuracy <- cm_knn3$overall['Accuracy']
knn5_accuracy <- cm_knn5$overall['Accuracy']
knn11_accuracy <- cm_knn11$overall['Accuracy']
knn1_tp <- cm_knn1$table["tested_negative","tested_negative"]
knn3_tp <- cm_knn3$table["tested_negative","tested_negative"]
knn5_tp <- cm_knn5$table["tested_negative","tested_negative"]
knn11_tp <- cm_knn11$table["tested_negative","tested_negative"]
knn1_tn <- cm_knn1$table["tested_positive","tested_positive"]
knn3_tn <- cm_knn3$table["tested_positive","tested_positive"]
knn5_tn <- cm_knn5$table["tested_positive","tested_positive"]
knn11_tn <- cm_knn11$table["tested_positive","tested_positive"]
knn1_fn <- cm_knn1$table["tested_negative","tested_positive"]
knn3_fn <- cm_knn3$table["tested_negative","tested_positive"]
knn5_fn <- cm_knn5$table["tested_negative","tested_positive"]
knn11_fn <- cm_knn11$table["tested_negative","tested_positive"]
knn1_fp <- cm_knn1$table["tested_positive","tested_negative"]
knn3_fp <- cm_knn3$table["tested_positive","tested_negative"]
knn5_fp <- cm_knn5$table["tested_positive","tested_negative"]
knn11_fp <- cm_knn11$table["tested_positive","tested_negative"]
knn1_fpr <- knn1_fp/(knn1_fp+knn1_tn)
knn3_fpr <- knn3_fp/(knn3_fp+knn3_tn)
knn5_fpr <- knn5_fp/(knn5_fp+knn5_tn)
knn11_fpr <- knn11_fp/(knn11_fp+knn11_tn)
knn1_tpr <- knn1_tp/(knn1_tp+knn1_fn)
knn3_tpr <- knn3_tp/(knn3_tp+knn3_fn)
knn5_tpr <- knn5_tp/(knn5_tp+knn5_fn)
knn11_tpr <- knn11_tp/(knn11_tp+knn11_fn)
# NaiveBayes
nb <- naiveBayes(class ~ ., data=womens)
nb_pred <- predict(nb, womens[,-9])
cm_nb <- confusionMatrix(nb_pred, womens[,9])
nb_accuracy <- cm_nb$overall['Accuracy']
nb_tp <- cm_nb$table["tested_negative","tested_negative"]
nb_tn <- cm_nb$table["tested_positive","tested_positive"]
nb_fn <- cm_nb$table["tested_negative","tested_positive"]
nb_fp <- cm_nb$table["tested_positive","tested_negative"]
nb_fpr <- nb_fp/(nb_fp+nb_tn)
nb_tpr <- nb_tp/(nb_tp+nb_fn)
# Drzewa
womens_ctree <- ctree(class ~., data=womens)
ctree_pred <- predict(womens_ctree, womens[,-9])
cm_ctree <- confusionMatrix(ctree_pred, womens[,9])
ctree_accuracy <- cm_ctree$overall['Accuracy']
ct_tp <- cm_ctree$table["tested_negative","tested_negative"]
ct_tn <- cm_ctree$table["tested_positive","tested_positive"]
ct_fn <- cm_ctree$table["tested_negative","tested_positive"]
ct_fp <- cm_ctree$table["tested_positive","tested_negative"]
ct_fpr <- ct_fp/(ct_fp+ct_tn)
ct_tpr <- ct_tp/(ct_tp+ct_fn)
# Sieci Neuronowe 
womens.nn <- neuralnet(positive + negative ~ 
                         pregnant.times + glucose.concentr + blood.pressure + skin.thickness + 
                         insulin + mass.index + pedigree.func + age, data=womens.norm.training, hidden=3)
womens.predict <- compute(womens.nn, womens.norm.test[,1:8])$net.result
idx <- apply(womens.predict, c(1), maxidx)
womens.predict <- c('tested_positive', 'tested_negative')[idx]
womens.cm <- confusionMatrix(womens.predict, womens.testLabels)
nn_tp <- womens.cm$table["tested_negative","tested_negative"]
nn_tn <- womens.cm$table["tested_positive","tested_positive"]
nn_fn <- womens.cm$table["tested_negative","tested_positive"]
nn_fp <- womens.cm$table["tested_positive","tested_negative"]
nn_fpr <- nn_fp/(nn_fp+nn_tn)
nn_tpr <- nn_tp/(nn_tp+nn_fn)
nn_accuracy <- womens.cm$overall['Accuracy']
# Wykres słupkowy
classificators <- matrix(c(knn1_accuracy, knn3_accuracy, knn5_accuracy, knn11_accuracy, 
                           nb_accuracy, ctree_accuracy, nn_accuracy), ncol=7)
classificators.names <- matrix(c("1NN", "3NN", "5NN", "11NN", "NaiveBayes", "Trees", "NeuralNets"), ncol=7)
barplot(classificators, main="Skuteczność Klasyfikatorów", names.arg=classificators.names,
        ylab="Skuteczność [%]", xlab="Klasyfikatory")
# Wykres punktowy
# FPR = FP/N = FP/(FP+TN) = 1 - SPC
# TPR = TP/P = TP/(TP+FN)
colors <- c("blue", "coral", "aquamarine", "cornflowerblue", "darkgreen", "burlywood3", "firebrick3")
fpr <- c(knn1_fpr, knn3_fpr, knn5_fpr, knn11_fpr, nb_fpr, ct_fpr, nn_fpr)
tpr <- c(knn1_tpr, knn3_tpr, knn5_tpr, knn11_fpr, nb_tpr, ct_tpr, nn_tpr)
plot(fpr, tpr, col=colors, bg=colors, pch=21, xlab="False Positive Rate", ylab="True Positive Rate",
     main="False Positive and True Positive Ratings")
legend("bottomright", classificators.names, fill=colors)