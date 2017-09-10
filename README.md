# Coursera: Getting and Cleaning Data Course Project
## Author: Yogesh Chaudhari

This repository contains following files :

- `README.md` - this file contains information related to the project
- `CodeBook.md` - codebook explaining variables in the dataset
- `run_analysis.R` - R file to manipulate the data provided
- `tidy_data.txt` - text file with the output as per the project

The R script uses libraries dplyr, tidyr, stringr to manipulate and transform the data. Below are the high-level steps involved in the data cleaning: 

- Read data from test and train dataset from the folders for subjects, activity and measurements. The datasets were assigned to data frames testData and trainData.
- Assigned appropriate column names to each dataset 
- Added a new column to each dataset to identify the train and test dataset
- Merged the train and test datasets as finalData
- Extracted the data with required means and standard deviations
- Provided activity names to each row using activity_labels data
- Cleaned up column headers on new dataset
- Summarized the data to get mean for each subject and activity

*NOTE: The data was downloaded manually from the given link and unzipped in to working directory to work on the dataset further*
