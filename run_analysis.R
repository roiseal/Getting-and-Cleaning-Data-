#---  Getting and Cleaning Data Course Project R Script
#---  prior to running R script create directory and set working directory as follows:
#---  dir.create("./Getting_And_Cleaning_Data")
#---  setwd("./Getting_And_Cleaning_Data")
#---  download run_analysis.R, Readme.md and CodeBook.md into above mentioned directory
#---  total run time expected under 3 minutes

#---  data file is downloaded into subdirectory  /rawdata (directory will be created if not available aready)
#---  Gesoutting Data from URL
if(!file.exists("./rawdata")){dir.create("./rawdata")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./rawdata/Dataset.zip")

#---  Unzip dataSet to /rawdata directory
unzip(zipfile="./rawdata/Dataset.zip",exdir="./rawdata")

#---  Reading training tables
x_train <- read.table("./rawdata/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./rawdata/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./rawdata/UCI HAR Dataset/train/subject_train.txt")

#---  Reading testing tables 
x_test <- read.table("./rawdata/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./rawdata/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./rawdata/UCI HAR Dataset/test/subject_test.txt")

#---  Reading feature vector 
features <- read.table('./rawdata/UCI HAR Dataset/features.txt')

#---  Reading activity labels 
actLabels = read.table('./rawdata/UCI HAR Dataset/activity_labels.txt')


#---  Assign Column Names
colnames(x_train) <- features[,2] 
colnames(y_train) <- "activityId"
colnames(subject_train) <- "subjectId"    
colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId" 
colnames(actLabels) <- c("activityId","activityType")

#---  Merging all data into one set
merge_train <- cbind(y_train, subject_train, x_train)
merge_test <- cbind(y_test, subject_test, x_test)
setAllInOne <- rbind(merge_train, merge_test)

#--- Extracting only the measurements on the mean and standard deviation for each measurement 
columnNames <- colnames(setAllInOne)

#---  Create vector for  mean and standard deviation content
mean_and_std <- (grepl("activityId" , columnNames) | 
                 grepl("subjectId" , columnNames) | 
                 grepl("mean.." , columnNames) | 
                 grepl("std.." , columnNames) 
                 )
                 
#---  Subset from setAllInOne 
setForMeanAndStd <- setAllInOne[ , mean_and_std == TRUE]

#---  Attach descriptive activity names  
setWithActivityNames <- merge(setForMeanAndStd, actLabels,
                              by="activityId",
                              all.x=TRUE)                              
                              
#--- Creating a second, independent tidy data set 
finalTidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
finalTidySet <- finalTidySet[order(finalTidySet$subjectId, finalTidySet$activityId),]

#--- activityID is used for Sorting an aggregation
#--- activityType column (last column of the set) denotes descriptive Activity Label

#--- Writing  tidy data set in txt file
write.table(finalTidySet, "finalTidySet.txt", row.name=FALSE)
