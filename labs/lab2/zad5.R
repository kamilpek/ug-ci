#Lab2/Zad5
library(ggvis)
#
iris.numeric <- data.matrix(iris[,-5])
colnames(iris.numeric) <- NULL
iris.log <- log(iris.numeric)
iris.preproc <- scale(iris.log)
iris.pca <- prcomp(iris.preproc)
iris.pca.data <- predict(iris.pca)
iris.pca.data <- iris.pca.data[,-3]
#
Species <- data.matrix(iris[,5])
cols <- c('red', 'blue', 'green')
with(iris, plot(iris.pca.data, col=cols[Species], pch=as.numeric(Species)))
legend("topleft", c("setosa", "versicolor", "virginica"), fill=cols)
#
recognizeIris <- function(SeplLength,SepalWidth,PetalLength,PetalWidth) {
  SeplLength.log <- log(SeplLength)
  SepalWidth.log <- log(SepalWidth)
  PetalLength.log <- log(PetalLength)
  PetalWidth.log <- log(PetalWidth)
  
  SeplLength.mean = mean(log(iris[[1]]))
  SepalWidth.mean = mean(log(iris[[2]]))
  PetalLength.mean = mean(log(iris[[3]]))
  PetalWidth.mean = mean(log(iris[[4]]))
  
  SeplLength.sd = sd(log(iris[[1]]))
  SepalWidth.sd = sd(log(iris[[2]]))
  PetalLength.sd = sd(log(iris[[3]]))
  PetalWidth.sd = sd(log(iris[[4]]))
  
  SeplLength.param = (SeplLength.log-SeplLength.mean)/SeplLength.sd
  SepalWidth.param = (SepalWidth.log-SepalWidth.mean)/SepalWidth.sd
  PetalLength.param = (PetalLength.log-PetalLength.mean)/PetalLength.sd
  PetalWidth.param = (PetalWidth.log-PetalWidth.mean)/PetalWidth.sd
  
  wektor <- c(SeplLength.param, SepalWidth.param, PetalLength.param, PetalWidth.param)
  PC1 = iris.pca[2]$rotation[,1] %*% wektor
  PC2 = iris.pca[2]$rotation[,2] %*% wektor
  
  points(PC1, PC2)
}

recognizeIris(6.9, 3.2, 5.6, 2.2) # virinica
#recognizeIris(6.0, 2.6, 4.4, 1.6) # versicolor lub virinica
#recognizeIris(4.8, 3.6, 1.4, 0.2) # setosa