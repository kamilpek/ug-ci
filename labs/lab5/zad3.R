#Lab5/Zad3
#set.seed(1234)
iris.numeric <- data.matrix(iris[,-5])
colnames(iris.numeric) <- NULL
iris.log <- log(iris.numeric)
iris.preproc <- scale(iris.log)
iris.pca <- prcomp(iris.preproc)
iris.pca.data <- predict(iris.pca)[,1:2]
#
k <- 3
max_x <- max(iris.pca.data[,1])
min_x <- min(iris.pca.data[,1])
max_y <- max(iris.pca.data[,2])
min_y <- min(iris.pca.data[,2])
ran_1_x <- sample(min_x:max_x)[sample(1:6)[1]]
ran_1_y <- sample(min_y:max_y)[sample(1:6)[1]]
ran_2_x <- sample(min_x:max_x)[sample(1:6)[1]]
ran_2_y <- sample(min_y:max_y)[sample(1:6)[1]]
rans <- matrix(c(ran_1_x, ran_1_y, ran_2_x, ran_2_y),nrow=2,ncol=2)
#
plot(iris.pca.data)
points(rans, pch=4, cex=2, col=2)
