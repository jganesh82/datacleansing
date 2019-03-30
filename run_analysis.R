# Step to download the file and make data available locally
# File download variables
fileName <- "data.zip"
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dirName <- "UCI HAR Dataset"

# Download file if the file is not downloaded already.
if(!file.exists(fileName)){
  download.file(fileUrl,fileName, mode = "wb") 
}

# Unzip the file if not already unzipped.
if(!file.exists(dirName)){
  unzip(fileName, files = NULL, exdir=".")
}


# Read test Data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
data_test <- read.table("UCI HAR Dataset/test/X_test.txt")
activity_test <- read.table("UCI HAR Dataset/test/y_test.txt")

# Read training Data
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
data_train <- read.table("UCI HAR Dataset/train/X_train.txt")
activity_train <- read.table("UCI HAR Dataset/train/y_train.txt")

# Read general Data
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")  

## Steps for data cleansing
# 1. Merges the training and the test sets to create one data set.
dataset <- rbind(data_train,data_test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# grep the cols with mean and std
meanstd <- grep("mean()|std()", features[, 2]) 
dataset <- dataset[,meanstd]


# 4. Appropriately labels the data set with descriptive activity names.
# Create vector of "Clean" feature names by getting rid of "()" apply to the dataset to rename labels.
cleanedNames <- sapply(features[, 2], function(df) {gsub("[()]", "",df)})
names(dataset) <- cleanedNames[meanstd]

# combine test and train of subject data and activity data, give descriptive lables
subject <- rbind(subject_train, subject_test)
names(subject) <- 'subject'
activity <- rbind(activity_train, activity_test)
names(activity) <- 'activity'

# combine subject, activity, and mean and std only data set to create final data set.
dataset <- cbind(subject,activity, dataset)


# 3. Uses descriptive activity names to name the activities in the data set
# group the activity column of dataset, re-name lable of levels with activity_levels, and apply it to dataset.
activity_grp <- factor(dataset$activity)
levels(activity_grp) <- activity_labels[,2]
dataset$activity <- activity_grp


# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# check if reshape2 package is installed
if (!"reshape2" %in% installed.packages()) {
  install.packages("reshape2")
}
library("reshape2")

# melt data to tall skinny data and cast means. Finally write the tidy data to the working directory as "tidy_data.txt"
firstDataSet <- melt(dataset,(id.vars=c("subject","activity")))
secondDataSet <- dcast(firstDataSet, subject + activity ~ variable, mean)
write.table(secondDataSet, "clean_data.txt", sep = ",")