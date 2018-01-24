# forecast
# biblioteki
suppressMessages(library("forecast"))
suppressMessages(library("tseries"))
suppressMessages(library("RPostgreSQL"))
suppressMessages(library("lubridate"))
# baza
drv <- dbDriver("PostgreSQL")
#con <- dbConnect(drv, user= "majster", password="System32", dbname = "broker_development")
con <- dbConnect(drv, dbname = "broker_production")
dji.prices <- dbGetQuery(con, "select * from dji_prices")
dbdisc <- dbDisconnect(con)
# dane
dji.prices <- transform(dji.prices, Date = ymd(date))
dji.prices <- tail(dji.prices, n=1100)
dji <- with(dji.prices, rev(close))
dates <- with(dji.prices, rev(date))
dji.msts <- msts(rev(dji), seasonal.periods=c(7,365.25), start=2016, end=2018)
# arima
dji.arima.data <- data.frame(closing = dji.msts, lclosing = log(dji.msts))
dji.arima.stl <- stl(dji.arima.data$closing, s.window = "periodic")
dji.arima.f <- forecast(dji.arima.stl, method="arima", h=367, level=95)
# nnetar
dji.nnet.fit <- nnetar(dji.msts, p = 9, P=, size = 3, repeats = 10, lambda = 0)
dji.nnet.f <- forecast(dji.nnet.fit, 367)
# wyniki
dates <- data.frame(date = seq(as.Date(tail(dji.prices$Date, n=1)+1), by = 'days', length = 367))
dji.forecasts <- data.frame(date=as.matrix(dates), arima=as.matrix(dji.arima.f$mean), nnetar=as.matrix(dji.nnet.f$mean))
print(dji.forecasts, row.names = FALSE)
# print(sprintf("Forecast for day next to: %s", as.character(tail(dji.prices$Date, n=1))))
# print(sprintf("Arima: %s", as.character(dji.arima.f$mean[1])))
# print(sprintf("Neural Network: %s", as.character(dji.nnet.f$mean[1])))
# plot(dji.arima.f)
#
