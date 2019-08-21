
sleep_for_a_minute <- function() { Sys.sleep(60) }
start_time <- Sys.time()
f1 <- sqlFetch(channel, "offervisitor", max = 1000000)
sleep_for_a_minute()
end_time <- Sys.time()



sleep_for_a_minute <- function() { Sys.sleep(60) }
start_time <- Sys.time()
f2 <- sqlFetchMore(channel, max = 100000)
sleep_for_a_minute()
end_time <- Sys.time()
end_time - start_time
f3 <- sqlFetchMore(channel, max = 100000)
f4 <- sqlFetchMore(channel, max = 100000)
f5 <- sqlFetchMore(channel, max = 100000)
f6 <- sqlFetchMore(channel, max = 100000)


fit3 <- lm(successreceive~., data=callbacks)
par(mfrow=c(2,2)) # puts all the plots in one. if you just draw it need to hit enter to see next
plot(fit3)


callbacks <-  sqlQuery(myconnection,paste("select offerId,
AffiliatorId,
SiteId,
TrackingTime,
Province,
SUBSTRING(ReferrerUrl,
          (CASE WHEN CHARINDEX('//', ReferrerUrl)= 0 THEN 1 ELSE CHARINDEX('//', ReferrerUrl) + 2 END),
          CASE
          WHEN CHARINDEX('/', ReferrerUrl, CHARINDEX('//', ReferrerUrl) + 2) > 0 THEN CHARINDEX('/', ReferrerUrl, CHARINDEX('//', ReferrerUrl) + 2) - (CASE WHEN CHARINDEX('//', ReferrerUrl)= 0 THEN 1 ELSE CHARINDEX('//', ReferrerUrl) + 2 END)
          WHEN CHARINDEX('?', ReferrerUrl, CHARINDEX('//', ReferrerUrl) + 2) > 0 THEN CHARINDEX('?', ReferrerUrl, CHARINDEX('//', ReferrerUrl) + 2) - (CASE WHEN CHARINDEX('//', ReferrerUrl)= 0 THEN 1 ELSE CHARINDEX('//', ReferrerUrl) + 2 END)
          ELSE LEN(ReferrerUrl)
          END
) AS 'ReferrerUrl',
cc.successreceive
from callbackconversion cc
left join offervisitor o
on o.clickid = cc.clickid
                       ") )


n = 10
offers <- sqlQuery(channel, paste(
  "SELECT 
                                    o.offerId,
                                    o.AffiliatorId,
                                    o.SiteId,
                                    o.TrackingTime,
                                    o.Province,
                                    SUBSTRING(o.ReferrerUrl,
                                            (CASE WHEN CHARINDEX('//', o.ReferrerUrl)= 0 THEN 1 ELSE CHARINDEX('//', o.ReferrerUrl) + 2 END),
                                            CASE
                                                WHEN CHARINDEX('/', o.ReferrerUrl, CHARINDEX('//', o.ReferrerUrl) + 2) > 0 THEN CHARINDEX('/', o.ReferrerUrl, CHARINDEX('//', o.ReferrerUrl) + 2) - (CASE WHEN CHARINDEX('//', o.ReferrerUrl)= 0 THEN 1 ELSE CHARINDEX('//', o.ReferrerUrl) + 2 END)
                                                WHEN CHARINDEX('?', o.ReferrerUrl, CHARINDEX('//', o.ReferrerUrl) + 2) > 0 THEN CHARINDEX('?', o.ReferrerUrl, CHARINDEX('//', o.ReferrerUrl) + 2) - (CASE WHEN CHARINDEX('//', o.ReferrerUrl)= 0 THEN 1 ELSE CHARINDEX('//', o.ReferrerUrl) + 2 END)
                                                ELSE LEN(o.ReferrerUrl)
                                            END
                                        ) AS 'ReferrerUrl',
                                    cc.successreceive
                                  from callbackconversion cc
                                  left join offervisitor o
                                      on o.clickid = cc.clickid
                                  ORDER BY o.TrackingTime DESC
                                  OFFSET 10 ROWS
                                  FETCH NEXT 50000 ROWS ONLY"))



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


df_total <- data.frame()
sleep_for_a_minute <- function() { Sys.sleep(60) }
start_time <- Sys.time()
for (n in 1:10){
  offers <- sqlQuery(channel,paste(
    "SELECT 
    offerId,
    AffiliatorId,
    SiteId,
    TrackingTime,
    Province,
    SUBSTRING(ReferrerUrl,
    (CASE WHEN CHARINDEX('//', ReferrerUrl)= 0 THEN 1 ELSE CHARINDEX('//', ReferrerUrl) + 2 END),
    CASE
    WHEN CHARINDEX('/', ReferrerUrl, CHARINDEX('//', ReferrerUrl) + 2) > 0 THEN CHARINDEX('/', ReferrerUrl, CHARINDEX('//', ReferrerUrl) + 2) - (CASE WHEN CHARINDEX('//', ReferrerUrl)= 0 THEN 1 ELSE CHARINDEX('//', ReferrerUrl) + 2 END)
    WHEN CHARINDEX('?', ReferrerUrl, CHARINDEX('//', ReferrerUrl) + 2) > 0 THEN CHARINDEX('?', ReferrerUrl, CHARINDEX('//', ReferrerUrl) + 2) - (CASE WHEN CHARINDEX('//', ReferrerUrl)= 0 THEN 1 ELSE CHARINDEX('//', ReferrerUrl) + 2 END)
    ELSE LEN(ReferrerUrl)
    END
    ) AS 'ReferrerUrl'
    
    FROM offervisitor
    ORDER BY TrackingTime DESC
    OFFSET ", n, " ROWS
    FETCH NEXT 50000 ROWS ONLY"))
  
  df<- offers
  df_total <- rbind(df_total,df)
  n <- (n-1)*100000
}
sleep_for_a_minute()
end_time <- Sys.time()
end_time - start_time
