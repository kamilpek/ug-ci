#Lab4/Zad1
library(editrules)
# Dane
dirty.iris <- read.csv("dirty_iris.csv")
set.seed(1234)
# Filtrowanie
nrow(dirty.iris)
clean.iris <- subset(dirty.iris, is.finite(dirty.iris$Sepal.Length) & is.finite(dirty.iris$Sepal.Width) & 
                     is.finite(dirty.iris$Petal.Length) & is.finite(dirty.iris$Petal.Width))
# Reguły
E <- editset(expression(Sepal.Length <= 30,
                        Species %in% c("versicolor", "virginica", "setosa"),
                        Sepal.Length > 0, Sepal.Width > 0,
                        Petal.Length > 0, Petal.Width > 0,
                        Petal.Length >= (Petal.Width*2),
                        Sepal.Length > Petal.Length))
ve <- violatedEdits(E, dirty.iris)
summary(ve)
plot(ve)