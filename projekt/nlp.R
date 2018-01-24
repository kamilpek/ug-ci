# nlp
# biblioteki
suppressMessages(library(rvest))
suppressMessages(library(dplyr))
suppressMessages(library(stringr))
suppressMessages(library(tm))
suppressMessages(library(SentimentAnalysis))
# marketwatch - https://www.marketwatch.com/investing/index/djia/news
mwatch.html <- read_html("https://www.marketwatch.com/investing/index/djia/news")
mwatch.heads <- html_nodes(html_nodes(mwatch.html, "div.headlinewrapper")[1], "a")
mwatch.links <- bind_rows(lapply(xml_attrs(mwatch.heads), function(x) data.frame(as.list(x), stringsAsFactors=FALSE)))
mwatch.articles <- list()
for(i in 1:length(mwatch.links[,1])){
  #print(paste("https://www.marketwatch.com", mwatch.links[i,], sep=""))
  mwatch.news <- read_html(paste("https://www.marketwatch.com", mwatch.links[i,], sep=""))
  mwatch.article <- html_nodes(html_nodes(mwatch.news, "article"), "div#article-body")
  mwatch.article <- gsub("\n", "", gsub("\r", "", html_text(mwatch.article)))
  mwatch.article <- gsub("\\s+", " ", str_trim(mwatch.article))
  mwatch.articles <- c(mwatch.articles, mwatch.article)
}
mwatch.corpus <- VCorpus(VectorSource(mwatch.articles))
mwatch.sent <- analyzeSentiment(mwatch.corpus)
# cnbc - https://www.cnbc.com/quotes/?symbol=.DJI
cnbc.html <- read_html("https://www.cnbc.com/quotes/?symbol=.DJI")
cnbc.heads <- html_nodes(cnbc.html, "div.quote-left-main div.bucket div.assets div.assets a")[2:6]
cnbc.links <- bind_rows(lapply(xml_attrs(cnbc.heads), function(x) data.frame(as.list(x), stringsAsFactors=FALSE)))
cnbc.abstracts <- list()
for(i in 1:length(cnbc.links[,1])){
  cnbc.news <- read_html(cnbc.links[i,])
  cnbc.abstracts <- c(cnbc.abstracts, html_text(html_nodes(cnbc.news, "div.story-top div#article_deck li")))
}
cnbc.corpus <- VCorpus(VectorSource(cnbc.abstracts))
cnbc.sent <- analyzeSentiment(cnbc.corpus)
# results
if((mean(mwatch.sent$PositivityGI) > mean(mwatch.sent$NegativityGI)) &&
   (mean(cnbc.sent$PositivityGI) > mean(cnbc.sent$NegativityGI)) ){
  result <- "positive"
} else {
  result <- "negative"
}
print(result, quote="FALSE")
#
