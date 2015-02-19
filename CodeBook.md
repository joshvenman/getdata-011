### Code Book - datTidyFinal_HAR.txt

This code book describe the data in the file datTidyFinal_HAR.txt that was created as part of the submission for the Coursera Getting & Cleaning Data course that forms part of the Data Science Specialisation.

This file represents a processed extract of the Human Activity Recognition Using Smartphones Dataset - Version 1.0 from Smartlab - Non Linear Complex Systems Laboratory DITEN - Universit‡ degli Studi di Genova available here:-

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

The file was created by the script run_analysis.R which can be downloaded from this repository:-

[https://github.com/joshvenman/getdata-011/blob/master/run_analysis.R](https://github.com/joshvenman/getdata-011/blob/master/run_analysis.R)

The file was written to disk using R's write.table function and is delimited by spaces. Text strings within the file are surrounded by double quote characters. The file contains the following columns:-

**SubjectId** - the unique id for the subject from the group of 30 volunteers who participated in the study

	Type: integer
	Value Range: 1 - 30

**ActivityType** - the type of activity that the subject was engaged in when the measurement was taken

	Type: chr (max length 18 characters)
	Possible Values: 
1. - WALKING
1. - WALKING_UPSTAIRS
1. - WALKING_DOWNSTAIRS
1. - SITTING
1. - STANDING
1. - LAYING

**Measurement** - the name of the specific mean or standard deviation measure for a signal from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ

	Type: factor (max length 18 characters)
	Possible Values: 
1. tBodyAccMeanX
1. tBodyAccMeanY
1. tBodyAccMeanZ
1. tBodyAccStdX
1. tBodyAccStdY
1. tBodyAccStdZ
1. tGravityAccMeanX
1. tGravityAccMeanY
1. tGravityAccMeanZ
1. tGravityAccStdX
1. tGravityAccStdY
1. tGravityAccStdZ
1. tBodyAccJerkMeanX
1. tBodyAccJerkMeanY
1. tBodyAccJerkMeanZ
1. tBodyAccJerkStdX
1. tBodyAccJerkStdY
1. tBodyAccJerkStdZ
1. tBodyGyroMeanX
1. tBodyGyroMeanY
1. tBodyGyroMeanZ
1. tBodyGyroStdX
1. tBodyGyroStdY
1. tBodyGyroStdZ
1. tBodyGyroJerkMeanX
1. tBodyGyroJerkMeanY
1. tBodyGyroJerkMeanZ
1. tBodyGyroJerkStdX
1. tBodyGyroJerkStdY
1. tBodyGyroJerkStdZ
1. fBodyAccMeanX
1. fBodyAccMeanY
1. fBodyAccMeanZ
1. fBodyAccStdX
1. fBodyAccStdY
1. fBodyAccStdZ
1. fBodyAccJerkMeanX
1. fBodyAccJerkMeanY
1. fBodyAccJerkMeanZ
1. fBodyAccJerkStdX
1. fBodyAccJerkStdY
1. fBodyAccJerkStdZ
1. fBodyGyroMeanX
1. fBodyGyroMeanY
1. fBodyGyroMeanZ
1. fBodyGyroStdX
1. fBodyGyroStdY
1. fBodyGyroStdZ

**MeanValue** - the value of the specific mean or standard deviation measure for a signal from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ

	Type: factor (max length 18 characters)
	Value Range:  -0.9970816 - 0.9745087