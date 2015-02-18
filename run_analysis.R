# Data Science Specialisation - Getting & Cleaning Data - Course Project
#
# Name:         run_analysis.R
# Purpose:      Perform processing, and generation of tidy data sets from UCI HAR base datasets
# Author:       Josh Venman
# Date:         18th February, 2015
# Dependencies: Requires the data.table and tidyr packages to be installed
# Inputs:       https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#                unzipped in to the directory where this script resides - creates a UCI HAR Dataset folder
# Outputs:      CSV File: datCombined_HAR.txt - tidy version of combined test and training datasets
#               CSV File: datTidyFinal_HAR.txt - final tidy dataset for Step 4 of project

# High level goals of the script
#
# 1 - Merges the training and the test sets to create one data set.
# 2 - Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3 - Uses descriptive activity names to name the activities in the data set
# 4 - Appropriately labels the data set with descriptive variable names. 
# 5 - From the data set in step 4, creates a second, independent tidy data set with the average of 
#     each variable for each activity and each subject.


prettyColNames <- function(df) {
        
        # Function to "pretty" dataframe column names
        newcols <- c()
        # Traverse list of column names
        for (thiscol in colnames(df)) {
                # 1 - Remove double parentheses characters
                cn <- gsub("\\()","",thiscol)
                # 2 - Uppercase mean in name
                cn <- gsub("-mean-","Mean",cn)
                # 3 - Uppercase std in name and return
                cn <- gsub("-std-","Std",cn)
                newcols <- c(newcols,cn)
        }
        # Pass modfied column names back in to dataframe
        colnames(df) <- newcols
        # Return updated dataframe
        df
}

processHARData <- function(dataType) {
        # Function to pre-process the UCI HAR test and training datasets. The function takes one argument
        # which is the type of dataset - trainig or test. It returns a processed dataframe
        # based on the specified type of input data
        #
        # The data is spread across 
        # a number of files as follows (using the training set as an example:-
        
        # train\X_train.txt - observations
        # train\y_train.txt - 1 to 1 relationship with rows in x_train - each row has an activity type code for the obs
        # train\subject_train.txt - 1 to 1 relationship with rows in x_train - each row has an subject id for the obs
        # \activity_labels.txt - text labels for the activity type codes in train\y_train.txt
        # \features.txt - text labels for each measurement (column) in train\X_train.txt
        
        # Establish location of input files - assume UCI HAR Dataset is unzipped in to working directory
        dataRoot <- "UCI HAR Dataset\\"
        dataObsPath <- paste(dataRoot,dataType,"\\",sep="")
        
        # Get generic data - activity types and feature descriptions
        activity_labels <- read.table(paste(dataRoot,"activity_labels.txt",sep=""))
        features <- read.table(paste(dataRoot,"features.txt",sep=""))
        
        # Get the observations, subject ids and activity type codes for the specified data set
        observations <- read.table(file = paste(dataObsPath,"x_",dataType,".txt",sep=""))
        activitycodes <- read.table(file = paste(dataObsPath,"y_",dataType,".txt",sep=""))
        subjects <- read.table(file = paste(dataObsPath,"subject_",dataType,".txt",sep=""))
        
        # Assign description variable names to the dataset based on content of features
        colnames(observations) <- features[,2]
        
        # Add the activity type code column from y_xxxxx to the working dataframe and name the column appropriately
        workingDF <- cbind(observations,activitycodes[,1])
        names(workingDF)[ncol(workingDF)] <- "ActivityType"
        
        # Replace the activity type code with the descriptive activity type from activity_labels
        workingDF <- mutate(workingDF, ActivityType = as.character(activity_labels[ActivityType,2]))
        
        # Add the subject id for the observations from subject_train to the working dataframe and name column
        workingDF <- cbind(workingDF,subjects[,1])
        names(workingDF)[ncol(workingDF)] <- "SubjectId"
        
        # Add a column to indicate the type of observation test or training
        workingDF <- mutate(workingDF, DataSet = dataType)
        
        # Move enriched columns to the beginning of the dataframe
        lastObsCol <- ncol(workingDF) - 3
        workingDF <- workingDF[c(lastObsCol + 3,lastObsCol + 2, lastObsCol + 1, 1:lastObsCol)]
        
        # Extract only the variables on the mean and standard deviation for each measurement
        # Interpreting this as meaning only those with mean() and std() in their names as per the
        # description in features_info.txt
        
        colsOfInterest <- c("DataSet", "SubjectId", "ActivityType")
        for (thiscol in colnames(workingDF)) {
                if (grepl("-std()-",as.character(thiscol), fixed=TRUE) | grepl("-mean()-",as.character(thiscol), fixed=TRUE)) {
                        # It is a column of interest - append it to the vector after making name more readable
                        colsOfInterest <- c(colsOfInterest,as.character(thiscol))
                }
        }
        
        # Use the vector containing the columns of interest to create the final dataframe 
        # with just these columns
        workingDF <- workingDF[, colsOfInterest]      
        
        # Make the column names more readable and return the fully processed dataset
        prettyColNames(workingDF)

        
}

generateTidyData <- function(df) {
        
        # Function to perform the final step of the course project - generating a separate tidy dataset that
        # contains the average of each variable for each activity and each subject
        if(exists("finalData")) { rm(finalData) }
        for (var in colnames(df)[4:ncol(df)]) {
                # Get the mean for each subject and activity type for this variable and append to dataset for all variables
                # Ideas is to get a dataset that looks like this:-
                #
                # SubjectId, ActivityType, VariableName, MeanValue
                #
                
                # Get aggregated mean values for this variable for each subject and activitytype
                varMeans = aggregate(df[var], list(subject = df$SubjectId, activity = df$ActivityType),mean)
                
                # Now use tidyr gather function to get the variable as a row value
                varMeans <- gather(varMeans,variable,var,-activity,-subject)
                
                # Set generic column names
                colnames(varMeans) = c("SubjectId","ActivityType","VariableName","MeanValue")
                
                # And add to the final dataset
                if (!exists("finalData")) {
                        finalData <- varMeans
                } else {
                        finalData <- rbind(finalData,varMeans)   
                }
                
        }
        # Return final composite dataframe
        finalData
}



# Load required libraries
library(plyr)
library(tidyr)



# Process the training and test datasets indvidually and then combine
datTrain <- processHARData("train")
datTest <- processHARData("test")
datCombined <- rbind(datTrain,datTest)

# Output the final combined dataset as a text file in the working directory
write.table(datCombined,file="datCombined_HAR.txt",row.names=FALSE)

# Final step - creates a second, independent tidy data set with the average of 
# each variable for each activity and each subject

datTidy <- generateTidyData(datCombined)
write.table(datTidy,file="datTidyFinal_HAR.txt",row.names=FALSE)


## TODO Create  a link to a Github repository with your script for performing the analysis

## TODO Create a code book for the data

## TODO Create a README.md file to explain the scripts, data etc

