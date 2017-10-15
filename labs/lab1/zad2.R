#Lab1/Zad2
#a
setwd("H:/Dokumenty/ci/lab1")
#b
osoby = read.csv("osoby.csv")
osoby
#c
osoby["imie"]
osoby$imie
#d
subset(osoby, grepl("k", osoby$plec))
#e
osoby_mean = mean(osoby$wiek)
#f
summary(osoby["wiek"])

