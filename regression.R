# This is the second half of the http://climatekaraoke.pbworks.com/Stage-2 analysis

climate <- read.csv("/Users/kd/Desktop/climatekaraoke/Climate-Karaoke/all_data.csv")
climate$co2.log.diff <- log(climate$co2_mean-270)

climate.summary <- climate[grep("^(VOLCANIC|SOLAR|ANOMALY|co2(_mean|.log)|Year)",names(climate))]
my.model <- lm(ANOMALY ~ ., data=climate.summary)
step(my.model)

climate.summary <- climate[grep("^(VOLCANIC|SOLAR|ANOMALY|co2(_mean|.log))",names(climate))]
my.model <- lm(ANOMALY ~ ., data=climate.summary)
step(my.model)

climate.summary <- climate[grep("^(VOLCANIC|SOLAR|ANOMALY|co2_mean)",names(climate))]
my.model <- lm(ANOMALY ~ ., data=climate.summary)
step(my.model)


