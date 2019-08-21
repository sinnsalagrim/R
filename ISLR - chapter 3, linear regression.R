library(MASS)
library(ISLR)

names(Boston)
plot(medv~lstat, Boston)

#######
#simple linear regression
#######
fit1 <- lm(medv~lstat, data=Boston)
summary(fit1)
abline(fit1, col = 'red')
names(fit1) #what components on it
confint(fit1) # finds confidence intervals for the fit
predict(fit1, data.frame(lstat=c(5,10,15)),interval = 'confidence') # predicted value/lower and upper confidence

#######
#multiple linear regression
#######
fit2 <- lm(medv~lstat+age, data=Boston)
summary(fit2)
fit3 <- lm(medv~., data=Boston)
par(mfrow=c(2,2)) # puts all the plots in one. if you just draw it need to hit enter to see next
plot(fit3)
fit4 <- update(fit3, ~.-age-indus)

#######
# nonlinear terms and interactions
#######
fit5 <- lm(medv~lstat*age, data=Boston) #putting an interaction between 
fit6 <- lm(medv~lstat + I(lstat^2), data=Boston); summary(fit6)
attach(Boston) # makes the named variables in boston available
par(mfrow=c(1,1))
plot(medv~lstat)
points(lstat, fitted(fit6),col = 'red', pch=20) # draws quadratic plot
fit7 = lm(medv~poly(lstat,4)) # another way
points(lstat, fitted(fit7),col = 'blue', pch=20) # draws quadratic plot
plot(1:20, 1:20, pch=1:20, cex=2)

# Qualitative predictors
fix(Carseats) # opens data in data editor
fit1 <- lm(Sales~.+Income:Advertising+Age:Price,Carseats)
summary(fit1)
contrasts(Carseats$ShelveLoc) # how R codes the qualitative variables when putting them in linear model

#writing R function
regplot = function(x,y){
  fit=lm(y~x)
  plot(x,y)
  abline(fit, col='red')
}
regplot = function(x,y, ...){ #... means there are unnamed arguments and lets more arguments to be passed
  fit=lm(y~x, ...)
  plot(x,y, ...)
  abline(fit, col='red')
}
attach(Carseats)
regplot(Price, Sales, xlab='Price', ylab='Sales', col = 'blue', pch = 20)





























