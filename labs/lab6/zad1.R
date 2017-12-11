#Lab6/Zad1
require(neuralnet)
#
siatk.dane <- matrix(c(23, 75, 176, 1,
                  25, 67, 180, 1,
                  28, 120, 175, 0,
                  22, 65, 165, 1,
                  46, 70, 187, 1,
                  50, 68, 180, 0,
                  48, 97, 178, 0), 
                nrow=7, ncol=4, byrow = TRUE)
colnames(siatk.dane) <- c("wiek", "waga", "wzrost", "gra")
#
siatk.nn <- neuralnet(gra ~ wiek + waga + wzrost, siatk.dane, hidden=2)
siatk.predict <- compute(siatk.nn, siatk.dane[,1:3])$net.result
#