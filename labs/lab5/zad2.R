#Lab5/Zad2
require(graphics)
#
iris.numeric <- data.matrix(iris[,-5])
colnames(iris.numeric) <- NULL
iris.log <- log(iris.numeric)
iris.preproc <- scale(iris.log)
iris.pca <- prcomp(iris.preproc)
iris.pca.data <- predict(iris.pca)[,1:2]
#
iris.kmeans <- kmeans(iris.pca.data, 3)
plot(iris.pca.data, col = iris.kmeans$cluster)
points(iris.kmeans$centers, col = 1:3, pch = 4, cex = 3)
