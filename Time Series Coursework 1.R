# Convert data from Air Passengers into a data frame with year on the x axis and number of passengers on the y axis
airpass.df = data.frame(
  ds=zoo::as.yearmon(time(AirPassengers)), 
  y=AirPassengers)

# Create a model using prophet using the Air Passengers data frame
apmodel = prophet::prophet(airpass.df,weekly.seasonality=TRUE,daily.seasonality=TRUE)

# Create a data frame for future predictions using the prophet model which goes 2 quarters into the futute (5 years)
apfuture = prophet::make_future_dataframe(m, periods=20, freq="quarter")

# Run the predict function using data from the Air Passengers dataframe and the future data frame created by using the prophet model
predict = predict(apmodel, apfuture)

# Plot and label the data and predictions
plot(apmodel,predict,xlab="Year",ylab="Number of passengers (in thousands)")

# Fit linear regression model
lm_model <- lm(AirPassengers ~ time(AirPassengers))
plot(AirPassengers,xlab="Year",ylab="Number of passengers (in thousands)")
# Add line of best fit
abline(lm_model, col = "red")
intercept <- coef(lm_model)[1]
slope <- coef(lm_model)[2]
line_eq <- paste("y =", round(slope, 2), "* x +", round(intercept, 2))
line_eq
