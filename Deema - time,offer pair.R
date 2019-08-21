# Deema time - offer checking
# parameters: campaign category, source, season
# which hours has higher campaign loads
ofti <- read_excel('E:/SiminDoc/DataAnalysis/Deema/Deema-time,offer.xlsx', sheet = 'Sheet1')
ofti.copy <- ofti
ofti <- subset(ofti, select = -c(Weeks)) # drop a col
ofti <- subset(ofti, select = -c(campaignResaltType)) # drop a col
ofti <- filter(ofti, customercampaignid < 150)

ggplot(ofti, aes(x=Hours, y=Hits)) + geom_point(aes(color = source))

test <- as.data.frame(Orange)
count<-Orange$Tree
age<-Orange$age
circumference<-Orange$circumference
#save to rda file
save(count, age, circumference, file = "mydata.rda")
#remove variables
#rm(age, circumference, count)
#load the rda file
#load(file = "mydata.rda")
ofti$customerType <- gsub("Film & Cartoon", "1", ofti$customerType)
ofti$customerType <- gsub("Finance", "2", ofti$customerType)
ofti$customerType <- gsub("Game", "3", ofti$customerType)
ofti$customerType <- gsub("Life Style", "4", ofti$customerType)
ofti$customerType <- gsub("Retail", "5", ofti$customerType)
ofti$customerType <- gsub("Service", "6", ofti$customerType)
ofti$customerType <- gsub("Tools", "7", ofti$customerType)
ofti$customerType <- gsub("Transportation", "8", ofti$customerType)
ofti$customerType <- gsub("Travel", "9", ofti$customerType)
ofti$customerType <- gsub("NA", "10", ofti$customerType)
ofti.copy.2 <- ofti

