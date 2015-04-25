# Use required packages
library(sqldf)

# Set my working directory
setwd("~/Coursera/C3 - Getting and Cleaning Data/Course Project/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset")

# Read the test and train text files
subj_test <- read.csv("./test/subject_test.txt", header=FALSE)
y_test <- read.csv("./test/y_test.txt", header=FALSE)
subj_train <- read.csv("./train/subject_train.txt", header=FALSE)
y_train <- read.csv("./train/y_train.txt", header=FALSE)
x_test <- read.table("./test/X_test.txt", header=FALSE)
x_train <- read.table("./train/X_train.txt", header=FALSE)

# Apply appropriate common variable names to the data
colnames(y_test) <- "activity"
colnames(y_train) <- "activity"
colnames(subj_test) <- "subj_id"
colnames(subj_train) <- "subj_id"

# Read the features text file and apply a meaningful variable name
features <- read.csv("features.txt", header=FALSE, sep=" ")
features <- subset(features, select=-c(V1))
colnames(features) <- "feature"

# Apply the variable names from features to the test and train X data
colnames(x_test) <- features[1:561,]
colnames(x_train) <- features[1:561,]

# Only keep variables with mean() or std() in the variable name
x_test <- x_test[,grepl("mean\\(\\)|std\\(\\)", names(x_test))]
x_train <- x_train[,grepl("mean\\(\\)|std\\(\\)", names(x_train))]

# Combine the test data and train data separately
test_data <- cbind(subj_test, y_test)
test_data <- cbind(test_data, x_test)
train_data <- cbind(subj_train, y_train)
train_data <- cbind(train_data, x_train)

# Merge the two sets of data to create the full dataset
merged_data <- rbind(test_data, train_data)

# Define the activity labels in a character vector
activity_labels <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LYING_DOWN")

# Change the activity values with the activity labels in the dataset
merged_data <- within(merged_data, activity <- activity_labels[activity])

# Subset the data to an independent tidy dataset
tidy_data <- subset(merged_data, select=c(1:5))

# Rename variables in the independent tidy dataset
colnames(tidy_data) <- c("subject_id", "activity", "mean_body_acceleration_X", "mean_body_acceleration_Y", "mean_body_acceleration_Z")

# Find the means of each variable by subject_id and activity
tidy_data <- sqldf('select subject_id, activity, avg("mean_body_acceleration_X") as mean_body_acceleration_X, avg("mean_body_acceleration_Y") as mean_body_acceleration_Y, avg("mean_body_acceleration_Z") as mean_body_acceleration_Z from tidy_data group by subject_id, activity')

# Write the resulting output to a text file
write.table(tidy_data, file="tidy_data.txt", row.name=FALSE)

#data <- read.table("tidy_data.txt", header=TRUE)
#view(data)