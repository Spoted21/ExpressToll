# Add day of week 
mydata$day <- weekdays(mydata$Date)

# dayLevel <- mydata %>%
#   group_by(day) %>%
#   summarise(Amount = sum(Amount)) %>% data.frame()
# 
# dayLevel$CumulativeAmount = cumsum(dayLevel$Amount) 
# dayLevel$CommuteDay <- 1:nrow(dayLevel)
# dayLevel
# ggplot(dayLevel, aes(x=CommuteDay,y=dayLevel$CumulativeAmount) ) + 
#   geom_area() +
#   labs(x="",y="")
# 
# 
# #Day of Week Level
# dayOfWeekLevel <- mydata %>% filter(day!="Saturday") %>%
#   group_by(day) %>%
#   summarise(Amount = sum(Amount)) %>% data.frame()


# unique(mydata[mydata$day=="Saturday",]$Date)
#   sum(mydata[mydata$day=="Saturday",]$Amount)
#   
# hist(dayOfWeekLevel$Amount)

library(plotly)
library(sqldf)

plotData <- mydata %>% filter(day!="Saturday") 
workWeek <- data.frame(day=c("Monday","Tuesday","Wednesday","Thursday","Friday"),
                       num = c(1,2,3,4,5) )
plotData <- sqldf("
             Select 
                  sum(p.Amount) as Amount,
                  Count(distinct Date) as daysDriving,
                  p.day
             From plotData p
             inner join 
             workWeek
             on p.day= workWeek.day
             Group By 
              p.day
            Order By Amount desc")
plotData$cumsum <- cumsum(plotData$Amount)
plotData$avg <- plotData$Amount /plotData$daysDriving  
# plotData$sd <- plotData$Amount /plotData$daysDriving  

png("pareto.png")
bar <- barplot(plotData$Amount, 
        las=1,
        col="cyan4",
        width = 1, space = 0.2, border = NA, axes = F,
        ylim = c(0, 1.05 * max(plotData$cumsum, na.rm = T)), 
        # ylab = "Cummulative Dollars" , 
        cex.names = 0.7, 
          names.arg = plotData$day,
        main = "Tolls Per Day")
lines(bar,
      plotData$cumsum, 
      type = "b", 
      cex = 0.7, 
      pch = 19, 
      col="cyan4",
      lwd=2
      ) 
axis(side = 2, 
     at = axTicks(2), 
     las = 1, 
     # col.axis = "grey62", 
     # col = "grey62", 
     tick = T, 
     cex.axis = 0.8,
     labels = bigm(axTicks(2) ) 
     )
dev.off()
