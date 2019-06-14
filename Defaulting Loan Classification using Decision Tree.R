# Author: Anupam Maheshwari
# Assignment-3-Part-A
# Step 1 - collecting data 
#(http://archive.ics.uci.edu/ml) 

# Step 2 - exploring and preparing the data #

credit <- read.csv("/Users/anupam/Desktop/credit.csv")
str(credit)

#testing features
table(credit$checking_balance)
table(credit$savings_balance)
summary(credit$months_loan_duration)
summary(credit$amount)
table(credit$default)

# Default- 2
# Non-Default- 1
# Data preparation - creating random training and test datasets

set.seed(12345)
credit_rand <- credit[order(runif(1000)), ]

# Testing for data consistency
summary(credit$amount)
summary(credit_rand$amount)

# testing head() function to examine the first few values in each data frame:
head(credit$amount)
head(credit_rand$amount)

credit_train <- credit_rand[1:900, ]
credit_test <- credit_rand[901:1000, ]
prop.table(table(credit_train$default))
prop.table(table(credit_test$default))

# Step 3, Model training on data

install.packages("C50")
library(C50)

credit_train$default<-as.factor(credit_train$default)
str(credit_train$default)
credit_model <- C5.0(credit_train[-17], credit_train$default)
credit_model

#Check for decision
summary(credit_model)

#Step 4, performance evaluation
credit_pred <- predict(credit_model, credit_test)
library(gmodels)
CrossTable(credit_test$default, credit_pred,
           prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE,
           dnn = c('actual default', 'predicted default'))


#Step 5, performance improvement

credit_boost10 <- C5.0(credit_train[-21], credit_train$default,
                       trials = 10)
credit_boost10

# performance check after improvement
summary(credit_boost10)
credit_boost_pred10 <- predict(credit_boost10, credit_test)
CrossTable(credit_test$default, credit_boost_pred10, prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE, dnn = c('actual default', 'predicted default'))

# Error_cost
error_cost <- matrix(c(0, 1, 4, 0), nrow = 2, dimnames = matrix_dimensions)
error_cost

