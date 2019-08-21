purchase <- Caravan[,86]
s.purchase <- scale(Caravan[,-86])
test.index <- 1:1000
test.data <- s.purchase[test.index,]
test.purchase <- purchase[test.index]
 train.data <- s.purchase[-test.index,]
 train.purchase <- purchase[-test.index]
 library(class)
 set.seed(101)
 purchase[-test.index]
 predicted.p <- knn(train.data, test.data, train.purchase, k=1)
 head(predicted.p)
 
 missclass.error <- mean(test.purchase != predicted.p )
 missclass.error
 
 # choosing a k value
 
 predicted.p <- NULL # going to be a vectore so better not to set it NAN
 error.rate <- NULL
for(i in 1:20){
  set.seed(101)
  predicted.p <- knn(train.data,test.data,train.purchase, k=i)
  error.rate[i] <- mean(test.purchase != predicted.p)
}
 print(error.rate)
 
# vizualize k elbow method
 library(ggplot2)
k.values <- 1:20
error.df <- data.frame(error.rate, k.values)
ggplot(error.df, aes(x=k.values, y=error.rate)) + geom_point() + geom_line(lty='dotted', color='green')

 
#########
# KMean clustering
########
library(ISLR)
head(iris)
library(ggplot2)
ggplot(iris, aes(Petal.Length, Petal.Width, color = Species))+ geom_point()
set.seed(101)
iris.cluster <- kmeans
iris.cluster <- kmeans(iris[,1:4], 3, nstart=20)
print(iris.cluster)
table(iris.cluster$cluster, iris$Species) #evaluating the model
library(cluster) #visualizing the clusters, only draws 2 features that most explains the variability
clusplot(iris, iris.cluster$cluster, color = T, lables = 0, lines =0)
