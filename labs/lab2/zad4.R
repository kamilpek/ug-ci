#Lab2/Zad4
library(ggvis)
#
iris.numeric <- data.matrix(iris[,-5])
colnames(iris.numeric) <- NULL
iris.log <- log(iris.numeric)
iris.preproc <- scale(iris.log)
#
iris.pca <- prcomp(iris.preproc)
iris.pca.data <- predict(iris.pca)
iris.pca.data <- iris.pca.data[,-3]
#
Species <- data.matrix(iris[,5])
#
iris %>% ggvis(~Sepal.Length, ~Sepal.Width, fill = ~Species) %>% layer_points()
