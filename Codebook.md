# Coursera: Getting and Cleaning Data Course Project
## Author: Yogesh Chaudhari

This is an R Markdown document for the `tidy_data.txt` file in this repo.

### Data File:
This file is tab delimited datafile created by the R program `run_analysis.R`. 

### Variables: 
The `tidy_data.txt` file contains average of means and standard deviation for all the observations grouped by activity and subject. Following are the unique activities in the dataset:

- WALKING
- WALKING_UPSTAIRS
- WALKING_DOWNSTAIRS
- SITTING
- STANDING
- LAYING

### Cleanup Approach:
The libraries used for the analysis are dplyr, tidyr and stringr. Following approach was adopted to created the `tidy_data.txt` dataset:

- Read label names for the observations
- Read the reference table for Activities and assign the column names
- Read data from test folder
- Add the identifier for the data source here to identify where data came from
- Adding new column here mutate is erroring out on testData
- Assign column names to the test data sets 
- Attach subject, x_test and y_test horizontally 
- Read training data folder
- Add the identifier for the data source here to identify where data came from
- Adding new column here mutate is erroring out on traindata
- Assign column names to the train data sets 
- Attach subject, x_test and y_test horizontally 

After above steps following commands were executed to do following: 

1. Merges the training and the test sets to create one data set.
finalData <- rbind(trainData, testData)


2. Extracts only the measurements on the mean and standard deviation for each measurement.
reqCols <- grepl("subjectid|activityid|mean|std", names(finalData))
meanstd <- finalData[, reqCols]


3. Uses descriptive activity names to name the activities in the data set. Following syntax will join the dataset to the activity labels dataset

4. Appropriately labels the data set with descriptive variable names and assign the new column names

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

 



