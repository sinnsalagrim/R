# logistic regression
# Multiclass logistic regression - ultinomial regression
# Discriminant Analysis
# Case-control sampling -> epidemiological observational study

require(ISLR)
require(MASS)
#######
# Linear discriminant Analsis
#######
lda.fit = lda(Direction~Lag1+Lag2,data=Smarket, subset=Year<2005)
plot(lda.fit)
smarket.2005 <- subset(Smarket, Year=2005)
lda.pred <- predict(lda.fit, smarket.2005)
lda.pred[1:5,] # error
class(lda.pred)
data.frame(lda.pred)[1:5,]
table(lda.pred$class, smarket.2005$Direction)
mean(lda.pred$class==smarket.2005$Direction)