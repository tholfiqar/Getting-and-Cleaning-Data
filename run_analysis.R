## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# Install required packages
if (!require("data.table")) {
  install.packages("data.table")
}

if (!require("reshape2")) {
  install.packages("reshape2")
}

# Load required packages
require("data.table")
require("reshape2")

# Load and process subject_train & subject_test data.
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)

# Merges the training and the test subject sets to create one subject set.
subject <- rbind(subject_train, subject_test)


# Load and process X_train & X_test data.
features_train <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
features_test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)

# Merges the training and the test features sets to create one features set.
features <- rbind(features_train, features_test)

# Load and process y_train & y_test data.
activity_train <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
activity_test <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)

# Merges the training and the test activity sets to create one activity set.
activity <- rbind(activity_train, activity_test)



# Load data column names
features_names <- read.table("UCI HAR Dataset/features.txt", header = FALSE)

# Load activity label
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)

# Rename columns
colnames(subject) <- "Subject"
colnames(activity) <- "Activity"
colnames(features) <- t(features_names[2])


# Build the Complete Data set
completeData <- cbind(features,activity,subject)


# Extract only the measurements on the mean and standard deviation.
columnsWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(completeData), ignore.case=TRUE)
std_mean <- c(columnsWithMeanSTD, 562, 563)
Data <- completeData[,std_mean]

# Uses descriptive activity names to name the activities in the data set
Data$Activity <- as.character(Data$Activity)
for (i in 1:6){
    Data$Activity[Data$Activity == i] <- as.character(activity_labels[i,2])
}


Data$Activity <- as.factor(Data$Activity)




#  Appropriately labels the data set with descriptive names
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("^t", "Time", names(Data))
names(Data)<-gsub("^f", "Frequency", names(Data))
names(Data)<-gsub("tBody", "TimeBody", names(Data))
names(Data)<-gsub("-mean()", "Mean", names(Data), ignore.case = TRUE)
names(Data)<-gsub("-std()", "STD", names(Data), ignore.case = TRUE)
names(Data)<-gsub("-freq()", "Frequency", names(Data), ignore.case = TRUE)
names(Data)<-gsub("angle", "Angle", names(Data))
names(Data)<-gsub("gravity", "Gravity", names(Data))


Data$Subject <- as.factor(Data$Subject)
Data <- data.table(Data)

# Apply mean function to dataset of Subject and Activity
tidyData <- aggregate(. ~Subject + Activity, Data, mean)

# output the tidyData into a csv file
write.table(tidyData, file = "tidy.csv", row.names = FALSE)
