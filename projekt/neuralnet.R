# neuralnet
#
library(forecast)
library(tseries)
library(lubridate)
#
dji.prices <- read.csv(file.path('data', 'DJI.csv'), stringsAsFactors = FALSE)
#
dji.prices <- transform(dji.prices, Date = ymd(Date))
dji <- with(dji.prices, rev(Close))
dates <- with(dji.prices, rev(Date))
#
dji.msts <- msts(rev(dji), seasonal.periods=c(7,365.25), start=2010, end=2018)
#
fit <- nnetar(dji.msts, p = 9, P=, size = 3, repeats = 10, lambda = 0)
dji.f <- forecast(fit, 365)
plot(dji.f, ylab="stock price", xlab="year", sub="forecast from 01.2018 to 01.2020")
#
