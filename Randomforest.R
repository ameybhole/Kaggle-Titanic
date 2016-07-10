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

# All data, both training and test set
str(all_data)

# Passenger on row 62 and 830 do not have a value for embarkment. 
# Since many passengers embarked at Southampton, we give them the value S.
# Code all embarkment codes as factors.
all_data$Embarked[c(62,830)] = "S"
all_data$Embarked <- factor(all_data$Embarked)

# Passenger on row 1044 has an NA Fare value. Replace it with the median fare value.
all_data$Fare[1044] <- median(all_data$Fare, na.rm=TRUE)

# To fill the missing age value
# Make a prediction of a passengers Age using the other variables and a decision tree model. 
#  method="anova" is used since we are predicting a continuous variable.
predicted_age <- rpart(Age ~ Pclass + Sex + SibSp + Parch + Fare + Embarked + Title + family_size,
                       data=all_data[!is.na(all_data$Age),], method="anova")
all_data$Age[is.na(all_data$Age)] <- predict(predicted_age, all_data[is.na(all_data$Age),])

# Split the data back into a train set and a test set
train <- all_data[1:891,]
test <- all_data[892:1309,]

# Set seed for reproducibility
set.seed(111)

# Apply the Random Forest Algorithm
my_forest <- randomForest(as.factor(Survived) ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked + Title, 
                          data=train, importance=TRUE, ntree=1000)

# Make prediction using the test set
my_prediction <- predict(my_forest, test)

# Create a data frame with two columns: PassengerId & Survived. Survived contains predictions
my_solution3 <- data.frame(PassengerId = test$PassengerId, Survived = my_prediction)

# Write solution away to a csv file with the name my_solution.csv
write.csv(my_solution3, file = "my_solution3.csv", row.names = FALSE)