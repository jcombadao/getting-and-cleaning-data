#Getting and Cleaning Data Project
#Data Science specialization
#Coursera - John Hopkins Univ.


#The purpose of this project is to demonstrate your ability to collect, work with, and clean
#a data set. The goal is to prepare tidy data that can be used for later analysis. You will
#be graded by your peers on a series of yes/no questions related to the project. You will be
#required to submit:
#1) a tidy data set as described below,
#2) a link to a Github repository with your script for performing the analysis, and
#3) a code book that describes the variables, the data, and any transformations or work that
#you performed to clean up the data called CodeBook.md. You should also include a README.md
#in the repo with your scripts. This repo explains how all of the scripts work and how they
#are connected.  

#One of the most exciting areas in all of data science right now is wearable computing
#- see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing
#to develop the most advanced algorithms to attract new users. The data linked to from the
#course website represent data collected from the accelerometers from the Samsung Galaxy S
#smartphone. A full description is available at the site where the data was obtained: 
  
#http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
#Here are the data for the project: 
#https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


#You should create one R script called run_analysis.R that does the following. 

#install.packages(plyr)
library(plyr)


# 1. Merges the training and the test sets to create one data set.
#note: data files are in folder UCI_HAR_Dataset

#reads train and test data, X data from measurements, Y identifies activities
#each observation in a row, 7352 (~70%) rows to train and 2947 (~30%) to test
x_train <- read.table("UCI_HAR_Dataset/train/X_train.txt")
y_train <- read.table("UCI_HAR_Dataset/train/y_train.txt")

x_test <- read.table("UCI_HAR_Dataset/test/X_test.txt")
y_test <- read.table("UCI_HAR_Dataset/test/y_test.txt")

#reads subject data, identified as 1 to 30
subjectTrain <- read.table("UCI_HAR_Dataset/train/subject_train.txt")
subjectTest <- read.table("UCI_HAR_Dataset/test/subject_test.txt")

# merge observations for X and Y data, by rows
xData <- rbind(x_train, x_test)
yData <- rbind(y_train, y_test)

# merge observations for subject data, by rows
subjectData <- rbind(subjectTrain, subjectTest)
names(subjectData) <- "subject"


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

#read file with the 561 features as rows, names in column 2 
features <- read.table("UCI_HAR_Dataset/features.txt")

# grep command to extract the rows with features with mean() or std() in their names
# from the features file
meanStdFeatures <- grep("-(mean|std)\\(\\)", features[, 2])

# subset the desired columns and put names on it
xData <- xData[,meanStdFeatures]
names(xData) <- features[meanStdFeatures, 2]

# 3. Uses descriptive activity names to name the activities in the data set

#reads the file with descriptions for the activities
activities <- read.table("UCI_HAR_Dataset/activity_labels.txt")

# update values with correct activity names
# data coded as 1:6 in yData is transformed in labels, from activities dataframe
yData[, 1] <- activities[yData[, 1], 2]
names(yData) <- "activity"


# 4. Appropriately labels the data set with descriptive variable names. 

#already done in earlier steps

# merge all the data with full observation
allData <- cbind(subjectData, yData,xData)

# 5. From the data set in step 4, creates a second, independent tidy data set with the
#average of each variable for each activity and each subject.

# note that the fisrt colum is subject ID and the second colum is activity ID
# last 66 columns are activity measurements
# 10299 observations, 30 subjects, 6 types of activities
# output 30*6 = 180 average observations, with different number of observations for each
# pair suubject-activity, see table(allData$subject,allData$activity)

averageData <- ddply(allData, .(subject, activity), function(x) colMeans(x[, 3:68]))
# confirmed by command table(averageData$subject,averageData$activity)

#write to output file
write.table(averageData, "averageData.txt", row.name=FALSE)
