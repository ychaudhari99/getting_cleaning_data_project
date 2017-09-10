## Load needed libraries
library(dplyr)
library(tidyr)
library(stringr)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFile <- "UCI HAR Dataset.zip"

if (!file.exists(zipFile)) {
        download.file(url, zipFile, mode = "wb")
}

# unzip zip file containing data if data directory doesn't already exist
dataPath <- "UCI HAR Dataset"
if (!file.exists(dataPath)) {
        unzip(zipFile)
}


## Read label names for the observations
features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE)

## Read the reference table for Activities and assign the column names
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)
colnames(activity_labels) <- c("activityid", "activityname")

## Read data from test folder
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)

## Add the identifier for the data source here to identify where data came from
## Adding new column here mutate is erroring out on testData
y_test <- mutate(y_test, datasource = "testdata")

## Assign column names to the test data sets 
colnames(subject_test) <- c("subjectid")
colnames(x_test) <- features[, 2]
colnames(y_test) <- c("activityid", "datasource")

#Attach subject, x_test and y_test horizontally 
testData <- cbind(subject_test, x_test, y_test)
#testData <- mutate(testData, datasource = "testData")

## Read training data folder
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)

## Add the identifier for the data source here to identify where data came from
## Adding new column here mutate is erroring out on traindata
y_train <- mutate(y_train, datasource = "traindata")


## Assign column names to the train data sets 
colnames(subject_train) <- c("subjectid")
colnames(x_train) <- features[, 2]
colnames(y_train) <- c("activityid", "datasource")

#Attach subject, x_test and y_test horizontally 
trainData <- cbind(subject_train, x_train, y_train)
#trainData <- mutate(trainData, datasource = "trainData")
                

## 1. Merges the training and the test sets to create one data set.
finalData <- rbind(trainData, testData)


## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
reqCols <- grepl("subjectid|activityid|mean|std", names(finalData))
meanstd <- finalData[, reqCols]


## 3. Uses descriptive activity names to name the activities in the data set
## Following syntax will join the dataset to the activity labels dataset
meanStdwActivityNames <- merge(x = meanstd, y = activity_labels, all = TRUE, by = "activityid")


## 4. Appropriately labels the data set with descriptive variable names.
cols <- colnames(meanStdwActivityNames)
cols <- gsub("^t", "time", cols)
cols <- gsub("^f", "frequency", cols)
cols <- gsub("\\(\\)", "", cols)
cols <- gsub("-", "", cols)
cols <- gsub("BodyBody", "Body", cols)
cols <- tolower(cols)

## Assign the new column names
colnames(meanStdwActivityNames) <- cols

## 5. From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.

meanStdwActivityNamesMean <- meanStdwActivityNames %>%
                             group_by(meanStdwActivityNames$subjectid, meanStdwActivityNames$activityid, meanStdwActivityNames$activityname) %>%
                             summarize_all(funs(mean))


write.table(meanStdwActivityNamesMean, "./getting_cleaning_project/tidy_data.txt", sep = "\t", quote = FALSE, row.names = FALSE)




