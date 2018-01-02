# forecast
# biblioteki
library(forecast)
library(tseries)
library(lubridate)
# dane
download.file("https://stooq.com/q/d/l/?s=^dji&i=d", 
              file.path('data', 'DJI.csv'), quiet = FALSE, mode = "w", cacheOK = TRUE)
dji.prices <- read.csv(file.path('data', 'DJI.csv'), stringsAsFactors = FALSE)
dji.prices <- transform(dji.prices, Date = ymd(Date))
dji <- with(dji.prices, rev(Close))
dates <- with(dji.prices, rev(Date))
dji.msts <- msts(rev(dji), seasonal.periods=c(7,365.25), start=2010, end=2018)
# arima
dji.arima.data <- data.frame(closing = dji.msts, lclosing = log(dji.msts))
dji.arima.stl <- stl(dji.arima.data$closing, s.window = "periodic")
dji.arima.f <- forecast(dji.arima.stl, method="arima", h=365, level=95)
# nnetar
dji.nnet.fit <- nnetar(dji.msts, p = 9, P=, size = 3, repeats = 10, lambda = 0)
dji.nnet.f <- forecast(dji.nnet.fit, 365)
# wyniki
print(sprintf("Forecast for day next to: %s", as.character(tail(dji.prices$Date, n=1))))
print(sprintf("Arima: %s", as.character(dji.arima.f$mean[1])))
print(sprintf("Neural Network: %s", as.character(dji.nnet.f$mean[1])))
#

