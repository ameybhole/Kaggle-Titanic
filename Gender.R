# Load packages
library(rpart)
library(rpart.plot)
library(RColorBrewer)
library(randomForest)
library(rattle)


# Assign the training set
train <- read.csv("/media/amey/1E02DDE102DDBDC9/Amey/Work/Data A/Assignments/Titanic kaggle/train.csv")

# Assign the testing set
test <- read.csv("/media/amey/1E02DDE102DDBDC9/Amey/Work/Data A/Assignments/Titanic kaggle/test.csv")

# Load all Data
load("/home/amey/Downloads/Data/all_data.RData") 

# Training and testing set
print(train)
print(test)

# Structure of training and test set
str(train)
str(test)

# Passengers that survived vs passengers that passed away

table(train$Survived)
prop.table(table(train$Survived)) 

# Males & females that survived vs males & females that passed away
table(train$Sex, train$Survived)
prop.table(table(train$Sex, train$Survived), 1)

# Create the column child, and indicate whether child or no child
train$Child <- NA
train$Child[train$Age < 18] <- 1
train$Child[train$Age >= 18] <- 0

# Two-way comparison
table(train$Child, train$Survived)
prop.table(table(train$Child, train$Survived), 1)

# Prediction based on gender 
test_one <- test
test_one$Survived <- NA
test_one$Survived[test_one$Sex == 'female'] <- 1 
test_one$Survived[test_one$Sex == 'male'] <- 0
