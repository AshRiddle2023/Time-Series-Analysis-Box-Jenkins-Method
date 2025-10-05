# Time-Series-Analysis-Box-Jenkins-Method
A comprehensive time series analysis project applying the Box–Jenkins method for ARMA and ARIMA model identification, estimation, validation, and forecasting using R.

## Problem Summary

### Introduction
The **Box–Jenkins method** is a mathematical approach used to model and forecast time series data.  
It applies primarily to **ARMA** and **ARIMA** models through a structured four-stage process:

1. **Model Identification**  
   - Check stationarity using the **Augmented Dickey–Fuller (ADF) test**.  
   - Apply differencing if the series is non-stationary.  
   - Use **ACF** and **PACF** plots to determine AR (p) and MA (q) orders.  
   - Compare candidate models using **AIC** to select the best specification.

2. **Model Estimation**  
   - Estimate coefficients for the selected ARIMA model using R’s `arima()` or `auto.arima()` function.  
   - Obtain parameter estimates for further forecasting.

3. **Model Validation**  
   - Check the **ACF of residuals** to ensure no significant autocorrelation remains.  
   - Conduct the **Ljung–Box test** (high p-value > 0.05 indicates a good fit).  
   - Use **Normal Q–Q plots** to assess the normality of residuals.

4. **Forecasting**  
   - Generate forecasts for the next 100 observations with **95% confidence intervals** using the fitted model.


> **Note:** The original dataset is no longer available,  
> but the scripts and workflow remain reproducible with any time series input.
