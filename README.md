### Introduction

This repository contains the resources that are required to be submitted for the Course Project within the Getting & Cleaning Data (getdata-011) course of the Coursera Data Science Specialisation offered by John Hopkins University.

The script, data file and code book represent the submission for the course project for student, Josh Venman for the course commencing Feb 2nd, 2015.

### Contents

##### README.md
This file
##### run_analysis.R
This script performs the processing and analysis required to create the final dataset that forms part of this submission. It requires no input parameters, but does make the following assumptions:-

- The **tidyr** package is installed
- The **data.table** package is installed
- The getdata-projectfiles-UCI HAR Dataset.zip containing the data for the project has been unzipped in to the working directory where this script is run from, creating a sub-folder called **UCI HAR Dataset** that contains all the component files.
- That measurements on the mean and standard deviation for each measurement are those with -std()- or -mean()- in their name.
- That the descriptive names for activities are those found in the activity_labels.txt file. 

The script performs the following functions:-

1. Reads the component files for the training, test and related data
1. Merges the training and the test sets to create one data set.
1. Extracts only the measurements on the mean and standard deviation for each measurement. 
1. Uses descriptive activity names to name the activities in the data set
1. Appropriately labels the data set with descriptive variable names. 
1. From the data set in step 5, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The output from the script is written to two files:-



- **datCombined_HAR.txt** tidy version of complete training and test datasets


- **datTidyFinal_HAR.txt** tidy dataset as required for submission containing the average of each variable for each activity and each subject



##### datTidyFinal_HAR.txt

The file contains the required tidy data set containing 
the average of each variable for each activity and each subject. It was written using the write.table function with row.names=FALSE and can be read back in to R using the following statement (assuming the file is in the working directory):-

*read.table(file="datTidyFinal_HAR.txt")*

A complete description of the contents of the file can be found in the CodeBook.md file in this repository

##### CodeBook.md

This file provides detailed metadata describing the contents of the file, datTidyFinal_HAR.txt

### Is the data tidy?

The data in the file daTidyFinal_HAR.txt is believed to be tidy based on the assertion that:-

- It has one variable per column
- It includes descriptive, human-readable column names
- It has one type of data in the file
- It has one observation per row


### Acknowledgements



[David's Course Project FAQ, David Hood, posted 3rd Feb 2015](https://class.coursera.org/getdata-011/forum/thread?thread_id=69#post-249 "David's Course Project FAQ, David Hood, posted 3rd Feb 2015")

[Tidy Data, Hadley Wickham, Journal of Statistical Software, Vol. 59, Issue 10, Sep 2014](http://www.jstatsoft.org/v59/i10/paper "Tidy Data, Hadley Wickham, Journal of Statistical Software, Vol. 59, Issue 10, Sep 2014")
