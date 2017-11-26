#Lab2/Zad5/Wer2
iris.numeric <- data.matrix(iris[,-5])
colnames(iris.numeric) <- NULL
iris.pca <- prcomp(scale(log(iris.numeric)))
iris.pca.data <- predict(iris.pca)[,-3]
Species <- as.matrix(iris[,5])
cols <- c('red', 'blue', 'yellow4')
#
with(iris, plot(iris.pca.data, col=cols[Species], pch=as.numeric(Species)))
legend("bottomright", unique(Species), fill=cols)
#
recognizeIris <- function(SeplLength,SepalWidth,PetalLength,PetalWidth) {
  
  params = data.matrix(c(SeplLength, SepalWidth, PetalLength, PetalWidth))
  SeplLength.param = (log(SeplLength)-mean(log(iris[[1]])))/sd(log(iris[[1]]))
  SepalWidth.param = (log(SepalWidth)-mean(log(iris[[2]])))/sd(log(iris[[2]]))
  PetalLength.param = (log(PetalLength)-mean(log(iris[[3]])))/sd(log(iris[[3]]))
  PetalWidth.param = (log(PetalWidth)-mean(log(iris[[4]])))/sd(log(iris[[4]]))
  
  param <- c(SeplLength.param, SepalWidth.param, PetalLength.param, PetalWidth.param)
  PC1 = iris.pca[2]$rotation[,1] %*% param
  PC2 = iris.pca[2]$rotation[,2] %*% param
  
    points(PC1, PC2, pch = 21, col='black', bg='black')
}

recognizeIris(6.9, 3.2, 5.6, 2.2) # virginica
recognizeIris(6.0, 2.6, 4.4, 1.6) # versicolor lub virginica
recognizeIris(4.8, 3.6, 1.4, 0.2) # setosa