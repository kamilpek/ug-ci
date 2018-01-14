# Lab8/Zad1
# biblioteki
library(tm)
library(ggplot2)
library(RColorBrewer)
library(wordcloud)
library(cluster)
library(fpc)
# dane
cname <- file.path("articles")   
docs <- VCorpus(DirSource(cname))
# preprocessing
docs <- tm_map(docs,removePunctuation)
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
#writeLines(as.character(docs[1]))
# dtm
dtm <- DocumentTermMatrix(docs)
freq <- colSums(as.matrix(dtm))   
ord <- order(freq)
m <- as.matrix(dtm)
write.csv(m, file="DocumentTermMatrix.csv")
dtms <- removeSparseTerms(dtm, 0.2)
freq <- sort(colSums(as.matrix(dtm)), decreasing=TRUE)
wf <- data.frame(word=names(freq), freq=freq) 
# wykresy
p <- ggplot(subset(wf, freq>14), aes(x = reorder(word, -freq), y = freq)) + 
  geom_bar(stat = "identity") + theme(axis.text.x=element_text(angle=45, hjust=1))
plot(p)
# korelacje
findAssocs(dtm, c("computer" , "life", "programming", "language"), corlimit=0.85)
# chmura słów
set.seed(142)   
wordcloud(names(freq), freq, min.freq=14, scale=c(5, .1), colors=brewer.pal(6, "Dark2"))
# klasteryzacja
dtmss <- removeSparseTerms(dtm, 0.15)
d <- dist(t(dtmss), method="euclidian")
fit <- hclust(d=d, method="complete")
plot(fit, hang=-1)
# klasteryzajca k średnich
d <- dist(t(dtmss), method="euclidian")   
kfit <- kmeans(d, 2)   
clusplot(as.matrix(d), kfit$cluster, color=T, shade=T, labels=2, lines=0)
#