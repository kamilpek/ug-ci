# Analiza Głównych Składowych
#
library('lubridate')
library('reshape')
library('ggplot2')
#
dji.prices <- read.csv(file.path('data', 'DJI.csv'), stringsAsFactors = FALSE)
#
dji.prices <- transform(dji.prices, Date = ymd(Date))
dji.prices <- subset(dji.prices, Date > ymd('2001-12-31'))
dji.prices <- subset(dji.prices, Date != ymd('2002-02-01'))
dji <- with(dji.prices, rev(Close))
dates <- with(dji.prices, rev(Date))
#
comparison <- data.frame(Date = dates, MarketIndex = market.index, DJI = dji)
comparison <- transform(comparison, MarketIndex = -1 * MarketIndex)
dji.plot <- ggplot(comparison, aes(x = MarketIndex, y = DJI)) + geom_point() + geom_smooth(method = 'lm', se = FALSE)
print(dji.plot)
#
alt.comparison <- melt(comparison, id.vars = 'Date')
names(alt.comparison) <- c('Date', 'Index', 'Price')
#
comparison <- transform(comparison, MarketIndex = scale(MarketIndex))
comparison <- transform(comparison, DJI = scale(DJI))
alt.comparison <- melt(comparison, id.vars = 'Date')
names(alt.comparison) <- c('Date', 'Index', 'Price')
#
p <- ggplot(alt.comparison, aes(x = Date, y = Price, group = Index, color = Index)) + geom_point() + geom_line()
print(p)
#