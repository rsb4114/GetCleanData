GetCleanData
============

Coursera - Getting and Cleaning Data

##listing all the related files
run_analysis.R - script file for course project
tidydataset.txt - output file from the script file
getdata-projectfiles-UCI HAR Dataset.zip is the data file to be downloaded from the course project site

##instructions on how to use the script
Extract the data set from the zip file
Place run_analysis.R file in the root folder which has activity_labels.txt, features.txt etc
Once the code is run, it generates "tidydataset.txt" file in the same folder

##Course Questions - description of what the script will do
1.Merges the training and the test sets to create one data set.
An overall master data set for 30 volunteers is created

2.Extracts only the measurements on the mean and standard deviation for each measurement.
Only those variables having names with "-mean()" and "-std()" have been considered for this

3.Uses descriptive activity names to name the activities in the data set
The data in y_test.txt or y_train.txt has been modified with corresponding names from activity_labels.txt

4.Appropriately labels the data set with descriptive variable names. 
The columns in x_test.txt and x_train.txt have been modified with corresponding names from features.txt

5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
For each subject/ volunteer, the average for each variable (the ones from question 2) is computed


