require(ISLR)
require(boot)
?cv.glm()
plot(mpg~horsepower, data = Auto)

### LOOCV
glm.fit = glm(mpg~horsepower, data = Auto)
cv.glm(Auto, glm.fit)$delta
# pretty slow
# delta = cross validated predintion error

### lets write a simple function to use formula (5.2)
loocv = function(fit){
  h = lm.influence(fit)$h
  mean((residuals(fit)/(1-h))^2)
}

###lets try it out now
loocv(glm.fit)

cv.error = rep(0,5)
plot(mpg~horsepower, data=Auto)
# still looks so nonlinear


cv.error = rep(0,5)
degree = 1:5
for(d in degree){
  glm.fit = glm(mpg~poly(horsepower, d), data=Auto)
  cv.error[d] = loocv(glm.fit)
}
plot(degree, cv.error, type = "b")

# 10 fold CV
cv.error10 = rep(0,5)
for(d in degree){
  glm.fit = glm(mpg~poly(horsepower, d), data=Auto)
  cv.error10[d] = cv.glm(Auto, glm.fit, K=10)$delta[1]
}
lines(degree,cv.error10,type = "b", col = "red")











