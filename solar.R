# Here's what we do.

# 1. get climate data.

climate <- read.csv("/Users/kd/Desktop/climatekaraoke/Climate-Karaoke/all_data.csv")


# 2 make a solar only model
solar.model <- lm (climate$ANOMALY ~ climate$SOLAR)

# 3.  plot the residuals
# note that the last negative residual was in 1917  The probability of this occuring by chance is very small.
# let's look at the distribution of +xe and -ve residuals over time ...

# here are our assumptions:

# the chances of having a +ve or -ve standardised residual over time is equal
# therefore we can see times when solar doesn't predict anomaly well by examining these.

solar.model.resids <- read.csv("solar_model_residuals.csv")

# manipulate this data in excel to give us the lengths of runs of positive and negative residuals.

resid.stream<-read.csv("resid_stream.csv")

png('resid_stream.png')
plot(resid.stream$year,resid.stream$length)

# next we find which perdiods have a +ve or -ve residual run of >= 3 standard deviations from the mean of residual run:

resid.stream[scale(resid.stream$length) >= 3,]

year_stop resid length (years) mean resid  sd resid
1455      +     61             1.05        0.45
1567      +     56             0.74        0.26
1661      -     74             -1.21       0.68
1784      -     108            -0.66       0.34
2000      +     82             1.42        0.63

the R syntax that I can work out for this is ugly ... something like the following:

mean( subset(  subset(solar.model.resids,X >= (2000-82-900)) , X < (2000-900)))
sd( subset(  subset(solar.model.resids,X >= (2000-82-900)) , X < (2000-900)))

we can do a t test to see the diff between the mwp anomaly's residual's and the present day anomaly.

mwp <- subset(  subset(solar.model.resids,X >= (1455-61-900)) , X < (1454-900))$std_resid
present <- subset(  subset(solar.model.resids,X >= (2000-82-900)) , X < (2000-900))$std_resid

t.test(mwp,present)

	Welch Two Sample t-test

data:  mwp and present 
t = -4.1565, df = 139.889, p-value = 5.603e-05
alternative hypothesis: true difference in means is not equal to 0 
95 percent confidence interval:
 -0.5608582 -0.1992871 
sample estimates:
mean of x mean of y 
 1.048565  1.428638

Which conclusively demonstrates that the relationship between solar and anomaly is of a different character during the peak of the MWP than during last 80 odd years.

Also we can clearly see that solar irradiance has nothing to do with temperature anomaly in the present day due to this chart: http://www.ngdc.noaa.gov/stp/SOLAR/IRRADIANCE/irrad.html
