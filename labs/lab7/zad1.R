#Lab7/Zad1
library(arules)
#
shop.data <- matrix(c(1,1,0,0,0,
                      0,1,1,0,0,
                      1,1,1,0,0,
                      0,0,0,1,1,
                      0,1,0,1,0,
                      0,1,0,1,1,
                      1,1,0,1,1,
                      0,1,0,1,1,
                      1,1,1,1,0,
                      1,1,0,1,1),
                    nrow=10, ncol=5, byrow=TRUE)
colnames(shop.data) <- c("masło", "chleb", "ser", "piwo", "czipsy")
#
