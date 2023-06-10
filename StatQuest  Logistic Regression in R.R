#based on Tutorial Logistic Regression in R, Clearly Explained!!!!
#https://www.youtube.com/watch?v=C4N3_XJJ-jU&list=PLblh5JKOoLUICTaGLRoHQDuF_7q2GfuJF&index=22
#https://github.com/StatQuest/logistic_regression_demo/blob/master/logistic_regression_demo.R
install.packages("cowplot")
library(ggplot2)
library(cowplot)

## http://archive.ics.uci.edu/ml/datasets/Heart+Disease
url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/heart-disease/processed.cleveland.data"
data <- read.csv(url, header=FALSE)

head(data)
colnames(data) <- c(
  "age",
  "sex",# 0 = female, 1 = male
  "cp", # chest pain
  # 1 = typical angina,
  # 2 = atypical angina,
  # 3 = non-anginal pain,
  # 4 = asymptomatic
  "trestbps", # resting blood pressure (in mm Hg)
  "chol", # serum cholestoral in mg/dl
  "fbs",  # fasting blood sugar if less than 120 mg/dl, 1 = TRUE, 0 = FALSE
  "restecg", # resting electrocardiographic results
  # 1 = normal
  # 2 = having ST-T wave abnormality
  # 3 = showing probable or definite left ventricular hypertrophy
  "thalach", # maximum heart rate achieved
  "exang",   # exercise induced angina, 1 = yes, 0 = no
  "oldpeak", # ST depression induced by exercise relative to rest
  "slope", # the slope of the peak exercise ST segment
  # 1 = upsloping
  # 2 = flat
  # 3 = downsloping
  "ca", # number of major vessels (0-3) colored by fluoroscopy
  "thal", # this is short of thalium heart scan
  # 3 = normal (no cold spots)
  # 6 = fixed defect (cold spots during rest and exercise)
  # 7 = reversible defect (when cold spots only appear during exercise)
  "hd" # (the predicted attribute) - diagnosis of heart disease
  # 0 if less than or equal to 50% diameter narrowing
  # 1 if greater than 50% diameter narrowing
)
str(data)
head(data)

## First, convert "?"s to NAs...
data[data == "?"] <- NA
## Now add factors for variables that are factors and clean up the factors
## that had missing data...
data[data$sex == 0,]$sex <- "F"
data[data$sex == 1,]$sex <- "M"
data$sex <- as.factor(data$sex)

data$cp <- as.factor(data$cp)
data$fbs <- as.factor(data$fbs)
data$restecg <- as.factor(data$restecg)
data$exang <- as.factor(data$exang)
data$slope <- as.factor(data$slope)

data$ca <- as.integer(data$ca) # since this column had "?"s in it

data$ca <- as.factor(data$ca)  # ...then convert the integers to factor levels

data$thal <- as.integer(data$thal) # "thal" also had "?"s in it.
data$thal <- as.factor(data$thal)

## This next line replaces 0 and 1 with "Healthy" and "Unhealthy"
data$hd <- ifelse(test=data$hd == 0, yes="Healthy", no="Unhealthy")
data$hd <-as.factor((data$hd))

str(data)


## Now determine how many rows have "NA" (aka "Missing data"). If it's just
## a few, we can remove them from the dataset, otherwise we should consider
## imputing the values with a Random Forest or some other imputation method.
nrow(data[is.na(data$ca) | is.na(data$thal),])
data[is.na(data$ca) | is.na(data$thal),]

nrow(data)
data <- data[!(is.na(data$ca) | is.na(data$thal)),]
nrow(data)

xtabs(~hd + sex, data=data)
    # sex
    # hd            F   M
    # Healthy    71  89
    # Unhealthy  25 112
xtabs(~hd + cp, data=data)
    # cp
    # hd            1   2   3   4
    # Healthy    16  40  65  39
    # Unhealthy   7   9  18 103
xtabs(~ hd + fbs, data=data)
    # fbs
    # hd            0   1
    # Healthy   137  23
    # Unhealthy 117  20
xtabs(~ hd + restecg, data=data)
    # restecg
    # hd           0  1  2
    # Healthy   92  1 67
    # Unhealthy 55  3 79
xtabs(~ hd + exang, data=data)
    # exang
    # hd            0   1
    # Healthy   137  23
    # Unhealthy  63  74
xtabs(~ hd + slope, data=data)
    # slope
    # hd            1   2   3
    # Healthy   103  48   9
    # Unhealthy  36  89  12
xtabs(~ hd + ca, data=data)
    # ca
    # hd            0   1   2   3
    # Healthy   129  21   7   3
    # Unhealthy  45  44  31  17
xtabs(~ hd + thal, data=data)
    # thal
    # hd          3.0 6.0 7.0
    # Healthy   127   6  27
    # Unhealthy  37  12  88

## Now do the actual logistic regression

logistic <- glm(hd~sex, data=data, family="binomial")
summary(logistic)
    # Call:
    #   glm(formula = hd ~ sex, family = "binomial", data = data)
    # 
    # Deviance Residuals: 
    #   Min       1Q   Median       3Q      Max  
    # -1.2765  -1.2765  -0.7768   1.0815   1.6404  
    # 
    # Coefficients:
    #   Estimate Std. Error z value Pr(>|z|)    
    # (Intercept)  -1.0438     0.2326  -4.488 7.18e-06 ***
    #   sexM          1.2737     0.2725   4.674 2.95e-06 ***
    #   ---
    #   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
    # 
    # (Dispersion parameter for binomial family taken to be 1)
    # 
    # Null deviance: 409.95  on 296  degrees of freedom
    # Residual deviance: 386.12  on 295  degrees of freedom
    # AIC: 390.12
    #
    # Number of Fisher Scoring iterations: 4 

## The intercept is the log(odds) a female will be unhealthy. This is because
## female is the first factor in "sex" (the factors are ordered,
## alphabetically by default,"female", "male")


## Now calculate the overall "Pseudo R-squared" and its p-value

## NOTE: Since we are doing logistic regression...
## Null devaince = 2*(0 - LogLikelihood(null model))
##               = -2*LogLikihood(null model)
## Residual deviacne = 2*(0 - LogLikelihood(proposed model))
##                   = -2*LogLikelihood(proposed model)

#using all variables in model
logistic <- glm(hd~., data=data, family="binomial")
summary(logistic)
 
    # Call:
    #   glm(formula = hd ~ ., family = "binomial", data = data)
    # 
    # Deviance Residuals: 
    #   Min       1Q   Median       3Q      Max  
    # -3.0490  -0.4847  -0.1213   0.3039   2.9086  
    # 
    # Coefficients:
    #   Estimate Std. Error z value Pr(>|z|)    
    # (Intercept) -6.253978   2.960399  -2.113 0.034640 *  
    #   age         -0.023508   0.025122  -0.936 0.349402    
    # sexM         1.670152   0.552486   3.023 0.002503 ** 
    #   cp2          1.448396   0.809136   1.790 0.073446 .  
    # cp3          0.393353   0.700338   0.562 0.574347    
    # cp4          2.373287   0.709094   3.347 0.000817 ***
    #   trestbps     0.027720   0.011748   2.359 0.018300 *  
    #   chol         0.004445   0.004091   1.087 0.277253    
    # fbs1        -0.574079   0.592539  -0.969 0.332622    
    # restecg1     1.000887   2.638393   0.379 0.704424    
    # restecg2     0.486408   0.396327   1.227 0.219713    
    # thalach     -0.019695   0.011717  -1.681 0.092781 .  
    # exang1       0.653306   0.447445   1.460 0.144267    
    # oldpeak      0.390679   0.239173   1.633 0.102373    
    # slope2       1.302289   0.486197   2.679 0.007395 ** 
    #   slope3       0.606760   0.939324   0.646 0.518309    
    # ca1          2.237444   0.514770   4.346 1.38e-05 ***
    #   ca2          3.271852   0.785123   4.167 3.08e-05 ***
    #   ca3          2.188715   0.928644   2.357 0.018428 *  
    #   thal6       -0.168439   0.810310  -0.208 0.835331    
    # thal7        1.433319   0.440567   3.253 0.001141 ** 
    #   ---
    #   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
    # 
    # (Dispersion parameter for binomial family taken to be 1)
    # 
    # Null deviance: 409.95  on 296  degrees of freedom
    # Residual deviance: 183.10  on 276  degrees of freedom
    # AIC: 225.1
    # 
    # Number of Fisher Scoring iterations: 6

ll.null <- logistic$null.deviance/-2
ll.proposed <- logistic$deviance/-2

## McFadden's Pseudo R^2 = [ LL(Null) - LL(Proposed) ] / LL(Null)
(ll.null - ll.proposed) / ll.null
    #[1] 0.5533531  R^2 value

## chi-square value = 2*(LL(Proposed) - LL(Null))
## p-value = 1 - pchisq(chi-square value, df = 2-1)
1 - pchisq(2*(ll.proposed - ll.null), df=1)
1 - pchisq((logistic$null.deviance - logistic$deviance), df=1)
    # [1] 0 small value, R^2 not due to dumb luck

## now we can plot the data
predicted.data <- data.frame(
  probability.of.hd=logistic$fitted.values,
  hd=data$hd)

predicted.data <-predicted.data[order(predicted.data$probability.of.hd, decreasing = FALSE),]
predicted.data$rank <- 1:nrow(predicted.data)

## heart disease and color by whether or not they actually had heart disease
ggplot(data=predicted.data, aes(x=rank, y=probability.of.hd)) +
  geom_point(aes(color=hd), alpha=1, shape=4, stroke=2) +
  xlab("Index") +
  ylab("Predicted probability of getting heart disease")

ggsave("heart_disease_probabilities.pdf")
