# Author: Anupam Maheshwari
# Assignment-3 Part-B

# Step 1 & 2, Importing the Data
mushrooms <- "https://archive.ics.uci.edu/ml/machine-learning-databases/mushroom/agaricus-lepiota.data"
str(mushrooms)
mushrooms$veil_type <- NULL
table(mushrooms$type)
#installing packages for trainig model
#install.packages("rJava")
#dyn.load('/Library/Java/JavaVirtualMachines/jdk1.8.0_121.jdk/Contents/Home/jre/lib/server/libjvm.dylib')
#install.packages("RWeka")

library(rJava)
library(RWeka)

# Training Model on the Data

# Step4
mushroom_1R <- OneR(type ~ ., data = mushrooms)
mushroom_1R
summary(mushroom_1R)

# Step5, improving the model performance
mushroom_JRip <- JRip(type ~ ., data = mushrooms)
mushroom_JRip