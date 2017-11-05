#Lab3/Zad2
library(class)
library(gmodels)
#
iris <- iris
table(iris$Species)
round(prop.table(table(iris$Species)) * 100, digits = 1)
set.seed(1234)
ind <- sample(2, nrow(iris), replace=TRUE, prob=c(0.67, 0.33))
#
normalize <- function(x) {
  num <- x - min(x)
  denom <- max(x) - min(x)
  return (num/denom)
}
#
iris_norm <- as.data.frame(lapply(iris[1:4], normalize))
#summary(iris_norm)
#
iris.training <- iris[ind==1, 1:4]
iris.test <- iris[ind==2, 1:4]
#
iris.trainLabels <- iris[ind==1,5]
iris.testLabels <- iris[ind==2, 5]
#
iris_pred <- knn(train = iris.training, test = iris.test, cl = iris.trainLabels, k=3)
iris_pred
#
irisTestLabels <- data.frame(iris.testLabels)
merge <- data.frame(iris_pred, iris.testLabels)
names(merge) <- c("Predicted Species", "Observed Species")
merge
#
CrossTable(x = iris.testLabels, y = iris_pred, prop.chisq=FALSE)
