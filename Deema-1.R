sleep_for_a_minute <- function() { Sys.sleep(60) }
start_time <- Sys.time()
df5 <- read.csv('c:/users/mohammadi/python/cid5.csv')
sleep_for_a_minute()
end_time <- Sys.time()
end_time - start_time
# Time difference of 1.000327 mins

df5.copy <- df5
df5$Success <- gsub("False", "Callbacked", df5f$Success)
df5$Success <- gsub("True", "Callbacked", df5$Success)
df5$Success <- as.factor(df5$Success)
# customerCid : 5
# source : 7 
#extracting time
times <- as.POSIXct(df5$TrackingTime, format= '%Y-%m-%d %H:%M:%S')
#extracting hour
hours <- as.POSIXlt(times)$hour
unique(times)
df5$hours <- hours
ggplot(df5, aes(x=TrackingTime)) + geom_histogram(alpha = 0.5, aes(fill=factor(Success))) # no use
install.packages("dplyr")
library(dplyr)
grb <- summarise(group_by(df5,source,hours,Success),count =n())
write.csv(grb, file = 'hours5.csv')
# some calculation on the file
samplot <- read.csv('Groups.csv')
ggplot(samplot, aes(x=TrackingTime, y=rate)) + geom_point(aes(color = factor(Source)))

#extracting weekdays from date
df5$weekdays <- weekdays(df5$TrackingTime, abbreviate = FALSE)
grb2 <- summarise(group_by(df5,source,weekdays,Success),count =n())
write.csv(grb2, file = 'weekdays5.csv')
# some calculation on the file 
weekdayschart <-read.csv('weekdays.csv')

# Creating radar chart packages
install.packages("devtools")
library(devtools)
install_github("ricardo-bion/ggradar")
library(ggradar)
suppressPackageStartupMessages(library(dplyr))
library(scales)

ggradar(weekdayschart, aes(color=rate))

# extracting models and categorizing
modelsss <- unique(df$Model)
nrow(as.data.frame(modelsss))
write.csv(modelsss, file = 'PhoneModels.csv')

### extracting source periods from the data
df$TrackingTime <- as.POSIXct(df$TrackingTime, format= '%Y-%m-%d %H:%M:%S')
max(filter(df, df$source==20)$TrackingTime)
min(filter(df, df$source==20)$TrackingTime)

##### saving df
count<-df5$Tree
age<-Orange$age
circumference<-Orange$circumference
#save to rda file
save(count, age, circumference, file = "mydata.rda")

### association rule
df5.to.t <- filter(subset(df5, select = c(source, Success, hours, weekdays)), Success == "Callbacked") # params must be factors
library(arules)
transaction.ata <- as (df5.to.t, "transactions") # convert to 'transactions' class
inspect(head(transaction.ata, 3)) # see data head
frequentItems <- eclat (transaction.ata, parameter = list(supp = 0.07, maxlen = 15)) # calculates support for frequent items
itemFrequencyPlot(transaction.ata, topN=10, type="absolute", main="Item Frequency") # plot frequent items
###################################################################


df[,'Success'] <- as.factor(df[, 'Success']) # turn success to factor
library(ggplot2)

df.cpy <- df
install.packages('caTools') 
library(caTools)
set.seed(12345) # the seed that is set for decision tree
sample <- sample.split(df.cpy$Success, SplitRatio = 0.7) 
trainset <- subset(df.cpy, sample == TRUE)
testset <- subset(df.cpy, sample == FALSE)