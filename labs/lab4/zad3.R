#Lab4/Zad3
library(VIM)
library(deducorrect)
# Dane
dirty.iris <- read.csv("dirty_iris.csv")
# Wypełnianie luk
R <- correctionRules("edit.txt")
correct.iris <- correctWithRules(R, dirty.iris)
clean.iris.mean <- correct.iris$corrected
clean.iris.mean$Sepal.Length[is.na(clean.iris.mean$Sepal.Length)] <- mean(clean.iris.mean$Sepal.Length, na.rm = TRUE)
clean.iris.mean$Sepal.Width[is.na(clean.iris.mean$Sepal.Width)] <- mean(clean.iris.mean$Sepal.Width, na.rm = TRUE)
clean.iris.mean$Petal.Length[is.na(clean.iris.mean$Petal.Length)] <- mean(clean.iris.mean$Petal.Length, na.rm = TRUE)
clean.iris.mean$Petal.Width[is.na(clean.iris.mean$Petal.Width)] <- mean(clean.iris.mean$Petal.Width, na.rm = TRUE)
# Wypełnianie luk - kNN
n <- nrow(clean.iris.mean)
for (i in 1:ncol(clean.iris.mean)) {
  clean.iris.mean[sample(1:n, replace = TRUE), i] <- NA
}
clean.iris.knn <- kNN(clean.iris.mean)
