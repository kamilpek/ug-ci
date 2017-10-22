#Lab2/Zad2
iris.numeric <- as.matrix(iris[,-5], col.names=F)
colnames(iris.numeric) <- NULL
iris.log <- log(iris.numeric)
iris.preproc <- scale(iris.log)
