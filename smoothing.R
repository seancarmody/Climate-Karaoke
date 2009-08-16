# Climate Karaoke - time series smoothing
#
# Author:        Sean Carmody
# Creation Date: 15 August 2009
#
# Licenced: creative commons Attribution-Share Alike 2.5 Australia
# http://creativecommons.org/licenses/by-sa/2.5/au/

library(zoo)

# Read in Kieran's full data set and turn into a zoo series
climate <- read.csv("all_data.csv")
climate <- zoo(climate[,-1], order.by=climate$Year)

# Strip out just IPCC anomaly and CO2 series
anom <- na.omit(climate[ ,c("ANOMALY", "co2_mean")])

# Stip our IPCC and UAH anomalies
min.year <- min(time(climate)[!is.na(climate$nih)])
uah <- climate[time(climate) >= min.year, c("ANOMALY", "nih")]

# Using a Unicode character for the degree symbol to stop Mac OS X choking
label <- paste("Temperature Anomaly (", "\u00B0", "C)", sep="") 

# Chart with least-squares line of best fit
png("temp-bestfit.png", width=500, height=300)
par(mar=c(2.5,5,1,1), bty="n")
str.line <- lm(uah$nih ~ time(uah))
plot(uah$nih, xlab="", ylab=label)
lines(time(uah), str.line$fitted.values, col="grey")
dev.off()

# Chart with 5 year moving average
png("temp-ma.png", width=500, height=300)
par(mar=c(2.5,5,1,1), bty="n")
plot(uah$nih, xlab="", ylab=label)
lines(rollmean(uah$nih, 5, align="right"), col="red")
legend(1996, -0.12, legend=c("UAH series", "Moving Average (5 yr)"), 
	lwd=1, col=c("black", "red"), bty="n")
dev.off()

# Chart with regression fitted values
png("temp-regression.png", width=500, height=300)
par(mar=c(2.5,5,1,1), bty="n")
plot(uah$nih, xlab="", ylab=label)
fit <- lm(nih ~ ANOMALY, uah)
lines(time(uah)[!is.na(uah$ANOMALY)], fit$fitted.values, col="blue")
legend(1995, -0.12, legend=c("UAH series", "Fitted from IPCC"), 
	lwd=1, col=c("black", "blue"), bty="n")
dev.off()

# Chart with spline and lowess curves
png("temp-smooth.png", width=500, height=300)
par(mar=c(2.5,5,1,1), bty="n")
plot(uah$nih, xlab="", ylab=label)
lines(smooth.spline(time(uah), uah$nih, spar=0.7), col="blue")
lines(lowess(time(uah), uah$nih), col="green")
legend(1996, -0.06, legend=c("UAH series", "Spline", "Lowess"), 
	lwd=1, col=c("black", "blue", "green"), bty="n")
dev.off()

