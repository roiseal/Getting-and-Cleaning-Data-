# Getting and Cleaning Data - Course Project

This is the course project for the Getting and Cleaning Data Coursera course.
The R script, `run_analysis.R`, does the following:

1. Download the dataset into `rawdata` subdirectory - will create it if it does not already exist.
2. Load the activity and feature info
3. Load both the training and test datasets, keeping only those columns which
   reflect a mean or standard deviation
4. Load the activity and subject data for each dataset, and merges those
   columns with the dataset
5. Merge the two datasets
6. Converts the `activityId` and `subjectId` columns into factors
7. Create a tidy dataset that consists of the average (mean) value of each
   variable for each subject and activity pair.

The end result is shown in the file `finalTidySet.txt`   
-  older file `secondTidySet.txt` kept for version history

## Getting-and-Cleaning-Data 
