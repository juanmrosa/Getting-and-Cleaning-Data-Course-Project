==============================================
Getting and Cleaning Data: Course Project
==============================================
Data set
Human Activity Recognition Using Smartphones
==============================================
The data set includes the following files
- 'README.txt'
    This repo explains how all of the scripts work and how they are connected.

- CodeBook.txt
    This file contains the data to indicate all the variables and summaries calculated, along with units, and the   relevant information.

- run_analysis.R
    This R script has the necessary information to do the following:
    1. Download and unzip the data set file.
    2. Read the data into data frames.
    3. Merge the training and the test sets to create one data set.
    4. Extract only the measurements on the mean and standard deviation for each measurement. 
    5. Use descriptive activity names to name the activities in the data set.
    6. Appropriately label the data set with descriptive variable names. 
    7. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
======================================
tidyData.txt is the exported final data after going through all the steps described above.
======================================