# Introduction

The R file `run_analysis.R` does the 5 steps asked for the project

You should create one R script called run_analysis.R that does the following.  
1. Merges the training and the test sets to create one data set.  
2. Extracts only the measurements on the mean and standard deviation for each measurement.   
3. Uses descriptive activity names to name the activities in the data set.   
4. Appropriately labels the data set with descriptive variable names.   
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  



# Variables

* Data extracted from the dataset: x_train, y_train, x_test, y_test, subject_train and subject_test
* x files contains the measurement for the features
* y files contains the types of activities done by subjects coded as 1:6
* subject files contains the code of the subject coded as 1:30
* xData, yData and subjectData are merges of the train and test sets
* features contains the names of the features measured and store in x files, applied to the columns of x files. Names for activities variable are in the activities, corresponds code 1:6 to the names of activities
* allData merges all data from  subjectData, yData and xData, in that order.
* averageData contains the averages, stored in a averageData.txt file.
