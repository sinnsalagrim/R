library(RODBC)
library(MASS)

channel <- odbcDriverConnect('driver={SQL Server};server=79.175.181.141,11296;database=AffiliateNetwork;uid=mohammadi;pwd=123456789;')
df_total <- data.frame()
sleep_for_a_minute <- function() { Sys.sleep(60) }
start_time <- Sys.time()
for (n in 1:100){
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
  n <- (n-1)*50000
}

sleep_for_a_minute()
end_time <- Sys.time()
end_time - start_time


total.offer <- sqlQuery(channel, paste("select top 10 * from offervisitor"))



fit <- lm(medv~., data= )


