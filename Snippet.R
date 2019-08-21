# Alt + enter
data() # shows all the packages i have

#######
# reading large csv files
#######
library(data.table)
#read.csv() loads data in data.frame format
large.csv.file <- fread("c:/... address.csv") #loads data in data-table format

#######
#reading large data set from SQL server
#######
channel <- odbcDriverConnect('driver={SQL Server};server=79.175.181.141,11296;database=AffiliateNetwork;uid=mohammadi;pwd=123456789')
fetch.large.data <- sqlFetch(channel, "offervisitor", max = 100000, rows_at_time = 10)
sqlFetchMore(channel, max = 100000)
sqlSave(channel, fetch.large.data, append = TRUE, colnames = TRUE)

sqlFetchMore(channel, max = 100000)
sqlFetchMore(channel) # get the rest
sqlDrop(channel, "offervisitor") 
close(channel)

#######
# how long it takes to run a code
#######
sleep_for_a_minute <- function() { Sys.sleep(60) }
start_time <- Sys.time()
# put the code here 
sleep_for_a_minute()
end_time <- Sys.time()
end_time - start_time


#######
# saving data sets in R
#######
view(large.sql.file)
save(large.sql.file, file='address/filename.rdata') #save the data in local
load('address/filename.rdata')
rm(large.sql.file)

#######
# adding knit/markdown
#######
# in rgui:
  install.packages("installr"); library(installr) 
  updater()
# in rstudio, click on file -> R markdown -> it will install required packages : knitr, rmarkdown, ...
# knot will be added in the bar 
