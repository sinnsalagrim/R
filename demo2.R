# Machine learning
#supervised learning/ unsupervised learning/ reinforcement learning
model <- lm(log(PINCP, base = 10) ~ AGEP + SEX + COW + SCHL, date = duration) #train your model
dtest$preadLogPINCP <- predict(model, newdate = dtest) #predict off your model using predict function

  #Student performance dataSet
  #find the file here : https://archive.ics.uci.edu/ml/datasets/Student+Performance
df <- read.csv('E:/DataSpecialization/DataAnalysis - R programming bootcamp/R-Course-HTML-Notes/R-for-Data-Science-and-Machine-Learning/Machine Learning with R/student-mat.csv', sep = ';')
any(is.na(df)) #check if there is any Null value
str(df) # checking ig your data is factor of levels or int 
library(ggplot2)
library(ggthemes)
library(dplyr)
#ctrl + shift + s
  # checking correlation between data points
  # Numerics only
num.cols <- sapply(df, is.numeric)
  # filter the numeric data columns and see if there is correlation between each numeric pair
cor.data <- cor(df[,num.cols])
  # visualaising correlations using 'corrgram' and 'corrplot'
install.packages('corrgram')
install.packages('corrplot')
library(corrgram)
library(corrplot)
corrplot(cor.data, method = 'color')
corrgram(df) # It chooses numrics itself, draw corrologram 
corrgram(df,order=TRUE, lower.panel=panel.shade,
         upper.panel=panel.pie, text.panel=panel.txt)
ggplot(df, aes(x=G3)) + geom_histogram(bins = 20, fill = 'blue', alpha = 0.5)
  # part 2 - linear regression
  # split data into train and testing set
install.packages('caTools')
library(caTools)
set.seed(101) # set a seed
  # It just adds a column named 'sample' to your df that contains boolean
sample <- sample.split(df$G3, SplitRatio = 0.7) # split up dample / add the column you want to predict on
trainSet <- subset(df, sample == TRUE) # this is the 70% of train data
testSet <- subset(df, sample == FALSE) # this is the 30% test data
  # general model of building a linear regression is like this : 
  # lm(the one you want to predict ~ the ones used to make the prediction, data)
    # train and build Model
model <- lm(G3 ~. , trainSet)
    # run Model
    # interprete the model
  # call : shows the formula that you used
  # residuals : statistical summary - > difference between actual value and predicted(regression line)
  # less pr, more stars -> the stonger correlation they have
  # goodness of fitting -> higher is better
summary(model)
res <- residuals(model)
res <- as.data.frame(res)
ggplot(res, aes(res)) + geom_histogram()
#pr edictions
g3.prediction <- predict(model, testSet)
result <- cbind(g3.prediction, testSet$G3)
colnames(result) <- c('predicted', 'actual')
result <- as.data.frame(result)
toZero <- function(x){
  if (x<0){
    return(0)
    }else
      {
        return(x)
      }
}# deleting negative values
result$predicted <- sapply(result$predicted, toZero) # apply zero instead of negatives
print('MSE : ')
  ## Mean Squared Error 
mse <- mean((result$predicted-result$actual)^2)
  ##RMSE
print('squared root of mse : ' )
mse^0.5
  # calculating error
    ##SSE : some of squared error
SSE <- sum((result$predicted - result$actual)^2)
    ##SST : sum of squared total
SST <- sum( (mean(df$G3) - result$actual)^2)
R2 <- 1 - SSE/SST
print(' R squared : ')
R2

n = c(2, NA, NA) 
s = c("aa", "bb", NA) 
b = c(TRUE, FALSE, NA) 
c = c(2, 3, 5) 
d = c("aa", NA, "cc") 
e = c(TRUE, NA, TRUE) 
df1 = data.frame(n, s, b, c, d, e)

paste_noNA <- function(x,sep=", ") 
  gsub(", " ,sep, toString(x[!is.na(x) & x!="" & x!="NA"] ) )

sep=" "
df1$x <- apply( df1[ , c(1:6) ] , 1 , paste_noNA , sep=sep)
df1




