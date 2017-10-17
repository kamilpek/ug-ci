#Lab1/ZadDom2
library(genalg)
library(ggplot2)

phi1 <- matrix(c(-1,2,4,-2,3,4,1,-3,4,1,-2,-4,2,-4,-4,-1,3,-4,1,2,3), ncol=3)
phi2 <- as.matrix(read.csv("dubois20.cnf.txt", header=FALSE, skip=13, sep="", colClasses=c(NA,NA,NA,"NULL")))
phi3 <- as.matrix(read.csv("aim-50-1_6-yes1-4.cnf.txt", header=FALSE, skip=13, sep="", colClasses=c(NA,NA,NA,"NULL")))
fitnessFunc <- function(substitution) {
  phi = phi2
  counter = 0
  result = FALSE
  max = max(as.numeric(unlist(phi)))
  for(i in 1:nrow(phi)){
    row <- phi[i,]
    row_1 <- abs(row[1])%%3
    if(row_1 == 0){ row_1 = 3}
    row_2 <- abs(row[2])%%3
    if(row_2 == 0){ row_2 = 3}
    row_3 <- abs(row[3])%%3
    if(row_3 == 0){ row_3 = 3}
    x1 = substitution[row_1]
    if(row[1] < 0){ x1 = !x1 }
    x2 = substitution[row_2]
    if(row[2] < 0){ x2 = !x2 }
    x3 = substitution[row_3]
    if(row[3] < 0){ x3 = !x3 }
    result = x1 | x2 | x3
    if(!is.na(result)){ if(result){ counter = counter + 1 } }
  }
  return(-counter)
}

GAmodel <- rbga.bin(size = 7, popSize = 200, iters = 200,
                    mutationChance = 0.01, elitism = T, evalFunc = fitnessFunc)
summary(GAmodel, echo=TRUE)

plot(GAmodel)
