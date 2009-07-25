# This is the first half of the analysis on http://climatekaraoke.pbworks.com/Stage-2

climate <- read.csv("/Users/kd/Desktop/climatekaraoke/Climate-Karaoke/all_data.csv")
climate$co2.log.diff <- log(climate$co2_mean-270)
climate.summary <- climate[grep("^(VOLCANIC|SOLAR|ANOMALY|co2.log)",names(climate))] 


my.model <- lm(ANOMALY ~ ., data=climate.summary)
my.step.model <- step(my.model)

