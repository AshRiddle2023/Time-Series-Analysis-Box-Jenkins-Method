> data <- read.table("Group2.txt", header = TRUE)
> ts_data <- ts(data)
> length(ts_data)

> library(forecast)
> library(tseries)
> library(ggplot2)

> plot(ts_data)

> check_stationarity <- function(ts) {
+   adf_test <- adf.test(ts)
+   print(paste("ADF Statistic: ", adf_test$statistic))
+   print(paste("p-value: ", adf_test$p.value))
+   print(adf_test)
+ }

> plot_acf_pacf <- function(ts) {
+   par(mfrow = c(1,2))
+   acf(ts, main = 'ACF')
+   pacf(ts, main = 'PACF')
+   par(mfrow = c(1,1))
+ }

> check_stationarity(ts_data)
> diff_data <- diff(ts_data)
> plot(diff_data)
> check_stationarity(diff_data)
> plot_acf_pacf(diff_data)

> best_aic <- Inf
> best_order <- c(0, 0, 0)
> top_results <- data.frame(AIC = numeric(), Order = character(), stringsAsFactors = FALSE)

> for (p in 0:3) {  
+  for (d in 0:1) { 
+   for (q in 0:3) { 
+    arima_model <- tryCatch(Arima(ts_data, order = c(p, d, q)), error = function(e) NULL)
+     if (!is.null(arima_model)) {
+      current_aic <- AIC(arima_model)
+         
+      top_results <- rbind(top_results, 
+                     data.frame(AIC = current_aic, Order = paste(c(p, d, q), collapse = ",")))
+      top_results <- top_results[order(top_results$AIC), ]
+      if (nrow(top_results) > 10) {
+       top_results <- top_results[1:10, ]
+      }
+ 
+      if (current_aic < best_aic) {
+       best_aic <- current_aic
+       best_order <- c(p, d, q)
+ } } } } } 

> print(top_results, row.names = FALSE)
> print(paste("Best AIC: ", best_aic))
> print(paste("Best Order: ", paste(best_order, collapse = ",")))

> best_model <- arima(ts_data, order = best_order)
> best_model
> coef(best_model)

> acf(resid(best_model))
> Box.test(resid(best_model), lag = 20, type = "Ljung-Box")
> qqnorm(resid(best_model))
> qqline(resid(best_model), col = "red")

> data_for <- predict(best_model, n.ahead = 100)
> ts.plot(ts_data, data_for$pred, 
+           ylab = "data", col = "blue", ylim = c(-76,0.5))
> grid ()

> U = data_for$pred + 2 *data_for$se
> L = data_for$pred - 2 *data_for$se
> xx = c(time (U), rev (time (U)))
> yy = c(L, rev(U))
> polygon(xx, yy, border = 8, col = gray (0.6, alpha = 0.2))
> lines(data_for$pred, type = "p", col = "red")

> tail(ts_data)
> tail(resid(best_model), n = 3)
> head(data_for$pred, n = 1)

> data_for$pred[1:5]
