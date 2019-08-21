  #Functions start with capital letters
  #variables start with small case letters, seperated with dots mostly
  #ctrl + L <- cleare the console 
  # help("vector") or ??vector
getwd()
print('Hi Boss')
bank.account <- 1000
  #stock.prices[stock.prices == max(stock.prices)] or stock.prices[max.price]
  #matrixes
matrix(1:12, byrow = trunc(TRUE), nrow = 3)
goog <- c(450, 451,452, 445, 468)
msft <- c(231, 232, 233, 234, 235)
stocks <- c(goog,msft)
stocks
days <- c('Sat', 'Sun', 'Mon', 'Tue', 'Wed')
st.names <- c('google', 'msft')
stocks.matrix <- matrix(stocks, byrow = TRUE, 2)
rownames(stocks.matrix) <- st.names
colnames(stocks.matrix) <- days
stocks.matrix
colSums(stocks.matrix)
  #adding new row/column to matrix
FB <- c(111, 112, 113, 114, 115)
tech.stocks <- rbind(stocks.matrix, FB)
Thu = c(480, 250, 118)
tech.stocks <- cbind(tech.stocks, Thu)
tech.stocks
  #matrix multiplication
mat <- matrix(1:25, nrow(5), byrow=T)
mat %*% mat
  #Factors
  #nominal catecorigal variables like dogs and cats/ordinal cateforical variabled like tempreture
animal <- c('w', 'd', 'w', 'w', 'd')
id <- c(1,2,3,4,5)
fact.anim <- factor(animal)
temps <- c('cold', 'medium', 'hot', 'medium', 'hot', 'hot')
fact.temps <- factor(temps, ordered = T, levels = c('cold', 'medium', 'hot'))
summary(fact.temps)
  #Data Frames
state.x77
USPersonalExpenditure
women
data() #list of all the data sets in the built n data set package in R
str(state.x77)
summary(state.x77)
  # Some made up weather data
days <- c('mon','tue','wed','thu','fri')
temp <- c(22.2,21,23,24.3,25)
rain <- c(TRUE, TRUE, FALSE, FALSE, TRUE)
weather.data = data.frame(days, temp, rain)
weather.data
weather.data$days
subset(weather.data, subset = rain==T)
  #data frama
empty <- data.frame() # empty data frame
c1 <- 1:10 # vector of integers
c2 <- letters[1:10] # vector of strings
df <- data.frame(col.name.1=c1,col.name.2=c2)
df$newcol <- 2*df$col.name.1
df[,'newcol.copy'] <- df$newcol
any(is.na(df))
  #csv files
write.csv(mtcars, file = 'my.example.csv')
  #excel file
install.packages('readxl')
library(readxl) #to read excell files
excel_sheets('E:/DataSpecialization/DataAnalysis - R programming bootcamp/R-Course-HTML-Notes/R-for-Data-Science-and-Machine-Learning/Data Input and Output with R/Sample-Sales-Data.xlsx')
df <- read_excel('E:/DataSpecialization/DataAnalysis - R programming bootcamp/R-Course-HTML-Notes/R-for-Data-Science-and-Machine-Learning/Data Input and Output with R/Sample-Sales-Data.xlsx', sheet = 'sheet1')
  #lapply is used to apply a funtion to whole object
entire.worksheet <- lapply(excel_sheets('E:/DataSpecialization/DataAnalysis - R programming bootcamp/R-Course-HTML-Notes/R-for-Data-Science-and-Machine-Learning/Data Input and Output with R/Sample-Sales-Data.xlsx'), read_excel, path = 'E:/DataSpecialization/DataAnalysis - R programming bootcamp/R-Course-HTML-Notes/R-for-Data-Science-and-Machine-Learning/Data Input and Output with R/Sample-Sales-Data.xlsx')
  #write in excel file
#The downloaded source packages are in
#'C:\Users\mohammadi\AppData\Local\Temp\RtmpWQgBWS\downloaded_packages'
install.packages('rJava') #you need to have an updated java version, install.packages('xlsxjars') will be installed automatically
install.packages('xlsx')
library(xlsx)
write.xlsx(mtcars, 'output.example.xlsx')
  #sql
install.packages('RODBC')
library(RODBC)
myconn <-odbcConnect("Database_Name", uid="User_ID", pwd="password") #it has errors connecting remote server
myconnection <- odbcDriverConnect('driver={ODBC Driver 13 for SQL Server};server=79.175.154.136,10630;database=MtnPaymnet;uid=simin;pwd=$inn3alaGr!nnz3') #successfully made the connection
table.fetch <- sqlFetch(myconnection, 'Subscription')
test.query <- sqlQuery(myconnection, "SELECT TOP 10 MSISDN FROM Subscription")
close(myconnection)
  #web scraping with R
  #import.io -> to import a websites HTML and css as a csv file
  # add magrittr or dplyr libraries to use pipeline operators
install.packages("dplyr")
library(dplyr)
library(babynames) #example
  #maybe library(XML) or library(xml2) is needed
install.packages('rvest')
library(rvest)
demo(package = 'rvest')
demo(package = 'rvest', topic = 'tripadvisor') #returns empty, maybe names changed in the code
lego_movie <- read_html("http://www.imdb.com/title/tt1490017/")
lego_movie %>% html_nodes("strong span") %>% html_text() %>% as.numeric()
  #for loop on matrix
for(row in 1:nrow(mat)){
  for(col in 1:ncol(mat)){
    print(paste('the element in row:', row,'and col',col,'is:',mat[row,col]))
  }
}
 #function
function.name <- function(input1, input2,input3 = 45){
  #function code
  return()
}
  #apply -> apply a function over list or vector
sample(1:1000, 3) %>% print()
randand <- function(x){
  ran = sample(1:1000, 1) %>% return()
}
v = c(1,2,3)
Sapply(v,randand)
  #or use Anonymous Function that is used for complex problems
sapply(v, function(num){num*2}) %>% print()
  #Math functions cheet sheet -> search for R reference card in google
  #Regular Expressions
  #grepl -> returns logical argument,T/F
  #grep
-------
  #dates 
Sys.Date()
as.Date('NOV-03-90', format = '%b-%d-%y')
as.POSIXct('11:02:30', format = '%H:%M:%S')
strptime('11:02:30', format = '%H:%M:%S')
-------
  #Dplyr : manipulating data
install.packages('dplyr')
install.packages('nycflights13')
filter(flights, month == 11, day == 3, carrier== 'UA') #selecting subset of a data frame
head(arrange(flights,year, month, day, arr_time))
head(select(flights, carrier))
head(rename(flights, airline_carrier = carrier))
distinct(select(flights, carrier)) # it is common to use distinct accompanying select
  # change the data cols 
head(mutate(flights, new_col = arr_delay - dep_delay)) #returns all the cols
head(transmute(flights, new_col = arr_delay * dep_delay)) #returns only the col that you made changes on
  #aggregation on data
summarize(flights, avg_air_time = mean(air_time, na.rm = T)) # removes NA values
sample_frac(flights, 0.1) # samples a fraction of your data in random way 
-------
  #pipe operators = nesting + multiple assignments
df <- data.frame(mtcars)
df %>% filter(mpg>20) %>% sample_n(10) %>% arrange(desc(mpg))
-------
  #Tidyr : cleaning data
  #you can think about gather and spread as pivot table in excel
install.packages('tidyr')
install.packages('data.table') # similar to data frame. main difference is way faster than dataframe 
library(tidyr)
library(data.table)
  #making a data frame to clean
comp <- c(1,1,1,2,2,2,3,3,3)
yr <- c(1998,1999,2000,1998,1999,2000,1998,1999,2000)
q1 <- runif(9, min=0, max=100)
q2 <- runif(9, min=0, max=100)
q3 <- runif(9, min=0, max=100)
q4 <- runif(9, min=0, max=100)
df <- data.frame(comp=comp,year=yr,Qtr1 = q1,Qtr2 = q2,Qtr3 = q3,Qtr4 = q4)
df %>% gather(Quarter, Revenue, Qtr1:Qtr4) # gather gathers together key-pair values. converts columns to rows on a part of a table
  #another example
stocks.gathered <- stocks %>% gather(Stockn, price, X,Y,Z)
stocks.gathered %>% spread(Stockn, price)
  #seperate
df <- data.frame(new.col = c(NA, "a.x", "b.y", "c.z"))
df %>% separate(new.col, c('ABC','XYZ')) #default separate argument is non alpha numeric characters
df <- data.frame(new.col = c(NA, "a-x", "b-y", "c-z", 'N-S'))
df.sep <- df %>% separate(new.col, c('ABC','XYZ'), sep = '-')
df.sep %>% unite(new.joined.col, ABC, XYZ, sep = '***') #unites cols in one col
--------
  #graphics with GGplot2 - seven layers
  #basic layers : geometries/Aesthetics/Data
mtcars %>% ggplot(aes(x=mpg, y=hp)) %>% +geom_point() #geometries/Aesthetics/Data, MilePerGalon to HorsePower
  # customise data visualisation :  coordinates/Statistics/Facest
  # Facets : allows us to put multiple plots on a single canvas
mtcars %>% ggplot(aes(x=mpg, y=hp)) %>% +geom_point() %>% +facet_grid(cyl~.) #different plots for cars with different cylenders count
mtcars %>% ggplot(aes(x=mpg, y=hp)) %>% +geom_point() %>% +facet_grid(cyl~.) %>% +stat_smooth() #adding statistics
mtcars %>% ggplot(aes(x=mpg, y=hp)) %>% +geom_point() %>% +facet_grid(cyl~.) %>% +stat_smooth() %>% +coord_cartesian(xlim = c(15,30)) # layer : limit and change axes
mtcars %>% ggplot(aes(x=mpg, y=hp)) %>% +geom_point() %>% +facet_grid(cyl~.) %>% +stat_smooth() %>% +coord_cartesian(xlim = c(15,30)) %>% +theme_bw() #seventh layer
  # loess() is used for less than 1,000 observations; otherwise mgcv::gam() is used with formula = y ~ s(x, bs = "cs")
-------
  #Histograms
install.packages("ggplot2movies")
library(ggplot2movies)
  #DATA and Aesthetistics - in a histogram you just enter one variable
pl <- movies %>% ggplot(aes(x = rating))
  #Geometry
pl2 <- pl %>% +geom_histogram(binwidth = 0.1, color = 'navy', fill = 'navy', alpha = 0.4)
pl2 <- pl %>% +geom_histogram(binwidth = 0.1, aes(fill=..count..)) #another way of filling plot with meaningful data
pl3 <- pl2 + xlab('movie rating') + ylab('frequency') #adding lable to plot
pl3 + ggtitle('My Title') # adding title 
------
  #scatterplots - continuouse data
df <- mtcars
pl <- ggplot(df, aes(x=wt, y=mpg))
pl + geom_point(alpha= 0.7, size = 3)
pl + geom_point(aes(size=factor(cyl)), alpha = 0.3) #Using size for a discrete variable is not advised
  #if you want to use different size/color/shape ... you need to pass it in aes() not outside
pl + geom_point(aes(shape=factor(cyl),color=factor(cyl)), alpha = 0.7,size=3) # better to use shape for different cyls
  #using hex color code 
  #google hex color or use http://www.color-hex.com/
pl + geom_point(alpha= 0.3, size = 3, color = '#c4f9d4')
  #show scale using color
pl + geom_point(aes(color=hp)) + scale_color_gradient(low = '#c4f0f9', high = 'red') #higher hp cars tend to be heavier 
  #barplots - categorical data
df<- mpg
pl <- df %>% ggplot(aes(x=class))
pl + geom_bar(aes(fill=drv), position = 'dodge')
  #Boxplots - a convenient way of graphically depicting groups of numerical data
  #stock pricing
df <- mtcars
pl <- df %>% ggplot(aes(x=factor(cyl), y=mpg))
pl + geom_boxplot(aes(fill = factor(cyl))) + coord_flip() + theme_classic()
-------
  #2variable plotting with ggplot2
pl <- ggplot(movies, aes(x=year, y=rating))
pl + geom_bin2d(binwidth = c(1,1)) + scale_fill_gradient(low = '#2db2bd', high = '#d41462')
  #another way
install.packages('hexbin')
library(hexbin)
pl + geom_hex() + scale_fill_gradient(low = '#2db2bd', high = '#9a0f47')
#another way
pl + geom_density2d()
-------
  #coordinates and faceting
pl <- ggplot(mpg, aes(x=displ, y=hwy)) + geom_point()
pl + coord_cartesian(xlim = c(2,6), ylim = 0:40) # change the limitation
pl + coord_fixed(ratio = 7/40)# change aspect ratio of the plot
pl + facet_grid(.~cyl)
pl + facet_grid(drv~.)
pl + facet_grid(drv~cyl) #two dimentional faceting
-------
  #theme
theme_set(theme_light())# setting a theme for all the plots you are going to draw
pl <- ggplot(mtcars, aes(x=wt,y=mpg)) + geom_point()
pl +  theme_minimal() # set theme mannually for each plot
install.packages('ggthemes')
library(ggthemes)
pl +  theme_economist()
-------
  #ggplot2 excercise
pl <- ggplot(txhousing, aes(x=sales, y=volume))
pl + geom_point(size = 3, color = 'blue', alpha = 0.5) + geom_smooth(stat = 'smooth', color = 'red')
-------
    # Data visualization project
    # E:\DataSpecialization\DataAnalysis - R programming bootcamp\R-Course-HTML-Notes\R-for-Data-Science-and-Machine-Learning\Training Exercises\Capstone and Data Viz Projects\Data Visualization Project
  library(data.table)
df <- fread('E:/DataSpecialization/DataAnalysis - R programming bootcamp/R-Course-HTML-Notes/R-for-Data-Science-and-Machine-Learning/Training Exercises/Capstone and Data Viz Projects/Data Visualization Project/Economist_Assignment_Data.csv', drop = 1)
pl <- ggplot(df, aes(x=CPI, y=HDI)) + geom_point(aes(color=factor(Region)), size = 3, shape = 1) + geom_smooth(aes(group = 1),formula = y~log(x),se=FALSE, color = 'red', method = 'lm')
pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")
pl2 <- pl + geom_text(aes(label = Country),color = "gray20", data = subset(df, Country %in% pointsToLabel),check_overlap = TRUE) + theme_economist_white()
pl2 + ggtitle('Corruption and Human Development') +scale_x_continuous(name = "Corruption Perceptions Index, 2011 (10=least corrupt)", limits = c(.9, 10.5),breaks=1:10) + scale_y_continuous(name = "Human Development Index, 2011 (1=Best)", limits = c(0.2, 1.0))
-------
  # interactive visualization with plotly
  # website : https://plot.ly/
install.packages('plotly')
library(ggplot2)
library(plotly)
df <- ggplot(mtcars, aes(mpg,wt)) + geom_point()
ggplotly(df) #converting a simple ggplot to an interactive plot
  # https://plot.ly/ggplot2/
