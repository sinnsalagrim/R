
# ML project 

# https://www.kaggle.com/c/bike-sharing-demand/data
bs <- read.csv('E:/DataSpecialization/DataAnalysis - R programming bootcamp/R-Course-HTML-Notes/R-for-Data-Science-and-Machine-Learning/Training Exercises/Machine Learning Projects/CSV files for ML Projects/bikeshare.csv')

# Exploratory Analysis
# predicte total count of bikes rented in an hour 
ggplot(bs, aes(x=temp, y = count)) + geom_point(aes(color = temp), alpha = 0.1, size = 2) # first plot
#ggplot(bs, aes(x=temp)) + geom_dotplot(aes(fill = factor(colorset)), binwidth = 0.5, drop = TRUE)
bs$datetimeposixD <- as.POSIXct(bs$datetime)
ggplot(bs, aes(x=datetimeposixD, y = count)) + geom_point(aes(color = temp), alpha = 0.7, size = 2) + scale_color_gradient(low = '#39f6e8', high = '#e77d43') #second plot
cor(bs[,c('temp', 'count')])
ggplot(bs, aes(x=factor(season), y = count)) + geom_boxplot(aes(color = factor(season)), alpha = 0.5) # 3rd plot
bs$hour <- format(bs$datetimeposixD, '%H')
ggplot(bs, aes(x=hour, y = count), workingday ==1) + geom_point(aes(color = temp)) 
ggplot(filter(bs, workingday == 1), aes(x=hour, y = count)) + geom_point(aes(color = temp), position=position_jitter(w=1, h=0), alpha = 0.7, size = 2) + scale_color_gradientn(colours = c('dark blue','blue','light blue','light green','yellow','orange','red')) #working days
ggplot(filter(bs, workingday == 0), aes(x=hour, y = count)) + geom_point(aes(color = temp), position=position_jitter(w=1, h=0), alpha = 0.7, size = 2) + scale_color_gradientn(colours = c('dark blue','blue','light blue','light green','yellow','orange','red')) + theme_bw()#nonworking days

  # Building the model
temp.model <- lm(count~temp,bs)
  # How many bike rental counts at 25 c?
  # way 1
6.046 + 9.17 * 25
  # way 2
temp.test <- data.frame(temp = c(25))
predict(temp.model, temp.test)
bs$hour <- sapply(bs$hour, as.numeric)
  # as it is a time series data LM is not a good oprion
model <- lm(count~. - datetime - datetimeposixD - casual - registered - atemp, bs)
summary(model)


