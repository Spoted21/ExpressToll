dayLevel <- mydata %>%
  group_by(day) %>%
  summarise(Amount = sum(Amount)) %>% data.frame()

dayLevel$CumulativeAmount = cumsum(dayLevel$Amount) 
dayLevel$CommuteDay <- 1:nrow(dayLevel)
dayLevel
ggplot(dayLevel, aes(x=CommuteDay,y=dayLevel$CumulativeAmount) ) + 
  geom_area() +
  labs(x="",y="")


# Tolls Per Day
mydata$dayName = weekdays(mydata$day)

#Day of Week Level
dayOfWeekLevel <- mydata %>%
  group_by(dayName) %>%
  summarise(Amount = sum(Amount)) %>% data.frame()
