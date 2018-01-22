# Lab8/Zad2
# biblioteki
library(tm)
library(SnowballC)
library(lsa)
# dane
cname <- file.path("articles")   
docs <- VCorpus(DirSource(cname))
# preprocessing
docs <- tm_map(docs, removePunctuation)
for (j in seq(docs)) {
  docs[[j]] <- gsub("/", " ", docs[[j]])
  docs[[j]] <- gsub("@", " ", docs[[j]])
  docs[[j]] <- gsub("\\|", " ", docs[[j]])
  docs[[j]] <- gsub("\u2028", " ", docs[[j]])
  docs[[j]] <- gsub("\u0022", " ", docs[[j]])
}
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, tolower)   
docs <- tm_map(docs, PlainTextDocument)
docs <- tm_map(docs, stripWhitespace)
docs <- tm_map(docs, PlainTextDocument)
docs <- tm_map(docs, removeWords, c("the", "and", "that",
                                    "are", "for", "such", "from",
                                    "which", "this", "have", "other",
                                    "with", "may", "was", "can", "many",
                                    "not", "been", "its", "these", "use",
                                    "all", "each", "some", "also", "more",
                                    "has", "often", "their", "new", "they",
                                    "between", "one"))
# dtm
dtm <- TermDocumentMatrix(docs)
dtm.m <- as.matrix(dtm)
# podobieństwo
test <- dtm.m[,3]
res <- apply(dtm.m, c(2), FUN=cosine, y = test)
print(res)
#