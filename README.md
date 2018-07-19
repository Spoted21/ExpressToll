# ExpressToll

After cloning the repo you can run a few lines of R code to visualize what the toll expenditures look like.

### R Code 
```r
library(lubridate)
library(ggplot2)
library(dplyr)


mydata <- read.csv(file = "https://raw.githubusercontent.com/Spoted21/ExpressToll/master/tolls.csv")
names(mydata) <- gsub(pattern = "\\.",replacement = "",x = names(mydata))
mydata$TransactionDateTime <- strptime(mydata$TransactionDateTime,format = 
                                         "%m-%d-%Y %H:%M:%S")

mydata$TransactionDateTime <- as.POSIXct(mydata$TransactionDateTime )
mydata$Date <- as.Date(mydata$TransactionDateTime )
mydata$Amount <-as.numeric( gsub(pattern = "\\$",replacement = "",
                                 x = mydata$Amount) )
mydata$Week <- floor_date(mydata$Date, unit = "week")


bigm <- function(x) paste0("$",formatC(x = x,digits = 0,format = "d"))
TotalTolls <- sum(mydata$Amount)

mydata %>%
  group_by(Week) %>%
  summarise(Total = sum(Amount)) %>%
  data.frame() %>% 
  ggplot( aes(y=Total,x=Week)) + geom_line() +
  geom_smooth() +
  geom_point(color="red") + 
  labs(caption =paste0("Total Tolls = ",bigm(TotalTolls)))

```

### Tolls By Week 
![](TollsByWeek2.png)
