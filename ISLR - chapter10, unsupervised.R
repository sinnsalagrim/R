apply(USArrests, 2, var)

### calculating principle components (PCA)
pca.out = prcomp(USArrests, scale = TRUE)
pca.out
names(pca.out)
biplot(pca.out, scale = 0, cex= 0.5)

### kmean clustering
# it works in many dimentions, but it is most fun to demonstrate in two,
# because we can plot pictures
# lets make some data with clusters. we do this by shifting the means of the point around

# generating fake data
set.seed(101)
x = matrix(rnorm(100*2),100,2)
xmean = matrix(rnorm(8, sd=4),4,2)
which = sample(1:4, 100, replace = TRUE)
x = x+xmean[which,]
plot(x, col=which, pch=19)



