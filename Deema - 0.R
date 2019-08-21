### Deema first try
 # modifieddate = when the offer has changed
 # trackingtime = when user clicked
 # conversiontime = when callback conversion is received
 # conversion rate < 1% 

install.packages('RODBC')
library(RODBC)
DeemaConnection <- odbcDriverConnect(connection="driver={SQL Server};server=79.175.154.140,11296;database=SabaadDSP;trusted_connection=yes;")
callbacks <- sqlQuery(DeemaConnection, "select cd.[source], cd.pubid, cd.TrackingTime, cd.CustomerCampaignId
                                             from callbackconversion cc
                                             left join CampaignData cd
                                             on cc.clickid = cd.clickid
                                             where cd.CampaignID= 3")
# delete a dataframe's col
# callbacks$success <- NULL
callbacks$Success <- c('callbacked')
offers <- sqlQuery(DeemaConnection, paste("select [source], pubid, TrackingTime, CustomerCampaignId
                                          from CampaignData
                                          where campaignId= 3 and ClickId not in (select clickid from CallBackConversion)"))
offers$Success <- c('NoCR')
DF <- rbind(callbacks, offers)
DF.copy <- as.dataframe(DF)

# cleaning data
install.packages('urltools')
library(urltools)
DF.copy$ReferrerUrl <- suffix_extract(domain(DF.copy$ReferrerUrl))$host


# train and test set creationdf.copy
install.packages('caTools') 
library(caTools)
set.seed(12345) # the seed that is set for decision tree
sample <- sample.split(DF.copy$Success, SplitRatio = 0.7) 
trainset <- subset(DF.copy, sample == TRUE)
testset <- subset(DF.copy, sample == FALSE)

# making the tree
install.packages("rpart")  
library(rpart)
ctrl <- rpart.control(maxdepth = 5)
tree <- rpart(Success ~., method = 'class', data = trainset, control = ctrl)
tree.preds <- predict(tree,testset)
dtree.preds <- as.data.frame(tree.preds)
colnames(dtree.preds) <- c('col1', 'col2')
dtree.preds$Success <- sapply(dtree.preds$col2, final.stat)

table(dtree.preds$Success,testset$Success)
View(tree)
#drawing the tree
library(rpart.plot)
prp(tree) # it aborts maybe because of the data not being clean

# random forest
library(randomForest)
rf.model <- randomForest(DF.copy$Success ~., data = DF.copy)
print(rf.model)
importance(rf.model)
  
#### comment
df <- as.data.frame(sqltest) # to draw plots need to do this
library(ggplot2)
ggplot(df, aes(y=SuccessReceive, x=os))+geom_point()
install.packages('JDBC') # adding new package
#### end of comment

# Seddigh solution
DeemaConnection <- odbcDriverConnect(connection='driver={SQL Server};server=79.175.181.141,11296;database=AffiliateNetwork;uid=mohammadi;pwd=123456789')
total.offer <- sqlQuery(DeemaConnection, paste("WITH query
                                                AS ( SELECT   pubid, siteid ,
                                                 offerid
                                                 FROM      OfferVisitor 
                                                 WHERE    campaignid = 3
                                                                       
                        )
                                                SELECT pubid, siteid, [4] as totalOffer4,[6] as totalOffer6,[7] as totalOffer7,[9] as totalOffer9,[10] as totalOffer10,[11] as totalOffer11,[12] as totalOffer12,[13] as totalOffer13,[14] as totalOffer14,[24] as totalOffer24
                                                FROM   query
                                                PIVOT(count(offerid) FOR offerid IN ([4],[6],[7],[9],[10],[11],[12],[13],[14],[24])) AS p;"))
offer.callback <- sqlQuery(DeemaConnection, paste("WITH query
                                                  AS ( SELECT   ov.pubid as pubid, ov.siteid as siteid ,
                                                  ov.OfferId as offerid
                                                  FROM      OfferVisitor ov
                                                  left join callbackconversion cc
                                                  on cc.clickid = ov.clickid
                                                  where ov.campaignid = 3
                                                                          
                        )
                                                   SELECT pubid, siteid, [4] as offerCallbacks4,[6] as offerCallbacks6,[7] as offerCallbacks7,[9] as offerCallbacks9,[10] as offerCallbacks10,[11] as offerCallbacks11,[12] as offerCallbacks12,[13] as offerCallbacks13,[14] as offerCallbacks14,[24] as offerCallbacks24
                                                   FROM   query
                                                   PIVOT(count(offerid) FOR offerid IN ([4],[6],[7],[9],[10],[11],[12],[13],[14],[24])) AS p;"))
close(DeemaConnection)
sed <- merge( offer.callback,  total.offer, by=c('siteid', 'pubid'), all = TRUE) # full join on dataframes
install.packages('xlsx')
library(xlsx)
write.xlsx(sed, 'sed.xlsx')


  