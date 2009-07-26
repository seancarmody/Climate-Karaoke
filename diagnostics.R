library(gvlma)
climate <- read.csv("/Users/kd/Desktop/climatekaraoke/Climate-Karaoke/all_data.csv")
climate.summary <- climate[grep("^(VOLCANIC|SOLAR|ANOMALY|co2_mean)",names(climate))]
my.model <- lm(ANOMALY ~ ., data=climate.summary)

climate.summary.log <- climate[grep("^(VOLCANIC|SOLAR|ANOMALY|co2.log)",names(climate))]
my.log.model <- lm(ANOMALY ~ ., data=climate.summary.log)

# gvlma is Global Validation of Linear Models Assumptions

validation <- gvlma(my.model)
log.validation <- gvlma(my.log.model)
png('validataion.png')
plot.gvlma(validation)
dev.off()
png('log_validataion.png')
plot.gvlma(log.validation)
dev.off()  
