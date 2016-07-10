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

# Create a new train set with the new variable
train_two <- train
train_two$family_size <- train$SibSp + train$Parch + 1

# Create a new decision tree 
my_tree_four <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked + family_size, data = train_two, method = "class", control = rpart.control(minsplit = 50, cp = 0))

# Visualize new decision tree
fancyRpartPlot(my_tree_four)


train_new = all_data[1:891,]
train_new = subset(train_new , select =  -c(family_size))
test_new = all_data[892:1309,]
test_new = subset(test_new , select =  -c(family_size))

# Create a new decision tree
my_tree_five <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked + Title,
                      data = train_new, method = 'class')

# Visualize new decision tree
fancyRpartPlot(my_tree_five)

# Make prediction using `my_tree_five` and `test_new`
my_prediction <- my_prediction <- predict(my_tree_five, test_new, type = 'class')

# Create a data frame with two columns: PassengerId & Survived. Survived contains predictions
my_solution2 <- data.frame(PassengerId = test_new$PassengerId, Survived = my_prediction)

# Write solution away to a csv file with the name my_solution.csv
write.csv(my_solution2, file = 'my_solution2.csv', row.names = FALSE)
