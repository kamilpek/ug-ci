#Lab2/Zad3
iris.pca <- prcomp(iris.preproc)
iris.pca.data <- predict(iris.pca)
iris.pca.data <- iris.pca.data[,-3]
iris.pca.data <- iris.pca.data[,-3]
