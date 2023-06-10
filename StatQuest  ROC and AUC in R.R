#https://github.com/StatQuest/roc_and_auc_demo/blob/master/roc_and_auc_demo.R
#https://www.youtube.com/watch?v=qcvAqAH60Yw&list=PLblh5JKOoLUICTaGLRoHQDuF_7q2GfuJF&index=8
library(pROC)
library(randomForest)

## Generate weight and obesity datasets.

set.seed(420)

num.samples <-100

## genereate 100 values from a normal distribution with
## mean 172 and standard deviation 29, then sort them
weight <-sort(rnorm(n=num.samples, mean=172, sd=29))

## Now we will decide if a sample is obese or not. 
## NOTE: This method for classifying a sample as obese or not
## was made up just for this example.
## rank(weight) returns 1 for the lightest, 2 for the second lightest, ...
##              ... and it returns 100 for the heaviest.
## So what we do is generate a random number between 0 and 1. Then we see if
## that number is less than rank/100. So, for the lightest sample, rank = 1.
## This sample will be classified "obese" if we get a random number less than
## 1/100. For the second lightest sample, rank = 2, we get another random
## number between 0 and 1 and classify this sample "obese" if that random
## number is < 2/100. We repeat that process for all 100 samples
obese <- ifelse((test=(runif(n=num.samples)) < (rank(weight)/100)), yes = 1, no = 0)
obese

## plot the data
plot(x=weight, y=obese)

## fit a logistic regression to the data...
glm.fit=glm(obese ~ weight, family = binomial)
line(weight, glm.fit$fitted.values)

par(pty="s")
roc(obese, glm.fit$fitted.values,
    plot = TRUE, 
    legacy.axes =TRUE, 
    percent = TRUE,
    xlab = "False Positive Percentage",
    ylab = "True Positive Precentage",
    col = "darkblue",
    lwd = 4,
    print.auc = TRUE,
    print.auc.Y=45)
    #print.auc.x=c(100,90),
    #auc.polygon = TRUE,
    #auc.polygo.col = "lightblue")

## If we want to find out the optimal threshold we can store the 
## data used to make the ROC graph in a variable...
roc.info <- roc(obese, glm.fit$fitted.values, legacy.axes = TRUE)

## and then extract just the information that we want from that variable.
roc_df <- data.frame(
  tpp = roc.info$sensitivities*100,
  fpp = (1 - roc.info$specificities)*100,
  thresholds = roc.info$thresholds)

## now let's look at the thresholds between TPP 60% and 80%...
roc_df[roc_df$tpp > 60 & roc_df$tpp < 80,]

## Now let's fit the data with a random forest...
rf.model <- randomForest(factor(obese) ~ weight)

## NOTE: By default, roc() uses specificity on the x-axis and the values range
## from 1 to 0. This makes the graph look like what we would expect, but the
## x-axis itself might induce a headache. To use 1-specificity (i.e. the 
## False Positive Rate) on the x-axis, set "legacy.axes" to TRUE.
## We can calculate the area under the curve...
plot.roc(obese, 
         rf.model$votes[,1],
         plot = TRUE, 
         add = TRUE,
         legacy.axes =TRUE, 
         percent = TRUE,
         xlab = "False Positive Percentage",
         ylab = "True Positive Precentage",
         col = "blue",
         lwd = 4,
         print.auc = TRUE,
         print.auc.y=45)

## Now layer logistic regression and random forest ROC graphs..
plot.roc(obese, rf.model$votes[,1],
    #plot = TRUE, 
    add = TRUE,
    #legacy.axes =TRUE, 
    percent = TRUE,
    #xlab = "False Positive Percentage",
    #ylab = "True Positive Precentage",
    col = "green",
    lwd = 4,
    print.auc = TRUE,
    print.auc.y=45)
legend("bottomright", legend=c("Logisitic Regression", "Random Forest"), col=c("blue", "green"), lwd=4)

par(pty = "m")
