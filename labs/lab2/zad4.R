#Lab2/Zad4
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
cols <- c('red', 'blue', 'green')
with(iris, plot(iris.pca.data, col=cols[Species], pch=as.numeric(Species)))
legend("topleft", c("setosa", "versicolor", "virginica"), fill=cols)