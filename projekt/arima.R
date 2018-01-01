# arima monthly
#
library(forecast)
library(tseries)
#
dji.prices <- read.csv(file.path('data', 'DJI.csv'), stringsAsFactors = FALSE)
#
dji.ts <- ts(rev(dji.prices[,5]), start=c(2001,1), end=(c(2020,1)), freq=12)
dji.data <- data.frame(closing = dji.ts, lclosing = log(dji.ts))
dji.stl <- stl(dji.data$closing, s.window = "periodic")
dji.f <- forecast(dji.stl, method="arima", h=24, level=95)
plot(dji.f, ylab="stock price", xlab="year", sub="forecast from 01.2018 to 01.2020")
#
