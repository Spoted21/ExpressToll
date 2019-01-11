# Add day of week 
mydata$day <- weekdays(mydata$Date)

dayLevel <- mydata %>%
  group_by(day) %>%
  summarise(Amount = sum(Amount)) %>% data.frame()

dayLevel$CumulativeAmount = cumsum(dayLevel$Amount) 
dayLevel$CommuteDay <- 1:nrow(dayLevel)
dayLevel
ggplot(dayLevel, aes(x=CommuteDay,y=dayLevel$CumulativeAmount) ) + 
  geom_area() +
  labs(x="",y="")


#Day of Week Level
dayOfWeekLevel <- mydata %>% filter(day!="Saturday") %>%
  group_by(day) %>%
  summarise(Amount = sum(Amount)) %>% data.frame()


# unique(mydata[mydata$day=="Saturday",]$Date)
#   sum(mydata[mydata$day=="Saturday",]$Amount)
#   
hist(dayOfWeekLevel$Amount)

p <- mydata %>% filter(day!="Saturday") %>%
 plot_ly( y = ~Amount, color = ~day, type = "box")
p

library(plotly)

x = c("Apples","Apples","Apples","Organges", "Bananas")
y = c("5","10","3","10","5")

p <- plot_ly(x=mydata$day,
             y=mydata$Amount, 
             histfunc='sum',
             type = "histogram") %>%
  layout(yaxis=list(type='linear'))
p
