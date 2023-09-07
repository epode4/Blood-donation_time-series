library(fpp2)
library(patchwork)
library(readxl)
library(tidyverse)

four <- function(train_a,a=6,...){
  res <- vector("numeric",a)
  Time <- time(train_a)
  for (i in seq(res)){
    xreg <- cbind(Time,fourier(train_a,K=i))
    fit <- auto.arima(train_a,xreg=xreg,...)
    res[i] <- fit$aicc
  }
  b <- list(res,kmin <- which.min(res))
  return(b)
}

test <- function(train_a,fita,a){
  res_a <- residuals(fita)
  df_a <- length(fita$par)
  lag_a <- min(a,round(length(train_a)/5))
  ggtsdisplay(res_a,plot.type = "histogram")
  Box.test(res_a,fitdf=df_a,lag=lag_a,type="Ljung-Box")
}
