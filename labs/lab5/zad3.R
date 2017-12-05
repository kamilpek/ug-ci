#Lab5/Zad3
#set.seed(1234)
iris.numeric <- data.matrix(iris[,-5])
colnames(iris.numeric) <- NULL
iris.log <- log(iris.numeric)
iris.preproc <- scale(iris.log)
iris.pca <- prcomp(iris.preproc)
iris.pca.data <- predict(iris.pca)[,1:2]
#
mykmeans <- function(k, i, irises){
  random_points <-list()
  for(x in 1:k){
    ran_x <- irises[sample(nrow(irises), 1), 1]
    ran_y <- irises[sample(nrow(irises), 1), 2]
    random_points <- c(random_points, ran_x, ran_y)
  }
  centroids <- matrix(c(random_points), ncol=2)
  cluster <- c()
  for(j in 1:i){
    for(x in 1:nrow(irises)){
      neighbours <- c()  
      for(y in 1:k) neighbours[[y]] <- dist(rbind(irises[x,], centroids[y,]), method="euclidean")
      cluster[[x]] <- grep(min(neighbours), neighbours)
    }
    iris.clustering <- cbind(irises, cluster)
    iris.clustering <- split(data.frame(iris.clustering), iris.clustering[,3])
    centroids <- c()
    for(x in 1:k){
      centroid_x <- colMeans(as.data.frame(iris.clustering[x])[,1:2])[1]
      centroid_y <- colMeans(as.data.frame(iris.clustering[x])[,1:2])[2]
      centroids <- c(centroids, centroid_x, centroid_y)
    }
    centroids <- matrix(c(centroids), ncol=2)
  }
  plot(irises, col=cluster)
  points(centroids, pch=4, cex=2, col=2)
}
#
mykmeans(3, 100, iris.pca.data)
