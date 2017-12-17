#Lab7/Zad2
library(arules)
#
load("titanic.raw.rdata")
#
rules <- apriori(titanic.raw,
                 parameter = list(minlen=2, supp=0.005, conf=0.8),
                 appearance = list(rhs=c("Survived=No", "Survived=Yes"), default="lhs"),
                 control = list(verbose=F))
#
rules.sorted <- sort(rules, by="lift")
subset.matrix <- is.subset(rules.sorted, rules.sorted)
subset.matrix[lower.tri(subset.matrix, diag=FALSE)] <- NA
redundant <- colSums(subset.matrix, na.rm=FALSE) >= 1
rules.pruned <- rules.sorted[!redundant]
inspect(rules.pruned)
#