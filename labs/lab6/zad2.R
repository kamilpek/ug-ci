#Lab6/Zad2
require(neuralnet)
library(caret)
#
normalize <- function(x) {
  num <- x - min(x)
  denom <- max(x) - min(x)
  return (num/denom)
}
split_species <- function(iris) {
  for(x in 1:nrow(iris)){
    if(iris[x,5] == "setosa") iris[x,6] = 1
    if(iris[x,5] == "versicolor") iris[x,7] = 1
    if(iris[x,5] == "virginica") iris[x,8] = 1
  }
  return (iris[,-5])
}
#
ind <- sample(2, nrow(iris), replace=TRUE, prob=c(0.67, 0.33))
iris.norm <- as.data.frame(lapply(iris[1:4], normalize))
iris.norm <- cbind(iris.norm, iris$Species)
species_names <- c("setosa", "versicolor", "virginica")
species <- matrix(0, nrow = 150, ncol = 3)
colnames(species) <- species_names
iris.norm <- cbind(iris.norm, species)
iris.norm <- split_species(iris.norm)
iris.training <- iris.norm[ind==1, 1:7]
iris.test <- iris.norm[ind==2, 1:7]
#
iris.nn <- neuralnet(setosa + versicolor + virginica ~ 
                       Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, 
                     data=iris.norm, hidden=4)
#plot(iris.nn, main="Iris Neural Network")
iris.predict <- compute(iris.nn, iris.test[1:4], rep=1)
iris.cm <- confusionMatrix(iris.predict, womens[,9])
