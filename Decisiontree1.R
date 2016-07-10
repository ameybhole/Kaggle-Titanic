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

# Build the decision tree
my_tree_two <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, 
                     data = train, method = "class")

# Visualize the decision tree 
plot(my_tree_two)
text(my_tree_two)

# Plot the tree
fancyRpartPlot(my_tree_two)

# Make prediction using the test set
my_prediction <- predict(my_tree_two, test, type="class")

# Create a data frame with two columns: PassengerId & Survived. Survived contains predictions
my_solution <- data.frame(PassengerId = test$PassengerId , Survived = my_prediction)

# Check that data frame has 418 entries
nrow(my_solution) == 418

# Write solution to a csv file with the name my_solution.csv
write.csv(my_solution,  file = 'my_solution.csv', row.names = FALSE)

# Create a new decision tree 
my_tree_three <-   rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, 
                         data = train, method = "class", control = rpart.control(minsplit = 50, cp = 0))
rpart.control(cp = 0, minsplit = 50)

# Visualize new decision tree
fancyRpartPlot(my_tree_three)
