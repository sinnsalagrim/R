#############################
#clustering
#############################

df <- read.csv('c:/users/mohammadi/python/affiliateTest-20190210.csv')
unique(df$OS)
###########
# Data cleansing
###########
df$ReferrerUrl <- suffix_extract(domain(df$ReferrerUrl))$host #extracting domains
any(is.na(df)) # finding where to do data densification

###########
# Data preparation
###########
df$hours <- as.POSIXlt(as.POSIXct(df$TrackingTime, format= '%Y-%m-%d %H:%M:%S'))$hour # extracting hours
df$weekdays <- weekdays(df$TrackingTime, abbreviate = FALSE) # extracting weekdays

mydata <- na.omit(df5.df) # listwise deletion of missing
mydata <- scale(df5.df,[-3]) # standardize variables except for the third
df.copy <- df