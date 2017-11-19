#Lab4/Zad2
library(deducorrect)
# Dane
dirty.iris <- read.csv("dirty_iris.csv")
R <- correctionRules("edit.txt")
# Korekcja
correct.iris <- correctWithRules(R, dirty.iris)
correct.iris$corrected
