# forecast
#
library(ggplot2)
library(forecast)
library(tseries)
#
dji.prices <- read.csv(file.path('data', 'DJI.csv'), stringsAsFactors = FALSE)
#
dji.ts <- ts(rev(dji.prices[,5]), start=c(2000,1), freq=12)
dji.data <- data.frame(closing = dji.ts, lclosing = log(dji.ts))
#save(dji.data, file = "dji.data.RData")
#load("dji.data.RData")
#
count_ma = ts(na.omit(dji.data$closing), frequency=12)
dji.stl <- stl(dji.data$closing, s.window="periodic")
deseasonal_cnt <- seasadj(dji.stl)
count_d1 = diff(deseasonal_cnt, differences = 1)
fit <- auto.arima(deseasonal_cnt, seasonal=FALSE)
tsdisplay(residuals(fit), lag.max=45, main='(1,1,1) Model Residuals')
fit2 = arima(deseasonal_cnt, order=c(1,1,7))
tsdisplay(residuals(fit2), lag.max=15, main='Seasonal Model Residuals')
arima(x = deseasonal_cnt, order = c(1, 1, 7))
fcast <- forecast(fit2, h=30)
#plot(fcast)
hold <- window(ts(deseasonal_cnt), start=700)
fit_no_holdout = arima(ts(deseasonal_cnt[-c(700:725)]), order=c(1,1,7))
fcast_no_holdout <- forecast(fit_no_holdout,h=25)
plot(fcast_no_holdout, main=" ")
lines(ts(deseasonal_cnt))
fit_w_seasonality = auto.arima(deseasonal_cnt, seasonal=TRUE)
seas_fcast <- forecast(fit_w_seasonality, h=30)
plot(seas_fcast)
#
#dji.forecast <- forecast(dji.stl, method="arima", h=12, level=95)
#plot(dji.forecast, ylab="stock price", xlab="year", sub="forecast")
#