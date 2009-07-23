climate <- read.csv("/Users/kd/Desktop/climatekaraoke/Climate-Karaoke/all_data.csv")
climate$co2.log.diff <- log(climate$co2_mean-270)
climate.summary <- climate[grep("^[A-Z][A-Z]+|co2_mean|co2.log",names(climate))] 


panel.cor <- function(x, y, digits=2, prefix="", cex.cor) 
{
    usr <- par("usr"); on.exit(par(usr)) 
    par(usr = c(0, 1, 0, 1)) 
    r <- abs(cor(x, y,use="complete")) 
    txt <- format(c(r, 0.123456789), digits=digits)[1] 
    txt <- paste(prefix, txt, sep="") 
    if(missing(cex.cor)) cex <- 0.8/strwidth(txt) 

    test <- cor.test(x,y) 
    # borrowed from printCoefmat
    Signif <- symnum(test$p.value, corr = FALSE, na = FALSE, 
                  cutpoints = c(0, 0.001, 0.01, 0.05, 0.1, 1),
                  symbols = c("***", "**", "*", ".", " ")) 

    text(0.5, 0.5, txt, cex = cex * r) 
    text(.8, .8, Signif, cex=cex, col=2) 
}
pairs(climate.summary, 
  lower.panel=panel.smooth, upper.panel=panel.cor) 

